package br.edu.ufrgs.controller;

import br.edu.ufrgs.service.DataManager; // Importação do Service que estava faltando!

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.swing.JTable;

/**
 * Controller responsible for handling HTTP requests related to financial
 * transactions.
 * It manages endpoints for processing financial parameters, validating origins,
 * evaluating risk states, and triggering execution audits.
 *
 * @author Thiago Noll da Fontoura
 * @version 1.1.0
 */
@WebServlet("/processa")
@MultipartConfig
public class ServletMedia extends HttpServlet {
    /**
     * Handles HTTP POST requests for both processing and downloading transaction
     * files.
     * * This method acts as an orchestrator that switches behavior based on the
     * "action" parameter:
     * * process: Expects a multipart CSV file via "inputFileParameter",
     * saves it in the application's data directory, triggers processing through the
     * DataManager, exposes a JTable to the request scope, and registers the output
     * file path into the session.
     * * download: Reads the processed file path from the user's session and
     * streams the raw CSV contents back to the client browser as an attached file
     * download.
     * * * After processing, unless a download pipeline successfully closes the
     * output
     * stream, the request is forwarded to "index.jsp".
     *
     * @param request  The HttpServletRequest context containing command parameters,
     *                 multipart file streams, or session parameters.
     * @param response The HttpServletResponse context used to set headers, stream
     *                 files, or handle dispatcher forwards.
     * @throws ServletException If a servlet-specific error occurs during execution
     *                          or forwarding.
     * @throws IOException      If an input or output exception happens when
     *                          handling file parts or network streams.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "process";
        }

        if (action.equals("process")) {
            request.removeAttribute("error");

            try {
                Part inputFilePart = request.getPart("inputFileParameter");
                String inputFileName = inputFilePart.getSubmittedFileName();

                // Locate the server-side 'data' directory for CSV storage
                String servletPath = request.getServletContext().getRealPath("");
                File rootPath = new File(servletPath).getParentFile().getParentFile();
                File dataPath = new File(rootPath, "data");

                if (!dataPath.exists()) {
                    dataPath.mkdirs();
                }

                // Save the uploaded file to the designated path
                String filePath = dataPath.getAbsolutePath() + File.separator + inputFileName;
                inputFilePart.write(filePath);

                // Process data and return the output JTable
                DataManager dataManager = new DataManager(filePath);

                JTable outputTable = dataManager.getOutputTable();
                request.setAttribute("outputTable", outputTable);

                dataManager.saveProcessedTransactions();

                // Store the output path in the session to skip re-processing on download
                HttpSession session = request.getSession();
                session.setAttribute("outputFilePath", dataManager.getOutputFilePath());

            } catch (Exception e) {
                request.setAttribute("error", "Error processing file: " + e.getMessage());
            }

        } else if (action.equals("download")) {
            request.removeAttribute("error");

            try {
                // Get the output file path from the session
                HttpSession session = request.getSession();
                String outputFilePath = (String) session.getAttribute("outputFilePath");

                if (outputFilePath != null) {
                    File outputFile = new File(outputFilePath);

                    if (outputFile.exists()) {
                        // Configure browser headers to download the CSV as a file attachment
                        response.setContentType("text/csv");
                        response.setHeader("Content-Disposition",
                                "attachment; filename=\"" + outputFile.getName() + "\"");
                        response.setContentLength((int) outputFile.length());

                        // Transmit the file data for user-side download
                        try (FileInputStream inStream = new FileInputStream(outputFile);
                                OutputStream outStream = response.getOutputStream()) {
                            inStream.transferTo(outStream);
                        }

                        return;

                    } else
                        throw new IOException("Processed file not found.");
                } else
                    throw new IOException("Processed file not found.");

            } catch (Exception e) {
                request.setAttribute("error", "Error downloading file: " + e.getMessage());
            }
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
package br.edu.ufrgs.controller;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyString;
import static org.mockito.ArgumentMatchers.contains;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockedConstruction;
import org.mockito.MockitoAnnotations;

import br.edu.ufrgs.service.DataManager;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import javax.swing.JTable;

public class ServletMediaTest {

    // ==========================================================================
    // ========================= Pre-Test Configuration =========================
    // ==========================================================================

    @InjectMocks
    private ServletMedia servletMedia;

    @Mock
    private HttpServletRequest request;

    @Mock
    private HttpServletResponse response;

    @Mock
    private HttpSession session;

    @Mock
    private ServletContext servletContext;

    @Mock
    private RequestDispatcher requestDispatcher;

    @Mock
    private Part part;

    private MockedConstruction<DataManager> mockedDataManager;
    private AutoCloseable closeable;
    private Path tempDir;

    @BeforeEach
    void setUp() throws IOException {

        closeable = MockitoAnnotations.openMocks(this);
        when(request.getRequestDispatcher(anyString())).thenReturn(requestDispatcher);
        tempDir = Files.createTempDirectory("mock_dir");

        File mockContextPath = new File(tempDir.toFile(), "webapps/app/context");
        mockContextPath.mkdirs();

        when(request.getServletContext()).thenReturn(servletContext);
        when(servletContext.getRealPath("")).thenReturn(mockContextPath.getAbsolutePath());

        mockedDataManager = mockConstruction(DataManager.class, (mock, context) -> {
            when(mock.getOutputTable()).thenReturn(new JTable());
            when(mock.getOutputFilePath()).thenReturn("");
        });
    }

    @AfterEach
    void tearDown() throws Exception {
        closeable.close();
        mockedDataManager.close();
        deleteDirectory(tempDir.toFile());
    }

    // ==========================================================================

    private void createTempCSV(String path) throws IOException {
        File csv = new File(path);
        csv.getParentFile().mkdirs();

        try (FileWriter writer = new FileWriter(csv)) {
            writer.write("code,client,value,category,origin,time\n");
            writer.write("T001,Ricardo Souza,150.00,Alimentacao,Brasil,2026-03-23T12:30:00\n");
            writer.write("T002,Desconhecido,450.00,Cassino,Internacional,2026-03-23T02:15:00\n");
        }
    }

    private void deleteDirectory(File directoryToDelete) {
        File[] content = directoryToDelete.listFiles();

        if (content != null)
            for (File f : content)
                deleteDirectory(f);

        directoryToDelete.delete();
    }

    // ==========================================================================

    private static class ServletOutputStreamMock extends jakarta.servlet.ServletOutputStream {
        private final java.io.OutputStream outputStream;

        public ServletOutputStreamMock(java.io.OutputStream outputStream) {
            this.outputStream = outputStream;
        }

        @Override
        public void write(int b) throws IOException {
            outputStream.write(b);
        }

        @Override
        public boolean isReady() {
            return true;
        }

        @Override
        public void setWriteListener(jakarta.servlet.WriteListener writeListener) {
        }
    }

    // ==========================================================================
    // ================================== Tests =================================
    // ==========================================================================

    @Test
    public void testServletAcaoNull() throws Exception {
        when(request.getParameter("action")).thenReturn(null);
        when(request.getPart("inputFileParameter")).thenReturn(part);
        when(part.getSubmittedFileName()).thenReturn("test_transactions.csv");
        when(request.getSession()).thenReturn(session);

        doAnswer(invocation -> {
            String filePath = invocation.getArgument(0);
            createTempCSV(filePath);
            return null;
        }).when(part).write(anyString());

        servletMedia.doPost(request, response);

        verify(request).removeAttribute("error");
        verify(part).write(anyString());
        verify(request).setAttribute(eq("outputTable"), any());
        verify(session).setAttribute(eq("outputFilePath"), anyString());
        verify(requestDispatcher).forward(request, response);
    }

    @Test
    public void testServletAcaoProcess() throws Exception {
        when(request.getParameter("action")).thenReturn("process");
        when(request.getPart("inputFileParameter")).thenReturn(part);
        when(part.getSubmittedFileName()).thenReturn("test_transactions.csv");
        when(request.getSession()).thenReturn(session);

        doAnswer(invocation -> {
            String filePath = invocation.getArgument(0);
            createTempCSV(filePath);
            return null;
        }).when(part).write(anyString());

        servletMedia.doPost(request, response);

        verify(request).removeAttribute("error");
        verify(part).write(anyString());
        verify(request).setAttribute(eq("outputTable"), any());
        verify(session).setAttribute(eq("outputFilePath"), anyString());
        verify(requestDispatcher).forward(request, response);
    }

    @Test
    public void testServletAcaoProcessComDataPath() throws Exception {
        when(request.getParameter("action")).thenReturn("process");
        when(request.getPart("inputFileParameter")).thenReturn(part);
        when(part.getSubmittedFileName()).thenReturn("test_transactions.csv");
        when(request.getSession()).thenReturn(session);

        String servletPath = servletContext.getRealPath("");
        File rootPath = new File(servletPath).getParentFile().getParentFile();
        File dataPath = new File(rootPath, "data");

        assertEquals(false, dataPath.exists());

        if (!dataPath.exists()) {
            dataPath.mkdirs();
        }

        assertEquals(true, dataPath.exists());

        doAnswer(invocation -> {
            String filePath = invocation.getArgument(0);
            createTempCSV(filePath);
            return null;
        }).when(part).write(anyString());

        servletMedia.doPost(request, response);

        verify(request).removeAttribute("error");
        verify(part).write(anyString());
        verify(request).setAttribute(eq("outputTable"), any());
        verify(session).setAttribute(eq("outputFilePath"), anyString());
        verify(requestDispatcher).forward(request, response);
    }

    @Test
    public void testServletAcaoProcessComException() throws Exception {
        when(request.getParameter("action")).thenReturn("process");
        when(request.getPart("inputFileParameter")).thenReturn(part);
        when(part.getSubmittedFileName()).thenReturn("test_transactions.csv");
        when(request.getSession()).thenReturn(session);

        String errorMessage = "File read error.";
        doThrow(new IOException(errorMessage)).when(part).write(anyString());

        servletMedia.doPost(request, response);

        verify(request).removeAttribute("error");
        verify(part).write(anyString());
        verify(request).setAttribute(eq("error"), contains("Error processing file: " + errorMessage));
        verify(request, never()).setAttribute(eq("outputTable"), any());
        verify(session, never()).setAttribute(eq("outputFilePath"), anyString());
        verify(requestDispatcher).forward(request, response);
    }

    @Test
    public void testServletAcaoDownload() throws Exception {
        String testFileName = "test_transactions.csv";
        String testFilePath = tempDir.resolve(testFileName).toString();
        createTempCSV(testFilePath);
        File testFile = new File(testFilePath);

        when(request.getParameter("action")).thenReturn("download");
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("outputFilePath")).thenReturn(testFilePath);

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        when(response.getOutputStream()).thenReturn(new ServletOutputStreamMock(outputStream));

        servletMedia.doPost(request, response);

        verify(response).setContentType("text/csv");
        verify(response).setHeader("Content-Disposition",
                "attachment; filename=\"" + testFileName + "\"");
        verify(response).setContentLength((int) testFile.length());
        verify(requestDispatcher, never()).forward(request, response);
    }

    @Test
    public void testServletAcaoDownloadSemOutputFilePath() throws Exception {
        String testFileName = "test_transactions.csv";
        String testFilePath = tempDir.resolve(testFileName).toString();
        createTempCSV(testFilePath);
        File testFile = new File(testFilePath);

        when(request.getParameter("action")).thenReturn("download");
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("outputFilePath")).thenReturn(null);

        String errorMessage = "Processed file not found.";
        doThrow(new IOException(errorMessage)).when(part).write(anyString());

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        when(response.getOutputStream()).thenReturn(new ServletOutputStreamMock(outputStream));

        servletMedia.doPost(request, response);

        verify(request).setAttribute(eq("error"), contains("Error downloading file: " + errorMessage));
        verify(response, never()).setContentType("text/csv");
        verify(response, never()).setHeader("Content-Disposition",
                "attachment; filename=\"" + testFileName + "\"");
        verify(response, never()).setContentLength((int) testFile.length());
        verify(requestDispatcher).forward(request, response);
    }

    @Test
    public void testServletAcaoDownloadSemOutputFile() throws Exception {
        String testFileName = "test_transactions.csv";
        String testFilePath = tempDir.resolve(testFileName).toString();

        when(request.getParameter("action")).thenReturn("download");
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("outputFilePath")).thenReturn(testFilePath);

        String errorMessage = "Processed file not found.";
        doThrow(new IOException(errorMessage)).when(part).write(anyString());

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        when(response.getOutputStream()).thenReturn(new ServletOutputStreamMock(outputStream));

        servletMedia.doPost(request, response);

        verify(request).setAttribute(eq("error"), contains("Error downloading file: " + errorMessage));
        verify(response, never()).setContentType("text/csv");
        verify(response, never()).setHeader("Content-Disposition",
                "attachment; filename=\"" + testFileName + "\"");
        verify(requestDispatcher).forward(request, response);
    }

}
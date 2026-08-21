package br.edu.ufrgs.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Utility component responsible for generic text file input and output operations.
 * It handles pure I/O mechanisms, reading from and writing to the file system, 
 * without coupling to specific business rules or domain models.
 *
 * @author Lucas Vieira Bagolin
 * @version 1.1.0
 */
public class CSVManager {

    /**
     * Reads a text file line-by-line and extracts its content into a list of strings.
     * It automatically skips the first line (assumed to be the CSV header) to prevent 
     * data conversion errors during the parsing phase in the DataManager. It also 
     * safely ignores any empty lines found within the file.
     *
     * @param inputFile The {@link File} object referencing the raw source file to be read.
     * @return A {@code List<String>} containing all valid, non-empty data lines extracted 
     * from the file (excluding the header).
     */
    public static List<String> readFile(File inputFile) {
        List<String> lines = new ArrayList<>();
        
        try (BufferedReader br = new BufferedReader(new FileReader(inputFile))) {
            String line;
            boolean isFirstLine = true;
            
            while ((line = br.readLine()) != null) {
                // Skips the first line (header) to avoid parsing issues later
                if (isFirstLine) {
                    isFirstLine = false;
                    continue; 
                }
                
                // Ignores empty lines
                if (!line.trim().isEmpty()) {
                    lines.add(line);
                }
            }
        } catch (IOException e) {
            System.err.println("I/O Error while reading the file: " + inputFile.getAbsolutePath());
            e.printStackTrace();
        }
        
        return lines;
    }

    /**
     * Serializes a list of formatted strings and writes them to a target destination file.
     * Each string in the provided dataset is written as a new sequential line in the 
     * output file.
     *
     * @param outputFile The {@link File} object representing the target destination 
     * where the data will be persisted.
     * @param data       A {@code List<String>} containing the formatted data rows, 
     * including the structural header, to be written.
     */
    public static void saveFile(File outputFile, List<String> data) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(outputFile))) {
            for (String line : data) {
                bw.write(line);
                bw.newLine();
            }
        } catch (IOException e) {
            System.err.println("I/O Error while writing to the file: " + outputFile.getAbsolutePath());
            e.printStackTrace();
        }
    }
}
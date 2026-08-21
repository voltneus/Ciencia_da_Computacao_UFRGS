package br.edu.ufrgs.util;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Arrays;
import java.util.List;

/**
 * Test class for the CSVManager utility.
 * Validates the pure I/O operations including file reading capabilities, 
 * header skipping logic, and data persistence accuracy.
 *
 * @author Lucas Vieira Bagolin
 * @version 1.1.0
 */
public class CSVManagerTest {

    private File tempFile;

    /**
     * Initializes a temporary file before each test execution to ensure 
     * an isolated environment and avoid polluting the real file system.
     *
     * @throws IOException If the temporary file creation fails.
     */
    @BeforeEach
    public void setUp() throws IOException {
        tempFile = File.createTempFile("test_transactions", ".csv");
    }

    /**
     * Cleans up the environment after each test by deleting the temporary file.
     */
    @AfterEach
    public void tearDown() {
        if (tempFile.exists()) {
            tempFile.delete();
        }
    }

    /**
     * Tests the reading functionality of the CSVManager.
     * Verifies if the method correctly skips the first header line and 
     * successfully ignores empty or whitespace-only lines.
     *
     * @throws IOException If writing the mock data to the temporary file fails.
     */
    @Test
    public void testReadFileSkipsHeaderAndEmptyLines() throws IOException {
        // Arrange: Populate the temporary file with a header, valid data, and empty lines
        try (FileWriter writer = new FileWriter(tempFile)) {
            writer.write("ID,Client,Value,Category,Origin,Time\n");
            writer.write("TX01,Joao,100.00,Food,BR,2023-10-01T10:00:00Z\n");
            writer.write("\n");
            writer.write("TX02,Isadora,200.00,Tech,US,2023-10-01T11:00:00Z\n");
            writer.write("   \n"); 
        }

        // Act: Read the file using the CSVManager
        List<String> result = CSVManager.readFile(tempFile);

        // Assert: Verify that only the two valid data lines were extracted
        assertEquals(2, result.size());
        assertEquals("TX01,Joao,100.00,Food,BR,2023-10-01T10:00:00Z", result.get(0));
        assertEquals("TX02,Isadora,200.00,Tech,US,2023-10-01T11:00:00Z", result.get(1));
    }

    /**
     * Tests the writing functionality of the CSVManager.
     * Verifies if a given list of strings is correctly written to the target 
     * file without data loss or formatting issues.
     *
     * @throws IOException If reading back the generated file for assertion fails.
     */
    @Test
    public void testSaveFile() throws IOException {
        // Arrange: Create a mock list of strings representing processed transactions
        List<String> dataToSave = Arrays.asList(
            "ID,Client,Value,Category,Origin,Time,Score,Status,Motives",
            "TX01,Joao,100.00,Food,BR,2023-10-01T10:00:00Z,0,APROVADO,Nenhum",
            "TX03,Isadora,9000.00,Eletronicos,US,2023-10-01T03:00:00Z,90,BLOQUEADO,Valor + Internacional + Horario"
        );

        // Act: Save the list to the temporary file
        CSVManager.saveFile(tempFile, dataToSave);

        // Assert: Read the file directly using java.nio to verify the CSVManager's output
        List<String> fileContent = Files.readAllLines(tempFile.toPath());

        assertEquals(3, fileContent.size());
        assertEquals("ID,Client,Value,Category,Origin,Time,Score,Status,Motives", fileContent.get(0));
        assertEquals("TX01,Joao,100.00,Food,BR,2023-10-01T10:00:00Z,0,APROVADO,Nenhum", fileContent.get(1));
        assertEquals("TX03,Isadora,9000.00,Eletronicos,US,2023-10-01T03:00:00Z,90,BLOQUEADO,Valor + Internacional + Horario", fileContent.get(2));
    }
}
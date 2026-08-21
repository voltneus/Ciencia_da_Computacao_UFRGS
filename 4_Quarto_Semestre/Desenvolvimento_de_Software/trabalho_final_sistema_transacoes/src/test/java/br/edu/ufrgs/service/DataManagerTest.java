package br.edu.ufrgs.service;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.io.TempDir;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;

import java.nio.file.Files;
import java.nio.file.Path;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class DataManagerTest {

    private File mockCSV;
    private FileWriter csvWriter;

    @TempDir
    private Path mockDir;

    @BeforeEach
    void setUp() throws IOException {
        File mockDataPath = new File(mockDir.toFile(), "data");
        mockDataPath.mkdirs();

        mockCSV = new File(mockDataPath, "mockCSV.csv");
        csvWriter = new FileWriter(mockCSV);

        csvWriter.write("id_transacao,cliente,valor,categoria,localidade,data_hora\n");
        csvWriter.flush();
    }

    @AfterEach
    void tearDown() throws Exception {
        if (csvWriter != null)
            csvWriter.close();
    }
    // ==========================================================================

    private void writeDefaultTransactions() throws IOException {
        csvWriter.write("T001,Ricardo Souza,150.00,Alimentacao,Brasil,2026-03-23T12:30:00\n");
        csvWriter.write("T002,Beatriz Lima,9500.00,Eletronicos,Brasil,2026-03-23T15:45:00\n");
        csvWriter.write("T003,Desconhecido,450.00,Cassino,Internacional,2026-03-23T02:15:00\n");
        csvWriter.flush();
    }

    // ==========================================================================
    // ================================== Tests =================================
    // ==========================================================================

    @Test
    public void testGetOutputFilePath() throws IOException {
        writeDefaultTransactions();

        DataManager dataManager = new DataManager(mockCSV.getAbsolutePath());

        String outputFilePathTest = mockCSV.getParentFile().getAbsolutePath();
        outputFilePathTest += File.separator + "PROCESSADO-" + mockCSV.getName();

        assertEquals(outputFilePathTest, dataManager.getOutputFilePath());
    }

    @Test
    public void testGenerateOutputTable() throws IOException {
        writeDefaultTransactions();

        DataManager dataManager = new DataManager(mockCSV.getAbsolutePath());

        assertNotNull(dataManager.getOutputTable());
        assertEquals(3, dataManager.getOutputTable().getRowCount());
    }

    @Test
    public void testExtractTransactions() throws IOException {
        writeDefaultTransactions();

        DataManager dataManager = new DataManager(mockCSV.getAbsolutePath());

        assertEquals(3, dataManager.getTransactions().size());
    }

    @Test
    public void testSaveProcessedTransactions() throws IOException {
        writeDefaultTransactions();

        DataManager dataManager = new DataManager(mockCSV.getAbsolutePath());

        dataManager.saveProcessedTransactions();

        File outputFile = new File(dataManager.getOutputFilePath());

        assertTrue(outputFile.exists());
        List<String> savedLines = Files.readAllLines(outputFile.toPath());
        assertEquals(1 + 3, savedLines.size());
        assertTrue(savedLines.get(1).contains("T001"));
        assertTrue(savedLines.get(2).contains("T002"));
        assertTrue(savedLines.get(3).contains("T003"));
    }

    @Test
    public void testConstrutorDataManagerSucesso() throws IOException {
        writeDefaultTransactions();

        DataManager dataManager = new DataManager(mockCSV.getAbsolutePath());

        assertEquals(mockCSV, dataManager.getInputFile());
        assertEquals(3, dataManager.getTransactions().size());
        assertNotNull(dataManager.getOutputTable());
        assertEquals(3, dataManager.getOutputTable().getRowCount());
        assertTrue(dataManager.getOutputFilePath().contains("PROCESSADO-mockCSV.csv"));
    }

    @Test
    public void testConstrutorDataManagerIOExceptionComPathNull() throws IOException {
        IOException e = assertThrows(IOException.class, () -> {
            new DataManager(null);
        });

        assertEquals("Input file path cannot be empty.", e.getMessage());
    }

    @Test
    public void testConstrutorDataManagerIOExceptionComPathVazio() throws IOException {
        IOException e = assertThrows(IOException.class, () -> {
            new DataManager("");
        });

        assertEquals("Input file path cannot be empty.", e.getMessage());
    }

    @Test
    public void testConstrutorDataManagerIOExceptionComPathInvalido() throws IOException {
        IOException e = assertThrows(IOException.class, () -> {
            new DataManager('a' + mockCSV.getAbsolutePath());
        });

        assertEquals("Input file not found.", e.getMessage());
    }

    @Test
    public void testConstrutorDataManagerIOExceptionComPathDeDiretorio() throws IOException {
        IOException e = assertThrows(IOException.class, () -> {
            new DataManager(mockDir.toFile().getAbsolutePath());
        });

        assertEquals("Input file not found.", e.getMessage());
    }

}

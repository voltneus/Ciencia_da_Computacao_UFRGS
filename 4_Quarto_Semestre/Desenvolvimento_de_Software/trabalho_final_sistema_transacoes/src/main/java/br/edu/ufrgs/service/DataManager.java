package br.edu.ufrgs.service;

import br.edu.ufrgs.util.CSVManager;
import br.edu.ufrgs.model.Transaction;
import br.edu.ufrgs.util.OutputTableConfig;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

import java.math.BigDecimal;
import java.time.ZonedDateTime;

/**
 * Service component responsible for managing the financial transactions
 * lifecycle.
 * It coordinates the extraction of raw CSV data, drives the creation of tabular
 * desktop models, and handles the generation and persistence of processed audit
 * files.
 *
 * @author Thiago Noll da Fontoura
 * @version 1.1.0
 */
public class DataManager {

    private File inputFile;
    private String outputFilePath;
    private List<Transaction> data;
    private JTable outputTable;

    /**
     * Constructs a DataManager instance a nd initializes the processing workflow.
     * It binds the input file, parses the transaction records, initializes the
     * user-interface table component, and resolves the target destination path.
     *
     * @param inputFilePath The absolute or relative system path to the source CSV
     *                      file.
     */

    public DataManager(String inputFilePath) throws IOException {
        if (inputFilePath == null || inputFilePath.trim().isEmpty())
            throw new IOException("Input file path cannot be empty.");

        this.inputFile = new File(inputFilePath);
        if (!inputFile.exists() || !inputFile.isFile())
            throw new IOException("Input file not found.");

        this.data = extractTransactions();
        this.outputTable = generateOutputTable();
        this.setOutputFilePath();
    }

    // Tests
    protected File getInputFile() {
        return inputFile;
    }

    // Tests
    protected List<Transaction> getTransactions() {
        return data;
    }

    public JTable getOutputTable() {
        return outputTable;
    }

    public String getOutputFilePath() {
        return this.outputFilePath;
    }

    private void setOutputFilePath() {
        this.outputFilePath = this.inputFile.getParentFile().getAbsolutePath();
        this.outputFilePath += File.separator + "PROCESSADO-" + this.inputFile.getName();
    }

    /**
     * Parses the raw input CSV file and extracts its content into a list of domain
     * models.
     * It reads the file line-by-line, tokenizes comma-separated values, performs
     * necessary type conversions (such as parsing text into {@link BigDecimal} and
     * {@link ZonedDateTime}), and instantiates individual Transaction objects.
     *
     * @param inputFile The {@link File} object referencing the raw financial CSV to
     *                  be read.
     * @return A {@code List<Transaction>} containing all successfully parsed
     *         transaction records.
     */
    protected List<Transaction> extractTransactions() {

        List<Transaction> transactions = new ArrayList<>();
        List<String> transactionStrings = CSVManager.readFile(this.inputFile);

        for (String line : transactionStrings) {

            String[] lineTokens = line.split(",");

            String code = lineTokens[0];
            String client = lineTokens[1];
            BigDecimal value = new BigDecimal(lineTokens[2].trim());
            String category = lineTokens[3];
            String origin = lineTokens[4];
            ZonedDateTime time = ZonedDateTime.parse(lineTokens[5].trim() + 'Z');

            Transaction transaction = new Transaction(code, client, value, category, origin, time);

            transactions.add(transaction);
        }

        return transactions;
    }

    /**
     * Generates a structural Swing JTable component using the loaded transaction
     * data.
     * It maps the domain fields and processed audit evaluation attributes (like
     * risk scores and transaction motives) into a two-dimensional matrix configured
     * with standard index positioning.
     *
     * @return A configured {@link JTable} bound to a stable
     *         {@link DefaultTableModel} for user interface display.
     */
    protected JTable generateOutputTable() {

        String[][] data = new String[this.data.size()][OutputTableConfig.COLUMNS.length];

        int line = 0;

        for (Transaction transaction : this.data) {
            data[line][OutputTableConfig.CODE] = transaction.getCode();
            data[line][OutputTableConfig.CLIENT] = transaction.getClient();
            data[line][OutputTableConfig.VALUE] = transaction.getValue().toString();
            data[line][OutputTableConfig.CATEGORY] = transaction.getCategory();
            data[line][OutputTableConfig.ORIGIN] = transaction.getOrigin();
            data[line][OutputTableConfig.TIME] = transaction.getTime().toString();
            data[line][OutputTableConfig.SCORE] = transaction.getScore().toString();
            data[line][OutputTableConfig.STATUS] = transaction.getStatus();
            String motives = String.join(" + ", transaction.getMotives());
            data[line][OutputTableConfig.MOTIVES] = motives;

            line++;
        }

        DefaultTableModel model = new DefaultTableModel(data, OutputTableConfig.COLUMNS);

        return new JTable(model);
    }

    /**
     * Serializes the current transaction state and writes it back as a structured
     * CSV file.
     * It dynamically generates the standardized header row based on active layout
     * configurations, formats individual object attributes into a tabular
     * comma-separated structure, and streams the compiled dataset to the local
     * filesystem using the resolved output location.
     */
    public void saveProcessedTransactions() {

        List<String> outputFileData = new ArrayList<>();
        String header = String.join(",", OutputTableConfig.COLUMNS);
        outputFileData.add(header);

        for (Transaction transaction : this.data) {
            String motives = String.join(" + ", transaction.getMotives());

            String line = String.format("%s,%s,%s,%s,%s,%s,%s,%s,%s",
                    transaction.getCode(),
                    transaction.getClient(),
                    transaction.getValue().toString(),
                    transaction.getCategory(),
                    transaction.getOrigin(),
                    transaction.getTime().toString(),
                    transaction.getScore().toString(),
                    transaction.getStatus(),
                    motives);

            outputFileData.add(line);
        }

        File outputFile = new File(this.outputFilePath);
        CSVManager.saveFile(outputFile, outputFileData);
    }
}

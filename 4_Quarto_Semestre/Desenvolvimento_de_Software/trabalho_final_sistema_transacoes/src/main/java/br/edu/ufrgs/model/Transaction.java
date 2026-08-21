package br.edu.ufrgs.model;

import java.math.BigDecimal;
import java.time.ZonedDateTime;
import java.util.List;

import br.edu.ufrgs.service.Audit;

/**
 * Represents a financial transaction within the system, holding data regarding
 * the client, financial parameters, origin, risk evaluations, and execution audit states.
 *
 * @author Cristopher de Wallau
 * @version 1.1.0
 */
public class Transaction {
    private String code;
    private String client;
    private BigDecimal value;
    private String category;
    private String origin;
    private ZonedDateTime time;
    private Integer score = 0;
    private String status;
    private List<String> motives = new java.util.ArrayList<>();

    /**
     * Constructs a complete Transaction instance with all required financial and audit parameters.Also,
     * calls verifyStatus to evaluate the transaction's status
     *
     * @param code     The unique identification token of the transaction.
     * @param client   The name or identifier of the client initiating the transaction.
     * @param value    The total financial amount of the operation.
     * @param category The business segment or category of the merchant.
     * @param origin   The country where the transaction originated.
     * @param time     The exact timestamp and timezone of the operation execution.
     * @param status   The target status requested for assignment.
     */
    public Transaction(String code, String client, BigDecimal value, String category, String origin, ZonedDateTime time) {
        this.code = code;
        this.client = client;
        this.value = value;
        this.category = category;
        this.origin = origin;
        this.time = time;
        this.status = Audit.verifyStatus(this);
    }

    public String getStatus() {
        return status;
    }

    public Integer getScore() {
        return score;
    }

    public ZonedDateTime getTime() {
        return time;
    }

    public String getCategory() {
        return category;
    }

    public BigDecimal getValue() {
        return value;
    }

    public String getClient() {
        return client;
    }

    public List<String> getMotives() {
        return motives;
    }

    public String getOrigin() {
        return origin;
    }

    public String getCode() {
        return code;
    }

    public void setScore(Integer score) {
            this.score = score;
    }
    public void addMotive(String motive) {
        this.motives.add(motive);
    }

}
package br.edu.ufrgs.model;

import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import java.time.ZoneId;
import java.time.ZonedDateTime;

import static org.junit.jupiter.api.Assertions.*;

public class TransactionTest {

    @Test
    public void testAddMotive_SingleAddition_ShouldContainMotive() {
        ZonedDateTime safeTime = ZonedDateTime.of(2026, 5, 22, 14, 0, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
                "T001", "Cliente U", BigDecimal.valueOf(100), "Varejo", "Brasil",
                safeTime);
        action.addMotive("Valor Estranho");
        assertEquals(1, action.getMotives().size(), "The list should contain exactly one motive.");
        assertTrue(action.getMotives().contains("Valor Estranho"),
                "The list should contain the motive 'Valor Estranho'.");
    }

    @Test
    public void testAddMotive_MultipleAdditions_ShouldAccumulateMotives() {
        ZonedDateTime safeTime = ZonedDateTime.of(2026, 5, 22, 14, 0, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
                "T002", "Cliente F", BigDecimal.valueOf(100), "Varejo", "Brasil",
                safeTime);
        action.addMotive("Horario Anomalia");
        action.addMotive("Categoria Estranha");
        action.addMotive("Compra Internacional");

        assertEquals(3, action.getMotives().size(), "The list should contain exactly three motives.");
        assertTrue(action.getMotives().contains("Horario Anomalia"));
        assertTrue(action.getMotives().contains("Categoria Estranha"));
        assertTrue(action.getMotives().contains("Compra Internacional"));
    }

    @Test
    public void testAllSimpleGetters() {
        ZonedDateTime testTime = ZonedDateTime.now();
        BigDecimal testValue = BigDecimal.valueOf(250.75);

        Transaction action = new Transaction(
                "T011", "Cliente X", testValue, "Livraria", "Argentina", testTime);

        assertAll("Testing all simple getters",
                () -> assertEquals("T011", action.getCode(), "getCode failed"),
                () -> assertEquals("Cliente X", action.getClient(), "getClient failed"),
                () -> assertEquals(testValue, action.getValue(), "getValue failed"),
                () -> assertEquals("Livraria", action.getCategory(), "getCategory failed"),
                () -> assertEquals("Argentina", action.getOrigin(), "getOrigin failed"),
                () -> assertEquals(testTime, action.getTime(), "getTime failed"));
    }

    @Test
    public void testGetStatus_ReturnsCorrectStatus() {
        // Creating a safe transaction that should be approved
        ZonedDateTime safeTime = ZonedDateTime.of(2026, 5, 22, 14, 0, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
                "T010", "Cliente Teste", BigDecimal.valueOf(100), "Padaria", "Brasil", safeTime);

        // The constructor called the Audit, so the initial status should be APPROVED
        assertEquals("APROVADO", action.getStatus(),
                "The method getStatus should return the status assigned during creation.");
    }

    @Test
    public void testGetStatus_ReturnsSuspeito() {
        // Scenario: Only 'Internacional' (30 points = 'SUSPEITO')
        ZonedDateTime safeTime = ZonedDateTime.of(2026, 5, 22, 14, 0, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
                "T012", "Cliente Y", BigDecimal.valueOf(100), "Padaria", "Internacional", safeTime);

        assertEquals("SUSPEITO", action.getStatus(),
                "The method getStatus should return 'SUSPEITO' when the score is between 30 and 59.");
    }

    @Test
    public void testGetStatus_ReturnsBloqueado() {
        // Scenario: High value (40) + Jewelry (20) = 60 points -> BLOCKED
        ZonedDateTime safeTime = ZonedDateTime.of(2026, 5, 22, 14, 0, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
                "T013", "Cliente Z", BigDecimal.valueOf(15000), "Joalheria", "Brasil", safeTime);

        assertEquals("BLOQUEADO", action.getStatus(),
                "The method getStatus should return 'BLOQUEADO' when the score is 60 or more.");
    }
}
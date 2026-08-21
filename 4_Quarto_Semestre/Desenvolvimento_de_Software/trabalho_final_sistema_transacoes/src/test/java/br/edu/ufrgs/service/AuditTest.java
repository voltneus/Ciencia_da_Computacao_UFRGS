package br.edu.ufrgs.service;

import org.junit.jupiter.api.Test;

import br.edu.ufrgs.model.Transaction;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.math.BigDecimal;
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class AuditTest {

    @Test
    public void testVerifyStatus_ScoreBelow30_ReturnsAprovado() {
        // Safe Case: Normal Value, Common Category, in Brasil, Comercial Hour
        // Expected: 0 score (0 + 0 + 0 + 0)
        ZonedDateTime safeTime = ZonedDateTime.of(2026, 5, 22, 14, 0, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
            "T001", "Cliente A", BigDecimal.valueOf(1500), "Supermercado", "Brasil",
            safeTime
        );

        String status = Audit.verifyStatus(action);

        assertEquals("APROVADO", status, "Transações com score menor que 30 devem ser aprovadas.");
        assertEquals(0, action.getScore(), "O score final deve ser 0.");
    }

    @Test
    public void testVerifyStatus_ScoreAt30_ReturnsSuspeito() {
        // "SUSPEITO" Case: Local is International (30)
        // Expected: 30 score (30 + 0 + 0 + 0)
        ZonedDateTime safeTime = ZonedDateTime.of(2026, 5, 22, 14, 0, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
            "T002", "Cliente B", BigDecimal.valueOf(4500), "Supermercado", "Internacional",
            safeTime
        );

        String status = Audit.verifyStatus(action);

        assertEquals("SUSPEITO", status, "Transações com score entre 30 e 59 devem ser suspeitas.");
        assertEquals(30, action.getScore(), "O score final deve ser 30 (apenas penalidade de localidade).");
    }
    
    @Test
    public void testVerifyStatus_ScoreBetween30And59_ReturnsSuspeito() {
        // "SUSPEITO" Case: Valor is too high
        // Expected: 40 score (40 + 0 + 0 + 0)
        ZonedDateTime safeTime = ZonedDateTime.of(2026, 5, 22, 14, 0, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
            "T003", "Cliente B", BigDecimal.valueOf(9500), "Supermercado", "Brasil",
            safeTime
        );

        String status = Audit.verifyStatus(action);

        assertEquals("SUSPEITO", status, "Transações com score entre 30 e 59 devem ser suspeitas.");
        assertEquals(40, action.getScore(), "O score final deve ser 40 (apenas penalidade de valor).");
    }

    @Test
    public void testVerifyStatus_Score60OrAbove_ReturnsBloqueado() {
        // "BLOQUEADO" Case: High Value (40) + Risky Category (20) = 60 pontos
        // Expected: 60 score
        ZonedDateTime safeTime = ZonedDateTime.of(2026, 5, 22, 14, 0, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
            "T004", "Cliente C", BigDecimal.valueOf(12000), "Joalheria", "Brasil",
            safeTime
        );

        String status = Audit.verifyStatus(action);

        assertEquals("BLOQUEADO", status, "Transações com score 60 ou maior devem ser bloqueadas.");
        assertEquals(60, action.getScore(), "O score final deve ser 60 (valor + categoria).");
    }

    @Test
    public void testVerifyStatus_WorstCaseScenario_ReturnsBloqueado() {
        // Worst-Case Scenario: High Value (40), Risky Category (20), International (30), Dawn (20)
        // Expected: 110 score
        ZonedDateTime criticalTime = ZonedDateTime.of(2026, 5, 22, 3, 30, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
            "T005", "Cliente D", BigDecimal.valueOf(50000), "Cassino", "Las Vegas",
            criticalTime
        );

        String status = Audit.verifyStatus(action);

        assertEquals("BLOQUEADO", status);
        assertEquals(110, action.getScore(), "O score final deve ser 110 (todas as penalidades ativas).");
    }
}
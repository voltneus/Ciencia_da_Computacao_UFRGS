package br.edu.ufrgs.service.verifiers;
import br.edu.ufrgs.model.Transaction;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.time.ZoneId;
import java.time.ZonedDateTime;

public class TimeVerifierTest {

    @Test
    public void testVerifyScore_CriticalTime_Returns20() {
        // Critical Hour: 02:30
        ZonedDateTime criticalTime = ZonedDateTime.of(2026, 5, 22, 2, 30, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
            "T001", "Cliente E", BigDecimal.valueOf(100), "Varejo", "Brasil",
            criticalTime
        );

        int score = TimeVerifier.verifyScore(action);

        assertEquals(20, score, "A pontuação deve ser 20 para transações de madrugada.");
        assertTrue(action.getMotives().contains("Horario"), "O motivo 'Horario' deve ser adicionado.");
    }

    @Test
    public void testVerifyScore_NormalTime_Returns0() {
        // Safe Hour: 14:00
        ZonedDateTime safeTime = ZonedDateTime.of(2026, 5, 22, 14, 0, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
            "T002", "Cliente F", BigDecimal.valueOf(100), "Varejo", "Brasil",
            safeTime 
        );

        int score = TimeVerifier.verifyScore(action);

        assertEquals(0, score, "A pontuação deve ser 0 para transações em horário comercial.");
    }

    @Test
    public void testVerifyScore_LowerThresholdTime_Returns20() {
        // Critical Hour: 23:00
        ZonedDateTime criticalTime = ZonedDateTime.of(2026, 5, 22, 23, 00, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
            "T003", "Cliente E", BigDecimal.valueOf(100), "Varejo", "Brasil",
            criticalTime
        );

        int score = TimeVerifier.verifyScore(action);

        assertEquals(20, score, "A pontuação deve ser 20 para transações de madrugada.");
        assertTrue(action.getMotives().contains("Horario"), "O motivo 'Horario' deve ser adicionado.");
    }

    @Test
    public void testVerifyScore_UpperThresholdTime_Returns20() {
        // Critical Hour: 5:00
        ZonedDateTime criticalTime = ZonedDateTime.of(2026, 5, 22, 05, 00, 0, 0, ZoneId.systemDefault());
        Transaction action = new Transaction(
            "T004", "Cliente E", BigDecimal.valueOf(100), "Varejo", "Brasil",
            criticalTime
        );

        int score = TimeVerifier.verifyScore(action);

        assertEquals(20, score, "A pontuação deve ser 20 para transações de madrugada.");
        assertTrue(action.getMotives().contains("Horario"), "O motivo 'Horario' deve ser adicionado.");
    }
}
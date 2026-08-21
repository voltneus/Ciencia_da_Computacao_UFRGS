package br.edu.ufrgs.service.verifiers;
import br.edu.ufrgs.model.Transaction;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.time.ZonedDateTime;

public class OriginVerifierTest {

    @Test
    public void testVerifyScore_InternationalOrigin_Returns30() {
        Transaction action = new Transaction(
            "T001", "Cliente C", BigDecimal.valueOf(100), "Varejo", "Internacional",
            ZonedDateTime.now()
        );

        int score = OriginVerifier.verifyScore(action);

        assertEquals(30, score, "A pontuação deve ser 30 para transações fora do Brasil.");
        assertTrue(action.getMotives().contains("Internacional"), "O motivo 'Internacional' deve ser adicionado.");
    }

    @Test
    public void testVerifyScore_SpanishOrigin_Returns30() {
        Transaction action = new Transaction(
            "T002", "Cliente C", BigDecimal.valueOf(100), "Varejo", "Espanha",
            ZonedDateTime.now()
        );

        int score = OriginVerifier.verifyScore(action);

        assertEquals(30, score, "A pontuação deve ser 30 para transações fora do Brasil.");
        assertTrue(action.getMotives().contains("Internacional"), "O motivo 'Internacional' deve ser adicionado.");
    }

    @Test
    public void testVerifyScore_NationalOrigin_Returns0() {
        Transaction action = new Transaction(
            "T003", "Cliente D", BigDecimal.valueOf(100), "Varejo", "Brasil",
            ZonedDateTime.now()
        );

        int score = OriginVerifier.verifyScore(action);

        assertEquals(0, score, "A pontuação deve ser 0 para transações originadas no Brasil.");
    }
}
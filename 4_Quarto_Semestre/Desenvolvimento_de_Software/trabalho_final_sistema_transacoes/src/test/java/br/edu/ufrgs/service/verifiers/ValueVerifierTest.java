package br.edu.ufrgs.service.verifiers;
import br.edu.ufrgs.model.Transaction;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.time.ZonedDateTime;

public class ValueVerifierTest {

    @Test
    public void testVerifyScore_AtThreshold_Returns0() {
        // Arrange
        Transaction action = new Transaction(
            "T001", "Cliente A", BigDecimal.valueOf(8000), "Varejo", "Brasil",
            ZonedDateTime.now()
        );

        // Act 
        int score = ValueVerifier.verifyScore(action);

        // Assert 
        assertEquals(0, score, "O score deve ser 0 para valores abaixo de 8000");
    }
    
    @Test
    public void testVerifyScore_AboveThreshold_Returns40() {
        // Arrange
        Transaction action = new Transaction(
            "T002", "Cliente A", BigDecimal.valueOf(8500), "Varejo", "Brasil",
            ZonedDateTime.now()
        );

        // Act 
        int score = ValueVerifier.verifyScore(action);

        // Assert 
        assertEquals(40, score, "O score deve ser 40 para valores acima de 8000");
        assertTrue(action.getMotives().contains("Valor"), "O motivo 'Valor' deve ser adicionado");
    }

    @Test
    public void testVerifyScore_BelowThreshold_Returns0() {
        // Arrange
        Transaction action = new Transaction(
            "T003", "Cliente B", BigDecimal.valueOf(5000), "Varejo", "Brasil",
            ZonedDateTime.now()
        );

        // Act
        int score = ValueVerifier.verifyScore(action);

        // Assert
        assertEquals(0, score, "O score deve ser 0 para valores abaixo de 8000");
    }
}
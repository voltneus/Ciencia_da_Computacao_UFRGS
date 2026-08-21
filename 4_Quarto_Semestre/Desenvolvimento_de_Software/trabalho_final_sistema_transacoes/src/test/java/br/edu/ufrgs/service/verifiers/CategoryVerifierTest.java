package br.edu.ufrgs.service.verifiers;
import br.edu.ufrgs.model.Transaction;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import java.time.ZonedDateTime;

public class CategoryVerifierTest {

    @Test
    public void testVerifyScore_HighRiskCategory_J_Returns20() {
        Transaction action = new Transaction(
            "T001", "Cliente A", BigDecimal.valueOf(100), "Joalheria", "Brasil",
            ZonedDateTime.now()
        );

        int score = CategoryVerifier.verifyScore(action);

        assertEquals(20, score, "A pontuação deve ser 20 para categorias de alto risco (Joalheria).");
        assertTrue(action.getMotives().contains("Categoria"), "O motivo 'Categoria' deve ser adicionado.");
    }

    @Test
    public void testVerifyScore_HighRiskCategory_E_Returns20() {
        Transaction action = new Transaction(
            "T002", "Cliente A", BigDecimal.valueOf(100), "Eletronicos", "Brasil",
            ZonedDateTime.now()
        );

        int score = CategoryVerifier.verifyScore(action);

        assertEquals(20, score, "A pontuação deve ser 20 para categorias de alto risco (Eletronicos).");
        assertTrue(action.getMotives().contains("Categoria"), "O motivo 'Categoria' deve ser adicionado.");
    }

    @Test
    public void testVerifyScore_HighRiskCategory_C_Returns20() {
        Transaction action = new Transaction(
            "T003", "Cliente A", BigDecimal.valueOf(100), "Cassino", "Brasil",
            ZonedDateTime.now()
        );

        int score = CategoryVerifier.verifyScore(action);

        assertEquals(20, score, "A pontuação deve ser 20 para categorias de alto risco (Cassino).");
        assertTrue(action.getMotives().contains("Categoria"), "O motivo 'Categoria' deve ser adicionado.");
    }

    @Test
    public void testVerifyScore_NormalCategory_Returns0() {
        Transaction action = new Transaction(
            "T004", "Cliente B", BigDecimal.valueOf(100), "Farmacia", "Brasil",
            ZonedDateTime.now()
        );

        int score = CategoryVerifier.verifyScore(action);

        assertEquals(0, score, "A pontuação deve ser 0 para categorias comuns.");
    }
}
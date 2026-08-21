package br.edu.ufrgs.service;
import br.edu.ufrgs.model.Transaction;
import br.edu.ufrgs.service.verifiers.*;


/**
 * Provides risk assessment and auditing functionalities for financial operations.
 * This utility class evaluates various transaction parameters to determine its
 * final security status based on an aggregated risk score.
 *
 * @author Gabriel Pieruccini Knopp
 * @version 1.1.0
 */
public class Audit {
   
    /**
     * Evaluates a transaction's parameters to calculate a total risk score and determines its final status.
     * The final score is the sum of individual assessments regarding the transaction's value, category,
     * origin, and time. The provided transaction object is updated with this calculated score.
     *
     * @param action The transaction instance to be audited and evaluated.
     * @return A String representing the transaction's status: 
     *         "BLOQUEADO" if the score is 60 or greater, 
     *         "APROVADO" if the score is strictly less than 30, 
     *         and "SUSPEITO" if the score falls between 30 and 59.
     */
    public static String verifyStatus(Transaction action) {
        int score = ValueVerifier.verifyScore(action) + CategoryVerifier.verifyScore(action) + OriginVerifier.verifyScore(action) + TimeVerifier.verifyScore(action);
        action.setScore(score);
        if(score >= 60)
        {
            return "BLOQUEADO";
        }
        if(score < 30)
        {
            return "APROVADO";
        }
        return "SUSPEITO";
    }
}

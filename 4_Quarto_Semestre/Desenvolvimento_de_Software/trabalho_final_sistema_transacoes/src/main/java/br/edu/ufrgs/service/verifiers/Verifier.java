package br.edu.ufrgs.service.verifiers;

import br.edu.ufrgs.model.Transaction;

/**
 * Defines the contract for transaction risk verification components.
 * Any class implementing this interface must provide specific logic to 
 * evaluate a transaction and generate a corresponding risk score.
 *
 * @author Gabriel Pieruccini Knopp
 * @version 1.1.0
 */
public interface Verifier {

    /**
     * Calculates the specific risk score for a given transaction based on 
     * the criteria defined by the implementing class.
     *
     * @param action The transaction instance to be evaluated.
     * @return An int representing the calculated risk score based on the 
     *         verification rules.
     */
    public int verifyScore(Transaction action);
}
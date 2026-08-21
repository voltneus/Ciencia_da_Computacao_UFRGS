package br.edu.ufrgs.model;

import java.util.List;

public class AnaliseElegibilidade {

    public String analisar(Aluno aluno, List<RegraBolsa> regras) {
        StringBuilder resultado = new StringBuilder();

        RegraBolsa regra = encontrarRegra(aluno, regras);
        if(regra == null){
            resultado.append("Aluno " + aluno.getNome() + " quer uma bolsa que não existe\n");
        } else if (aluno.getNota() < regra.getMediaMinima()) {
            resultado.append("Aluno " + aluno.getNome() + " não é elegível para a bolsa " + regra.getTipoBolsa() + " por nota baixa\n");
        } else if (aluno.getFaltas() > regra.getLimiteFaltas()) {
            resultado.append("Aluno " + aluno.getNome() + " não é elegível para a bolsa " + regra.getTipoBolsa() + " por faltas demais\n");
        } else if (regra.isExigeRendaBaixa() && aluno.getRenda() > regra.getRendaMaxima()) {
            resultado.append("Aluno " + aluno.getNome() + " não é elegível para a bolsa " + regra.getTipoBolsa() + " por renda alta\n");
        } else {
            resultado.append("Aluno " + aluno.getNome() + " é elegível para a bolsa " + regra.getTipoBolsa() + "\n");
        }

        resultado.append("Nota: " + aluno.getNota() + " | Faltas: " + aluno.getFaltas() + " | Renda: " + aluno.getRenda() + "\n");

        return resultado.toString();
    }

    public RegraBolsa encontrarRegra(Aluno aluno, List<RegraBolsa> regras) {
        for (RegraBolsa regra : regras) {
            if (aluno.getBolsa().equals(regra.getTipoBolsa())) {
                return regra;
            }
        }
        return null;
    }
}

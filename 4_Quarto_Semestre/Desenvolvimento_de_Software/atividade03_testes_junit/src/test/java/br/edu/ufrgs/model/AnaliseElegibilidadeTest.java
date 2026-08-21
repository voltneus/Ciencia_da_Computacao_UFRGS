package br.edu.ufrgs.model;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

public class AnaliseElegibilidadeTest {
  @Test
  public void testIniciacaoCientificaComSucesso() {
    AnaliseElegibilidade analise = new AnaliseElegibilidade();
    Aluno aluno = new Aluno("João", 9.0, 2, 0.0, "IniciacaoCientifica");
    RegraBolsa regraIC = new RegraBolsa("IniciacaoCientifica", 8.5, 3, false, 0.0);
    List<RegraBolsa> regras = List.of(regraIC);
    String resultado = analise.analisar(aluno, regras);
    assertTrue(resultado.contains("é elegível para a bolsa"));
  }

  @Test
  public void testAuxilioPermanenciaComSucesso() {
    AnaliseElegibilidade analise = new AnaliseElegibilidade();
    Aluno aluno = new Aluno("Maria", 7.0, 2, 0.0, "AuxilioPermanencia");
    RegraBolsa regraAP = new RegraBolsa("AuxilioPermanencia", 7.0, 5, true, 2500.0);
    List<RegraBolsa> regras = List.of(regraAP);
    String resultado = analise.analisar(aluno, regras);
    assertTrue(resultado.contains("é elegível para a bolsa"));
  }

  @Test
  public void testExtensaoComSucesso() {
    AnaliseElegibilidade analise = new AnaliseElegibilidade();
    Aluno aluno = new Aluno("Carlos", 7.5, 4, 0.0, "Extensao");
    RegraBolsa regraExtensao = new RegraBolsa("Extensao", 7.5, 4, false, 0.0);
    List<RegraBolsa> regras = List.of(regraExtensao);
    String resultado = analise.analisar(aluno, regras);
    assertTrue(resultado.contains("é elegível para a bolsa"));
  }

  @Test
  public void testNotaMinima() {
    AnaliseElegibilidade analise = new AnaliseElegibilidade();
    Aluno aluno = new Aluno("João", 8.0, 2, 0.0, "IniciacaoCientifica");
    RegraBolsa regraIC = new RegraBolsa("IniciacaoCientifica", 8.5, 3, false, 0.0);
    List<RegraBolsa> regras = List.of(regraIC);
    String resultado = analise.analisar(aluno, regras);
    assertTrue(resultado.contains("por nota baixa"));
  }

  @Test
  public void testFaltas() {
    AnaliseElegibilidade analise = new AnaliseElegibilidade();
    Aluno aluno = new Aluno("João", 9.0, 4, 0.0, "IniciacaoCientifica");
    RegraBolsa regraIC = new RegraBolsa("IniciacaoCientifica", 8.5, 3, false, 0.0);
    List<RegraBolsa> regras = List.of(regraIC);
    String resultado = analise.analisar(aluno, regras);
    assertTrue(resultado.contains("por faltas demais"));
  }

  @Test
  public void testRenda() {
    AnaliseElegibilidade analise = new AnaliseElegibilidade();
    Aluno aluno = new Aluno("João", 7.0, 2, 3000.0, "AuxilioPermanencia");
    RegraBolsa regraAP = new RegraBolsa("AuxilioPermanencia", 7.0, 5, true, 2500.0);
    List<RegraBolsa> regras = List.of(regraAP);
    String resultado = analise.analisar(aluno, regras);
    assertTrue(resultado.contains("por renda alta"));
  }

  @Test
  public void testBolsaInexistente() {
    AnaliseElegibilidade analise = new AnaliseElegibilidade();
    Aluno aluno = new Aluno("João", 7.0, 2, 3000.0, "BolsaInexistente");
    List<RegraBolsa> regras = List.of();
    String resultado = analise.analisar(aluno, regras);
    assertTrue(resultado.contains("quer uma bolsa que não existe"));
  }

}
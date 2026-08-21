package br.edu.ufrgs.util;

import org.junit.jupiter.api.Test;

import br.edu.ufrgs.model.RegraBolsa;

import static org.junit.jupiter.api.Assertions.*;
import java.util.List;

public class LeitorCsvTest {
  @Test
  public void testLeitorCsv() {
    LeitorCsv leitor = new LeitorCsv();
    List<RegraBolsa> regras = leitor.ler("regras_bolsa.csv");
    assertNotNull(regras);
    assertFalse(regras.isEmpty());
  }
}

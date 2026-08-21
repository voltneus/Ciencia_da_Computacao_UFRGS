package br.edu.ufrgs.util;

import br.edu.ufrgs.model.RegraBolsa;
import java.util.List;
import java.util.ArrayList;
import java.io.BufferedReader;
import java.io.FileReader;

public class LeitorCsv {
    public List<RegraBolsa> ler(String caminho) {
        List<RegraBolsa> regras = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(caminho))) {
            String linha;
            br.readLine(); // Pula o cabeçalho
            while ((linha = br.readLine()) != null) {
                String[] dados = linha.split(",");
                String tipo = dados[0];
                double media = Double.parseDouble(dados[1]);
                int faltas = Integer.parseInt(dados[2]);
                boolean exigeRenda = Boolean.parseBoolean(dados[3]);
                double rendaMaxima = Double.parseDouble(dados[4]);
                regras.add(new RegraBolsa(tipo, media, faltas, exigeRenda, rendaMaxima));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return regras;
    }
}
package br.edu.ufrgs.model;

public class Aluno {
    private String nome;
    private double nota;
    private int faltas;
    private double renda;
    private String bolsa;

    public Aluno(String nome, double nota, int faltas, double renda, String bolsa) {
        this.nome = nome;
        this.nota = nota;
        this.faltas = faltas;
        this.renda = renda;
        this.bolsa = bolsa;
    }

    public String getNome() {
        return nome;
    }

    public double getNota() {
        return nota;
    }

    public int getFaltas() {
        return faltas;
    }

    public double getRenda() {
        return renda;
    }

    public String getBolsa() {
        return bolsa;
    }
}

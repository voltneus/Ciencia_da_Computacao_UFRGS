package br.edu.ufrgs.model;

public class RegraBolsa {
    private String tipoBolsa;
    private double mediaMinima;
    private int limiteFaltas;
    private boolean exigeRendaBaixa;
    private double rendaMaxima;

    public RegraBolsa(String tipoBolsa, double mediaMinima, int limiteFaltas,
            boolean exigeRendaBaixa, double rendaMaxima) {
        this.tipoBolsa = tipoBolsa;
        this.mediaMinima = mediaMinima;
        this.limiteFaltas = limiteFaltas;
        this.exigeRendaBaixa = exigeRendaBaixa;
        this.rendaMaxima = rendaMaxima;
    }

    public String getTipoBolsa() {
        return tipoBolsa;
    }

    public double getMediaMinima() {
        return mediaMinima;
    }

    public int getLimiteFaltas() {
        return limiteFaltas;
    }

    public boolean isExigeRendaBaixa() {
        return exigeRendaBaixa;
    }

    public double getRendaMaxima() {
        return rendaMaxima;
    }

}
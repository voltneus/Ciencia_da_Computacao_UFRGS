package br.edu.ufrgs.controller;

import br.edu.ufrgs.model.Aluno;
import br.edu.ufrgs.model.RegraBolsa;
import br.edu.ufrgs.util.LeitorCsv;
import br.edu.ufrgs.model.AnaliseElegibilidade;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/processa")
public class ServletMedia extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String nome = request.getParameter("nome");
            double nota = Double.parseDouble(request.getParameter("nota"));
            int faltas = Integer.parseInt(request.getParameter("faltas"));
            double renda = Double.parseDouble(request.getParameter("renda"));
            String bolsa = request.getParameter("bolsa");

            // Uso da classe Model
            Aluno aluno = new Aluno(nome, nota, faltas, renda, bolsa);
            
            LeitorCsv leitor = new LeitorCsv();
            List<RegraBolsa> regras = leitor.ler("regras_bolsa.csv");

            AnaliseElegibilidade analisador = new AnaliseElegibilidade();
            String mensagem = analisador.analisar(aluno, regras);

            request.setAttribute("resultado", mensagem);
            
        } catch (NumberFormatException e) {
            request.setAttribute("resultado", "Erro: Informe uma nota válida.");
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
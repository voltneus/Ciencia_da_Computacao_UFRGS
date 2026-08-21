<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html>

    <body>
        <h2>Lançamento de Notas</h2>
        <form action="processa" method="post">
            Nome: <input type="text" name="nome" required><br><br>
            Nota: <input type="number" step="0.1" name="nota" min="0" max="10" required><br><br>
            Faltas: <input type="number" name="faltas" min="0" required><br><br>
            Renda: <input type="number" name="renda" min="0" required><br><br>
            Bolsa:
            <select name="bolsa" required>
                <option value="" disabled selected>Selecione uma bolsa...</option>
                <option value="IniciacaoCientifica">Iniciação Científica</option>
                <option value="Extensao">Extensão</option>
                <option value="AuxilioPermanencia">Auxílio Permanência</option>
            </select><br><br>

            <button type="submit">Verificar Situação</button>
        </form>

        <%-- Exibe o resultado se ele existir no request --%>
            <% if (request.getAttribute("resultado") !=null) { %>
                <hr>
                <h3>Resultado:</h3>
                <p><strong>
                        <%= request.getAttribute("resultado") %>
                    </strong></p>
                <% } %>
    </body>

    </html>
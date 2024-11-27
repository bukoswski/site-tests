<%@ page language="java" import="java.sql.*, org.json.JSONArray, org.json.JSONObject" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Agendamentos</title>
</head>
<body>
    <h2 style="text-align:center;">Lista de Agendamentos</h2>

    <%
        // Configurações do banco de dados
        String database = "barba";
        String url = "jdbc:mysql://localhost:3306/" + database + "?useSSL=false&serverTimezone=UTC";
        String username = "root";
        String password = "";
        String driver = "com.mysql.jdbc.Driver";

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        JSONArray jsonArray = new JSONArray();

        try {
            // Conectar ao banco de dados
            Class.forName(driver);
            connection = DriverManager.getConnection(url, username, password);

            // Consulta com JOIN para obter o nome do profissional
            String sql = "SELECT agendamentos.horario, agendamentos.dataAgendada, " +
                         "clientes.nomeCliente, profissionais.nomeProfissional, " +
                         "servicos.tipoServico, servicos.preco, servicos.tempoEstimado " +
                         "FROM agendamentos " +
                         "INNER JOIN clientes ON agendamentos.id_cliente = clientes.id_cliente " +
                         "INNER JOIN profissionais ON agendamentos.id_profissional = profissionais.id_profissional " +
                         "INNER JOIN servicos ON agendamentos.id_servico = servicos.id_servico";

            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            // Construir o JSON com os resultados
            while (resultSet.next()) {
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("nomeCliente", resultSet.getString("nomeCliente"));
                jsonObject.put("dataAgendada", resultSet.getString("dataAgendada"));
                jsonObject.put("horario", resultSet.getString("horario"));
                jsonObject.put("tipoServico", resultSet.getString("tipoServico"));
                jsonObject.put("preco", resultSet.getString("preco"));
                jsonObject.put("tempoEstimado", resultSet.getString("tempoEstimado"));
                jsonObject.put("nomeProfissional", resultSet.getString("nomeProfissional"));
                jsonArray.put(jsonObject);
            }

            // Exibir o JSON no HTML
            out.println("<script>var agendamentos = " + jsonArray.toString() + ";</script>");

        } catch (Exception e) {
            out.println("<p style='color:red;'>Erro: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                out.println("<p style='color:red;'>Erro ao fechar recursos: " + e.getMessage() + "</p>");
            }
        }
    %>

    <ul id="listaAgendamentos"></ul>

    <script>
        // Função para exibir os agendamentos na lista
        function mostrarAgendamentos() {
            var lista = document.getElementById('listaAgendamentos');
            agendamentos.forEach(function(agendamento) {
                var li = document.createElement('li');
                li.innerHTML = "Cliente: " + agendamento.nomeCliente + "<br>" +
                               "Data: " + agendamento.dataAgendada + "<br>" +
                               "Horário: " + agendamento.horario + "<br>" +
                               "Tipo de Serviço: " + agendamento.tipoServico + "<br>" +
                               "Preço: R$ " + agendamento.preco + "<br>" +
                               "Tempo Estimado: " + agendamento.tempoEstimado + " minutos<br>" +
                               "Profissional: " + agendamento.nomeProfissional;
                lista.appendChild(li);
            });
        }

        // Chamar a função para mostrar os agendamentos
        mostrarAgendamentos();
    </script>
</body>
</html>

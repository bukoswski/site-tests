<%@ page language="java" import="java.sql.*, org.json.JSONArray, org.json.JSONObject" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Serviços</title>
</head>
<body>
    <h2 style="text-align:center;">Lista de Serviços</h2>

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
            String sql = "SELECT servicos.tipoServico, servicos.preco, servicos.tempoEstimado, profissionais.nomeProfissional " +
                         "FROM servicos " +
                         "INNER JOIN profissionais ON servicos.id_profissional = profissionais.id_profissional " +
                         "WHERE servicos.id_servico = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, 1); // Substitua 1 pelo ID desejado ou use uma variável dinâmica

            resultSet = statement.executeQuery();

            // Exibir os resultados
            while(resultSet.next()){
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("tipoServico", resultSet.getString("tipoServico"));
                jsonObject.put("preco", resultSet.getString("preco"));
                jsonObject.put("tempoEstimado", resultSet.getString("tempoEstimado"));
                jsonObject.put("nomeProfissional", resultSet.getString("nomeProfissional"));
                jsonArray.put(jsonObject); // Adiciona o objeto ao JSONArray
            }

            // Exibir o JSON no HTML
            out.println("<script>var servicos = " + jsonArray.toString() + ";</script>");

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

    <ul id="listaServicos"></ul>

    <script>
        // Função para exibir os serviços na lista
        function mostrarServicos() {
            var lista = document.getElementById('listaServicos');
            servicos.forEach(function(servico) {
                var li = document.createElement('li');
                li.innerHTML = "Tipo de Serviço: " + servico.tipoServico + "<br>" +
                               "Preço: R$ " + servico.preco + "<br>" +
                               "Tempo Estimado: " + servico.tempoEstimado + " minutos<br>" +
                               "Profissional: " + servico.nomeProfissional;
                lista.appendChild(li);
            });
        }

        // Chamar a função para mostrar os serviços
        mostrarServicos();
    </script>
</body>
</html>
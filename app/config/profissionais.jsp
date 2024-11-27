<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
<h2 style="text-align:center;">Lista de Profissionais</h2>
    <%
    String database = "barba";
    String url = "jdbc:mysql://localhost:3306/" + database + "?useSSL=false&serverTimezone=UTC";
    String username = "root";
    String password = "";
    String driver = "com.mysql.jdbc.Driver"; // Driver atualizado

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        // Carregar o driver
        Class.forName(driver);

        // Conectar ao banco de dados
        connection = DriverManager.getConnection(url, username, password);

        // Verificar se o usuário existe (substitua '1' pelo ID desejado)
        String sql = "SELECT * FROM profissionais WHERE id_profissional = ?"; // se tirar essa tag ele ira trazer todos os nomes da tabela
        statement = connection.prepareStatement(sql);
        statement.setInt(1, 1); // Definir o valor do parâmetro (exemplo: ID 1) , se tirar essa tag ele ira trazer todos os nomes da tabela

        resultSet = statement.executeQuery();

        // Exibir os resultados
        while (resultSet.next()) {
            out.println("<p>Nome do Profissional: " + resultSet.getString("nomeProfissional") + "</p>");
        }
    } catch (Exception e) {
        out.println("Erro ao conectar ao banco de dados: " + e.getMessage());
    } finally {
        // Fechar as conexões
        if (resultSet != null) resultSet.close();
        if (statement != null) statement.close();
        if (connection != null) connection.close();
    }
    %>
</body>
</html>

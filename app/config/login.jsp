<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    // Obter os parâmetros do formulário de login
    String v_email = request.getParameter("email");
    String v_senha = request.getParameter("senha");

    // Validar os parâmetros de entrada
    if (v_email == null || v_senha == null || v_email.isEmpty() || v_senha.isEmpty()) {
        out.println("<p style='color:red;'>Por favor, preencha todos os campos.</p>");
        return;
    }

    // Configurações do banco de dados
    String database = "barba";
    String url = "jdbc:mysql://localhost:3306/" + database + "?useSSL=false&serverTimezone=UTC";
    String username = "root";
    String password = "";
    String driver = "com.mysql.jdbc.Driver";

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        // Conectar ao banco de dados
        Class.forName(driver);
        connection = DriverManager.getConnection(url, username, password);

        // Verificar se o usuário existe
        String sql = "SELECT * FROM clientes WHERE emailCliente = ? AND senha = ?";
        statement = connection.prepareStatement(sql);
        statement.setString(1, v_email);
        statement.setString(2, v_senha);

        resultSet = statement.executeQuery();

        // Validar o resultado da consulta
        if (resultSet.next()) {
            out.println("<p style='color:green;'>Login realizado com sucesso! Bem-vindo, " + resultSet.getString("nomeCliente") + ".</p>"); // colocar na tela inicial
            // Redirecionar para a página home (ou painel)
            response.sendRedirect(request.getContextPath() + "/app/Views/hoome.html");

        } else {
            out.println("<p style='color:red;'>Email ou senha incorretos.</p>");
            response.sendRedirect(request.getContextPath() + "/app/Views/login.html");
        }
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
<br>
<a href="${pageContext.request.contextPath}/app/Views/login.html">Ir para a página de Login</a>


<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    String v_nome = request.getParameter("nome");
    String v_email = request.getParameter("email");
    String v_telefone = request.getParameter("telefone");
    String v_senha = request.getParameter("senha");

    // Validar os parâmetros de entrada
    if (v_nome == null || v_email == null || v_telefone == null || v_senha == null ||
        v_nome.isEmpty() || v_email.isEmpty() || v_telefone.isEmpty() || v_senha.isEmpty()) {
        out.println("Por favor, preencha todos os campos.");
        return;
    }

    String database = "barba";
    String url = "jdbc:mysql://localhost:3306/" + database + "?useSSL=false&serverTimezone=UTC";
    String username = "root";
    String password = "";
    String driver = "com.mysql.jdbc.Driver";

    Connection connection = null;
    PreparedStatement statement = null;

    try {
        Class.forName(driver);
        connection = DriverManager.getConnection(url, username, password);

        if (connection != null) {
            out.println("Conexão realizada com sucesso<br>");
        }

        String sql = "INSERT INTO clientes (nomeCliente, emailCliente, telefoneCliente, senha) VALUES (?, ?, ?, ?)";
        statement = connection.prepareStatement(sql);
        statement.setString(1, v_nome);
        statement.setString(2, v_email);
        statement.setString(3, v_telefone); // Armazene o telefone como string
        statement.setString(4, v_senha);

        int rowsInserted = statement.executeUpdate();
        if (rowsInserted > 0) {
            out.println("Dados gravados com sucesso<br>");
            response.sendRedirect(request.getContextPath() + "/app/Views/login.html");
        }
    } catch (Exception e) {
        out.println("Erro: " + e.getMessage());
    } finally {
        try {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            out.println("Erro ao fechar recursos: " + e.getMessage());
        }
    }
%>


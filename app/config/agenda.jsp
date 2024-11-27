<%@ page language="java" import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
String idCliente = request.getParameter("id_cliente");
String dataAgendada = request.getParameter("dataAgendada");
String horario = request.getParameter("horario");
String idServico = request.getParameter("id_servico");
String idProfissional = request.getParameter("id_profissional");
String idPagamento = request.getParameter("id_pagamento");

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

    // Inserir o agendamento no banco de dados
    String sql = "INSERT INTO agendamentos (id_cliente, dataAgendada, horario, id_servico, id_profissional, id_pagamento) " +
                 "VALUES (?, ?, ?, ?, ?, ?)";
    statement = connection.prepareStatement(sql);
    statement.setInt(1, Integer.parseInt(idCliente));
    statement.setString(2, dataAgendada);
    statement.setString(3, horario);
    statement.setInt(4, Integer.parseInt(idServico));
    statement.setInt(5, Integer.parseInt(idProfissional));
    statement.setInt(6, Integer.parseInt(idPagamento));
    
    int rowsInserted = statement.executeUpdate();

    if (rowsInserted > 0) {
        out.println("<p>Agendamento realizado com sucesso!</p>");
    } else {
        out.println("<p>Erro ao agendar.</p>");
    }
} catch (Exception e) {
    out.println("<p>Erro: " + e.getMessage() + "</p>");
} finally {
    if (statement != null) statement.close();
    if (connection != null) connection.close();
}
%>

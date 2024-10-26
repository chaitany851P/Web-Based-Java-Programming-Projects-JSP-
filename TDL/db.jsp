<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/todo_list_db";
    String username = "root";  // Replace with your DB username
    String password = "";  // Replace with your DB password
    Connection conn = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

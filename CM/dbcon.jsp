<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/contact_manager";
    String user = "root";
    String password = "";
    Connection conn = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
    } catch (Exception e) {
        out.println("Database Connection Error: " + e.getMessage());
    }
%>

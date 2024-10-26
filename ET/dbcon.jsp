<%@ page import="java.sql.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/expensetracker";
    String dbUser = "root";
    String dbPassword = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        application.setAttribute("dbcon", con);
    } catch(Exception e) {
        out.println("Database connection failed: " + e.getMessage());
    }
%>

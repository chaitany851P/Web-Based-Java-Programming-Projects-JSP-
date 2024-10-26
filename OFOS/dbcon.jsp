<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/online_food_ordering";
    String dbUser = "root";
    String dbPass = "";

    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");  // Ensure you're using the correct MySQL driver class
        conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

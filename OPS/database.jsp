<%@ page import="java.sql.*,java.io.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/online_nursery";
    String username = "root";  // Your MySQL username
    String password = "";  // Your MySQL password
    Connection conn = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/event_management";
    String user = "root";
    String password = "";

    Connection con = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, password);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<%@ page import="java.sql.*" %>
<%! 
    public Connection getConnection() throws Exception {
        Connection conn = null;
        String url = "jdbc:mysql://localhost:3306/doctorappointment";
        String user = "root";
        String password = "";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, user, password);
        return conn;
    }
%>

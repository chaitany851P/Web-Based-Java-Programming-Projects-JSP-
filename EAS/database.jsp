<%@ page import="java.sql.*" %>
<%! 
    public Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/emp_attendance_system";
        String username = "root";
        String password = "";  // Update your MySQL password here
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, username, password);
    }
%>

<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Log_in</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <form action="login.jsp" method="post">
        <h2>Login</h2>
        <input type="text" name="uname" placeholder="Username" required>
        <input type="password" name="pass" placeholder="Password" required>
        <input type="submit" value="Login">
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String uname = request.getParameter("uname");
            String pass = request.getParameter("pass");
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = getConnection();
                String sql = "SELECT * FROM users WHERE username=? AND password=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, uname);
                pstmt.setString(2, pass);
                rs = pstmt.executeQuery();

                if(rs.next()) {
                    // Retrieve user ID from the ResultSet
                    int userIdFromDatabase = rs.getInt("id"); // Adjust column name if necessary
                    String role = rs.getString("role");
                    
                    // Set session attributes
                    session.setAttribute("userid", userIdFromDatabase);
                    session.setAttribute("username", uname);
                    session.setAttribute("role", role);

                    // Redirect based on role
                    if(role.equals("admin")) {
                        response.sendRedirect("addDoctor.jsp"); // Redirect to Add Doctor page
                    } else {
                        response.sendRedirect("viewDoctor.jsp"); // Redirect to View Doctor page
                    }
                } else {
                    out.println("<p>Invalid username or password.</p>");
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace(); }
                if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
                if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }
            }
        }
    %>
</body>
</html>

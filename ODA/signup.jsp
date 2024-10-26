<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Signup</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <form action="signup.jsp" method="post">
        <h2>Signup</h2>
        <input type="text" name="uname" placeholder="Username" required>
        <input type="password" name="pass" placeholder="Password" required>
        <select name="role">
            <option value="user">User</option>
            <option value="admin">Admin</option>
        </select>
        <input type="submit" value="Signup">
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String uname = request.getParameter("uname");
            String pass = request.getParameter("pass");
            String role = request.getParameter("role");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                conn = getConnection();
                String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, uname);
                pstmt.setString(2, pass);
                pstmt.setString(3, role);
                
                int result = pstmt.executeUpdate();
                if(result > 0) {
                    out.println("<p>Signup successful. Please <a href='login.jsp'>login</a>.</p>");
                } else {
                    out.println("<p>Signup failed.</p>");
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            }
        }
    %>
</body>
</html>

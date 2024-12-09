<%@ include file="database.jsp" %>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">

    </head>
<body>
    <h2>Signup</h2>
    <form action="signup.jsp" method="post">
        Username: <input type="text" name="username"><br>
        Password: <input type="password" name="password"><br>
        Role: 
        <select name="role">
            <option value="employee">User</option>
            <option value="admin">Admin</option>
        </select><br>
        <input type="submit" value="Signup">
        <br><br>
        Do have an account then <a href="login.jsp">Login</a>
    </form>

    <%
        if(request.getMethod().equalsIgnoreCase("post")) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            Connection conn = null;
            PreparedStatement pst = null;
            try {
                conn = getConnection();
                String sql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
                pst = conn.prepareStatement(sql);
                pst.setString(1, username);
                pst.setString(2, password);
                pst.setString(3, role);
                int result = pst.executeUpdate();

                if(result > 0) {
                    // Check the role and redirect accordingly
                    if(role.equalsIgnoreCase("admin")) {
                        response.sendRedirect("Adminview.jsp");
                    } else if(role.equalsIgnoreCase("employee")) {
                        response.sendRedirect("Empview.jsp");
                    }
                } else {
                    out.println("<p style='color:red;'>Signup failed. Please try again.</p>");
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if(pst != null) pst.close();
                if(conn != null) conn.close();
            }
        }
    %>
</body>
</html>

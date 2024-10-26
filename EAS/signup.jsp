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
                    out.println("Signup successful!");
                } else {
                    out.println("Signup failed.");
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

<%@ include file="database.jsp" %>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
<body>
    <h2>Login</h2>
    <form action="login.jsp" method="post">
        Username: <input type="text" name="username"><br>
        Password: <input type="password" name="password"><br>
        <input type="submit" value="Login">
        <br><br>
        Do not have account then <a href="signup.jsp">signup</a>
    </form>

    <%
    if(request.getMethod().equalsIgnoreCase("post")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, password);
            rs = pst.executeQuery();

            if(rs.next()) {
                // Fetch user details
                int userId = rs.getInt("id");
                String role = rs.getString("role");

                // Start session and store user ID
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("userId", userId);

                // Redirect based on role
                if(role.equals("employee")) {
                    response.sendRedirect("Empview.jsp");
                } else if(role.equals("admin")) {
                    response.sendRedirect("Adminview.jsp");
                }
            } else {
                out.println("Invalid username or password.");
            }
        } catch(Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if(rs != null) rs.close();
            if(pst != null) pst.close();
            if(conn != null) conn.close();
        }
    }
%>

</body>
</html>

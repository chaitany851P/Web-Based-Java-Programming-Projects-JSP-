<%@ include file="database.jsp" %>
<html>
    
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <form action="login.jsp" method="post">
        Username: <input type="text" name="uname"><br>
        Password: <input type="password" name="pass"><br>
        <input type="submit" value="Login">
    </form>
    <%
        if(request.getParameter("uname") != null) {
            String uname = request.getParameter("uname");
            String pass = request.getParameter("pass");

            try {
                String query = "SELECT * FROM users WHERE uname=? AND pass=?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, uname);
                stmt.setString(2, pass);
                ResultSet rs = stmt.executeQuery();
                
                if(rs.next()) {
                    String role = rs.getString("role");
                    if(role.equals("user")) {
                        response.sendRedirect("viewPlant.jsp");
                    } else if(role.equals("admin")) {
                        response.sendRedirect("addPlant.jsp");
                    }
                } else {
                    out.println("Invalid username or password.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error during login.");
            }
        }
    %>
</body>
</html>

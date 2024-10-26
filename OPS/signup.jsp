<%@ include file="database.jsp" %>
<html>
    
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <form action="signup.jsp" method="post">
        Username: <input type="text" name="uname"><br>
        Password: <input type="password" name="pass"><br>
        Role: 
        <select name="role">
            <option value="user">User</option>
            <option value="admin">Admin</option>
        </select><br>
        <input type="submit" value="Sign Up">
    </form>
    <%
        if(request.getParameter("uname") != null) {
            String uname = request.getParameter("uname");
            String pass = request.getParameter("pass");
            String role = request.getParameter("role");

            try {
                String query = "INSERT INTO users (uname, pass, role) VALUES (?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, uname);
                stmt.setString(2, pass);
                stmt.setString(3, role);
                stmt.executeUpdate();
                out.println("Signup Successful! <a href='login.jsp'>Login Here</a>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error during signup.");
            }
        }
    %>
</body>
</html>

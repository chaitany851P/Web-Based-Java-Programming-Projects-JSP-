<%@include file="dbcon.jsp" %>
<%
    if (request.getParameter("submit") != null) {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        String query = "INSERT INTO users (name, email, password, role) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, name);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, role);
        ps.executeUpdate();
        
        response.sendRedirect("login.jsp");
    }
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<h1>Sign up</h1>
<form method="POST" >
    Name: <input type="text" name="name" required /><br>
    Email: <input type="email" name="email" required /><br>
    Password: <input type="password" name="password" required /><br>
    Role: 
    <select name="role">
        <option value="user">User</option>
        <option value="admin">Admin</option>
    </select><br>
    <input type="submit" name="submit" value="Sign Up" />
    <p>Have an Account then <a href="login.jsp">login</a></p>
</form>
</body>
</html>
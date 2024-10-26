<%@ include file="dbcon.jsp" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Login</h2>
    <form action="login.jsp" method="post">
        Email: <input type="email" name="email" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
    <a href="signup.jsp">Sign up here</a>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, email);
            pst.setString(2, pass);
            
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                session.setAttribute("email", email);
                response.sendRedirect("viewContect.jsp");
            } else {
                out.println("<p style='color:red;'>Invalid email or password!</p>");
            }
        }
    %>
</body>
</html>

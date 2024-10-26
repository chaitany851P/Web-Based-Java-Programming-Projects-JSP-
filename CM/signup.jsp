<%@ include file="dbcon.jsp" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Sign Up</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Sign Up</h2>
    <form action="signup.jsp" method="post">
        Name: <input type="text" name="name" required><br>
        Email: <input type="email" name="email" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Sign Up">
    </form>
    <a href="login.jsp">Already have an account? Login</a>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            String query = "INSERT INTO users(name, email, password) VALUES (?, ?, ?)";
            
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, pass);
            
            int result = pst.executeUpdate();
            if (result > 0) {
                session.setAttribute("email", email);
                response.sendRedirect("viewContect.jsp");
            } else {
                out.println("<p style='color:red;'>Sign up failed!</p>");
            }
        }
    %>
</body>
</html>

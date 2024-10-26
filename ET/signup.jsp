<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Signup</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <div class="container">
        <h2>Signup</h2>
        <form action="signup.jsp" method="post">
            Username: <input type="text" name="uname" required><br>
            Email: <input type="email" name="email" required><br>
            Password: <input type="password" name="password" required><br>
            <input type="submit" value="Signup" class="btn">
        </form>
        <p>If you already have an account, <a href="login.jsp">Login</a></p>
    </div>
</body>
</html>

<%
    if(request.getMethod().equals("POST")){
        String uname = request.getParameter("uname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Connection con = (Connection)application.getAttribute("dbcon");
        PreparedStatement ps = con.prepareStatement("INSERT INTO users (uname, email, password) VALUES (?, ?, ?)");
        ps.setString(1, uname);
        ps.setString(2, email);
        ps.setString(3, password);
        
        int i = ps.executeUpdate();
        if(i > 0){
            response.sendRedirect("login.jsp");
        } else {
            out.println("Signup failed");
        }
    }
%>

<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@include file="dbcon.jsp" %>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form action="login.jsp" method="post">
            Email: <input type="email" name="email" required><br>
            Password: <input type="password" name="password" required><br>
            <input type="submit" value="Login" class="btn">
        </form>
        <p>If you do not have an account, <a href="signup.jsp">Sign up</a></p>
    </div>
</body>
</html>

<%
    if(request.getMethod().equals("POST")){
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        Connection con = (Connection)application.getAttribute("dbcon");
        PreparedStatement ps = con.prepareStatement("SELECT id FROM users WHERE email=? AND password=?");
        ps.setString(1, email);
        ps.setString(2, password);
        ResultSet rs = ps.executeQuery();
        
        if(rs.next()){
            // No need to declare session, just use the available session object
            session.setAttribute("userid", rs.getInt("id"));
            response.sendRedirect("viewExpence.jsp");
        } else {
            out.println("Invalid credentials");
        }
    }
%>

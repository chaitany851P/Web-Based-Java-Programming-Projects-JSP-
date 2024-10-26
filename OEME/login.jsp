<%@ page import="java.sql.*" %>
<%@ include file="dbCon.jsp" %>
<html>
<head>
    <title>Login</title>
</head>
<body style="background-color:white;color:teal;">
    <h2>Login</h2>
    
    <form action="login.jsp" method="post">
        <label>Username:</label> <input type="text" name="uname" required><br>
        <label>Password:</label> <input type="password" name="pass" required><br>
        <button type="submit">Login</button>
    </form>

    <%
    String uname = request.getParameter("uname");
    String pass = request.getParameter("pass");

    // If the form is submitted, handle login
    if (uname != null && pass != null) {
        try {
            String query = "SELECT * FROM users WHERE uname = ? AND pass = ?";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, uname);
            pst.setString(2, pass);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // User found, set session attributes
                String role = rs.getString("role");
                session.setAttribute("uname", uname);
                session.setAttribute("role", role);

                // Redirect based on role
                if (role.equals("admin")) {
                    response.sendRedirect("requestedEvents.jsp");  // Admin goes to requested events page
                } else if (role.equals("user")) {
                    response.sendRedirect("viewPastevent.jsp");    // User goes to view past events
                }
            } else {
                out.println("<p style='color:red;'>Invalid username or password. Please try again.</p>");
            }
            rs.close();
            pst.close();
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error: " + e.getMessage());
        }
    }
    %>
</body>
</html>

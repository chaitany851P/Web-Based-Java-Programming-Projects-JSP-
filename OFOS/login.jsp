<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@include file="dbcon.jsp" %>
<%
    
    // Get user input from the login form
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // Check if form is submitted (i.e., if email and password are provided)
    if (email != null && password != null) {
        try {
            // Check if the database connection is available
            if (conn != null) {
                // SQL query to check user credentials
                String query = "SELECT * FROM users WHERE email = ? AND password = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, email);
                ps.setString(2, password);

                // Execute the query and get the result
                ResultSet rs = ps.executeQuery();

                // Check if the user exists in the database
                if (rs.next()) {
                    // Set user data in the session
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("role", rs.getString("role"));

                    // Redirect based on user role
                    if ("admin".equals(rs.getString("role"))) {
                        response.sendRedirect("ViewItem.jsp?role=admin");
                    } else {
                        response.sendRedirect("ViewItem.jsp?role=user");
                    }
                } else {
                    // Invalid credentials message
                    out.println("<p style='color:red;'>Invalid email or password.</p>");
                }

                // Close the ResultSet and PreparedStatement
                rs.close();
                ps.close();
            } else {
                // Database connection failure message
                out.println("<p style='color:red;'>Unable to connect to the database.</p>");
            }
        } catch (Exception e) {
            // Handle any exceptions
            e.printStackTrace();
            out.println("<p style='color:red;'>An error occurred while processing your request.</p>");
        }
    }
%>
<link rel="stylesheet" type="text/css" href="style.css">
<h1>Log in</h1>
<!-- HTML form for user login -->
<form method="POST" action="login.jsp">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required /><br><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required /><br><br>

    <input type="submit" name="login" value="Login" />
    <p>Do not have Account then <a href="signup.jsp">Signup</a></p>
</form>

<%@ page import="java.sql.*" %>
<%@ include file="dbCon.jsp" %>
<html>
<head>
    <title>Sign Up</title>
</head>
<body style="background-color:white;color:teal;">
    <h2>Sign Up</h2>
    
    <%
        // Handle POST request (form submission)
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String uname = request.getParameter("uname");
            String email = request.getParameter("email");
            String pass = request.getParameter("pass");
            String role = request.getParameter("role");

            if (con != null) {
                PreparedStatement pst = null;
                try {
                    // Query to insert new user into the database
                    String query = "INSERT INTO users (uname, email, pass, role) VALUES (?, ?, ?, ?)";
                    pst = con.prepareStatement(query);
                    pst.setString(1, uname);
                    pst.setString(2, email);
                    pst.setString(3, pass);
                    pst.setString(4, role);
                    
                    int rowCount = pst.executeUpdate();

                    if (rowCount > 0) {
                        // Successful sign-up
                        out.println("<p style='color:green;'>Signup successful! Redirecting to login page...</p>");
                        response.setHeader("Refresh", "2; URL=login.jsp");  // Redirect after 2 seconds
                    } else {
                        out.println("<p style='color:red;'>Signup failed. Please try again.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                } finally {
                    // Close the PreparedStatement
                    if (pst != null) {
                        try {
                            pst.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            } else {
                out.println("<p style='color:red;'>Database connection failed.</p>");
            }
        }
    %>

    <!-- Form displayed for GET request -->
    <form action="signup.jsp" method="post">
        <label>Username:</label> <input type="text" name="uname" required><br>
        <label>Email:</label> <input type="email" name="email" required><br>
        <label>Password:</label> <input type="password" name="pass" required><br>
        <label>Role:</label>
        <select name="role">
            <option value="user">User</option>
            <option value="admin">Admin</option>
        </select><br>
        <button type="submit">Sign Up</button>
    </form>

</body>
</html>

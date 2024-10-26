<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Signup</h2>
        <form action="signup.jsp" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <select name="role"  required>
                
                <option value="user">User</option>
                <option value="admin">Admin</option>
            </select><br>
            <input type="submit" value="Signup">
        </form>

        <%
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            if (email != null && username != null && password != null && role != null) {
                Connection con = null;
                PreparedStatement ps = null;

                try {
                    // Database connection
                    String url = "jdbc:mysql://localhost:3306/online_book_store"; // Update with your DB URL
                    String dbUser = "root"; // Update with your DB username
                    String dbPassword = ""; // Update with your DB password

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(url, dbUser, dbPassword);

                    // Check if the username already exists
                    String checkUserQuery = "SELECT * FROM users WHERE username = ?";
                    ps = con.prepareStatement(checkUserQuery);
                    ps.setString(1, username);
                    ResultSet rs = ps.executeQuery();

                    if (rs.next()) {
                        out.println("<p>Username already exists. Please choose another one.</p>");
                    } else {
                        // Insert new user into the database
                        String insertQuery = "INSERT INTO users (email, username, password, role) VALUES (?, ?, ?, ?)";
                        ps = con.prepareStatement(insertQuery);
                        ps.setString(1, email);
                        ps.setString(2, username);
                        ps.setString(3, password); // In practice, hash this password
                        ps.setString(4, role);

                        int rowsAffected = ps.executeUpdate();

                        if (rowsAffected > 0) {
                            out.println("<p>Signup Successful! You can now <a href='index.jsp'>login</a>.</p>");
                        } else {
                            out.println("<p>Error during signup. Please try again.</p>");
                        }
                    }
                } catch (ClassNotFoundException e) {
                    out.println("<p>Error: Unable to load database driver.</p>");
                    e.printStackTrace();
                } catch (SQLException e) {
                    out.println("<p>Error connecting to the database.</p>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>
    </div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form action="index.jsp" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>

        <%
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            if (username != null && password != null) {
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;

                try {
                    // Database connection
                    String url = "jdbc:mysql://localhost:3306/online_book_store"; // Update with your DB URL
                    String dbUser = "root"; // Update with your DB username
                    String dbPassword = ""; // Update with your DB password

                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(url, dbUser, dbPassword);

                    // Use query to fetch user role
                    String query = "SELECT role FROM users WHERE username = ? AND password = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, username);
                    ps.setString(2, password);
                    rs = ps.executeQuery();

                    if (rs.next()) {
                        String role = rs.getString("role"); // Fetch user role
                        out.println("<p>Login Successful! Welcome, " + username + "!</p>");
                        
                        // Redirect based on user role
                        if ("admin".equals(role)) {
                            response.sendRedirect("add_book.jsp"); // Admin redirect
                        } else {
                            response.sendRedirect("main.jsp"); // User redirect
                        }
                    } else {
                        out.println("<p>Invalid username or password.</p>");
                    }
                } catch (ClassNotFoundException e) {
                    out.println("<p>Error: Unable to load database driver.</p>");
                    e.printStackTrace();
                } catch (SQLException e) {
                    out.println("<p>Error connecting to the database.</p>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
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

<%@ page import="java.sql.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/techblog";  // Update the DB URL, name, and port as necessary
    String username = "root";                             // DB username
    String password = "";                                 // DB password

    Connection connection = null;
    PreparedStatement stmt = null;

    try {
        String postId = request.getParameter("id"); // Get post ID from request
        if (postId != null) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);

            // SQL query to delete the post
            String sql = "DELETE FROM posts WHERE id = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(postId));
            int rowsAffected = stmt.executeUpdate();

            // Redirect to the main page after deletion
            if (rowsAffected > 0) {
                response.sendRedirect("viewPost.jsp"); // Change this to your posts page
            } else {
                out.println("Error: Post could not be deleted.");
            }
        } else {
            out.println("Error: No post ID provided.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources to prevent memory leaks
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

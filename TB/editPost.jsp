<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/techblog";  // Update the DB URL, name, and port as necessary
    String username = "root";                             // DB username
    String password = "";                                 // DB password

    Connection connection = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String postId = request.getParameter("id");
    Map<String, String> post = new HashMap<>(); // To store the post details

    if (postId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);

            // SQL query to fetch the post based on the ID
            String sql = "SELECT title, content FROM posts WHERE id = ?";
            stmt = connection.prepareStatement(sql);
            stmt.setString(1, postId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                post.put("title", rs.getString("title"));
                post.put("content", rs.getString("content"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources to prevent memory leaks
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }

    // Check if the form has been submitted to update the post
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String updatedTitle = request.getParameter("title");
        String updatedContent = request.getParameter("content");

        // Update the post in the database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);

            String updateSql = "UPDATE posts SET title = ?, content = ? WHERE id = ?";
            stmt = connection.prepareStatement(updateSql);
            stmt.setString(1, updatedTitle);
            stmt.setString(2, updatedContent);
            stmt.setString(3, postId);
            stmt.executeUpdate();

            // Redirect to view post page after successful update
            response.sendRedirect("viewPost.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources to prevent memory leaks
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Post</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        /* Reset some default browser styles */
        body, h1, p, label, input, textarea, button, a {
            margin: 0;
            padding: 0;
        }

        /* Basic body styling */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4; /* Light background for contrast */
            color: #333; /* Dark text for readability */
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: auto; /* Allow height to adjust */
            padding: 20px; /* Padding around body */
        }

        /* Main header styling */
        header {
            width: 100%;
            background-color: #fff; /* White background for header */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Soft shadow */
            padding: 20px; /* Padding in header */
            text-align: center; /* Center align text */
        }

        h1 {
            font-size: 2.5em;
            color: #15b5cd; /* Your specified blue color */
        }

        /* Form styling */
        form {
            background-color: #fff; /* White background for form */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Soft shadow */
            padding: 20px; /* Padding inside form */
            width: 100%;
            max-width: 600px; /* Max width for form */
        }

        label {
            display: block; /* Block display for labels */
            margin-bottom: 5px; /* Space below labels */
            color: #333; /* Dark text for labels */
        }

        input[type="text"],
        textarea {
            width: 90%; /* Full width input */
            padding: 10px; /* Padding inside input */
            margin-bottom: 20px; /* Space below inputs */
            border: 1px solid #ccc; /* Light border */
            border-radius: 4px; /* Rounded corners */
            font-size: 1em; /* Font size for inputs */
        }

        input[type="submit"] {
            background-color: #15b5cd; /* Button color */
            color: white; /* White text */
            padding: 10px 20px; /* Padding for button */
            border: none; /* Remove border */
            border-radius: 5px; /* Rounded corners */
            font-size: 1em; /* Font size for button */
            cursor: pointer; /* Pointer cursor on hover */
            transition: background-color 0.3s; /* Smooth transition */
        }

        /* Button hover effect */
        input[type="submit"]:hover {
            background-color: #0f8c99; /* Darker shade on hover */
        }

        /* Back link styling */
        a {
            display: inline-block; /* Inline block for link */
            margin-top: 20px; /* Space above link */
            color: #15b5cd; /* Your specified blue color */
            text-decoration: none; /* Remove underline */
            font-weight: bold; /* Bold text for links */
        }

        /* Link hover effect */
        a:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>

    <header>
        <h1>Edit Post</h1>
    </header>
<br><br>
    <main>
        <form method="POST" action="">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="<%= post.get("title") %>" required>

            <label for="content">Content:</label>
            <textarea id="content" name="content" rows="10" required><%= post.get("content") %></textarea>

            <input type="submit" value="Update Post">
        </form>
        <br>
        <a href="viewPost.jsp">Cancel</a>
    </main>

</body>
</html>

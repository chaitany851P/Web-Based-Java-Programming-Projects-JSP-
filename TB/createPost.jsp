<%@ page import="java.sql.*" %>
<%
    // Get the logged-in user's username from the session
    String author = (String) session.getAttribute("username");  // Assumes the username is stored in session

    // If the user is not logged in, redirect to the login page
    if (author == null) {
        response.sendRedirect("index.jsp");  // Redirect to login page
        return;
    }

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/techblog";   // Update the DB URL, name, and port as necessary
    String username = "root";                             // DB username
    String password = "";                                 // DB password

    Connection connection = null;
    PreparedStatement stmt = null;

    // Check if the form was submitted
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        if (title != null && content != null && !title.trim().isEmpty() && !content.trim().isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(url, username, password);

                // SQL query to insert the post into the database
                String sql = "INSERT INTO posts (title, content, author, created_at) VALUES (?, ?, ?, NOW())";
                stmt = connection.prepareStatement(sql);
                stmt.setString(1, title);
                stmt.setString(2, content);
                stmt.setString(3, author);  // Set the author to the logged-in user's username

                // Execute the query
                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    out.println("<p>Post created successfully!</p>");
                } else {
                    out.println("<p>Failed to create post. Please try again.</p>");
                }

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close resources
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        } else {
            out.println("<p>Both title and content are required!</p>");
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Create a New Post</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        /* Reset some default browser styles */
        body, h1, p, label, input, textarea, button {
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

        button {
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
        button:hover {
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
        <h1>Create a New Post</h1>
        <a href="viewPost.jsp">Back to All Posts</a>
        
    </header>
    <br><br>
    <main>
        <form method="POST" action="createPost.jsp">
          
            <label for="title">Post Title:</label>
            <input type="text" id="title" name="title" required>
            
            <label for="content">Content:</label>
            <textarea id="content" name="content" rows="10" required></textarea>
            
            <button type="submit">Create Post</button>
        </form>
    </main>

</body>
</html>

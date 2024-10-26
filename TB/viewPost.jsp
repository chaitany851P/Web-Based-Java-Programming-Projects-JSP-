<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
    // Get the logged-in user's username from the session
    String loggedInUser = (String) session.getAttribute("username");

    // Database connection parameters
    String url = "jdbc:mysql://localhost:3306/techblog";  // Update the DB URL, name, and port as necessary
    String username = "root";                             // DB username
    String password = "";                                 // DB password

    Connection connection = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    List<Map<String, String>> posts = new ArrayList<>();  // Declare the list to store posts

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, password);

        // SQL query to fetch posts including the author's username
        String sql = "SELECT id, title, content, created_at, author FROM posts ORDER BY created_at DESC";
        stmt = connection.prepareStatement(sql);
        rs = stmt.executeQuery();

        // Iterate through the result set and store the posts in a list
        while (rs.next()) {
            Map<String, String> post = new HashMap<>();
            post.put("id", rs.getString("id"));
            post.put("title", rs.getString("title"));
            post.put("content", rs.getString("content"));
            post.put("created_at", rs.getString("created_at"));
            post.put("author", rs.getString("author")); // Store the author of the post
            posts.add(post);
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Close resources to prevent memory leaks
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (connection != null) try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tech Blog - All Posts</title>
    <style>
        /* Reset some default browser styles */
body, h1, h2, p, a, div {
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

/* Create New Post button */
.create-button {
    background-color: #15b5cd; /* Button color */
    color: white; /* White text */
    padding: 10px 20px; /* Padding for button */
    border: none; /* Remove border */
    border-radius: 5px; /* Rounded corners */
    text-decoration: none; /* Remove underline from link */
    font-size: 1em; /* Font size for button */
    transition: background-color 0.3s; /* Smooth transition */
}
.delet-button {
    background-color: red; /* Button color */
    color: white; /* White text */
    padding: 10px 20px; /* Padding for button */
    border: none; /* Remove border */
    border-radius: 5px; /* Rounded corners */
    text-decoration: none; /* Remove underline from link */
    font-size: 1em; /* Font size for button */
    transition: background-color 0.3s; /* Smooth transition */
}
/* Button hover effect */
.create-button:hover {
    background-color: #0f8c99; /* Darker shade on hover */
}
.delet-button:hover {
    background-color: red /* Darker shade on hover */
}
/* Main content area */
main {
    width: 100%;
    max-width: 800px; /* Max width for the posts container */
    margin: 20px auto; /* Centering the content */
}

/* Posts container */
.posts-container {
    background-color: #fff; /* White background for posts */
    border-radius: 8px; /* Rounded corners */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Soft shadow */
    padding: 20px; /* Padding inside posts container */
}

/* Individual post styling */
.post {
    border-bottom: 1px solid #e0e0e0; /* Divider between posts */
    padding: 15px 0; /* Padding for individual posts */
}

.post:last-child {
    border-bottom: none; /* Remove bottom border for the last post */
}

/* Post title styling */
h2 {
    font-size: 1.8em; /* Font size for post titles */
    color: #15b5cd; /* Your specified blue color */
    margin-bottom: 10px; /* Space below title */
}

/* Post content */
.post p {
    margin: 10px 0; /* Space around content */
}

/* Post metadata */
small {
    display: block; /* Block display for separation */
    color: #777; /* Lighter text for metadata */
    margin-bottom: 10px; /* Space below metadata */
}

/* Edit link */
a {
    text-decoration: none; /* Remove underline */
    color: #15b5cd; /* Your specified blue color */
    font-weight: bold; /* Bold text for links */
}

/* Edit link hover effect */
a:hover {
    text-decoration: underline; /* Underline on hover */
}

/* Responsive styling */
@media (max-width: 480px) {
    body {
        padding: 10px; /* Padding on smaller screens */
    }

    .posts-container {
        padding: 15px; /* Reduced padding on smaller screens */
    }

    h1 {
        font-size: 2em; /* Smaller header size on mobile */
    }

    h2 {
        font-size: 1.5em; /* Smaller post title size on mobile */
    }

    .create-button {
        width: 100%; /* Full width button on mobile */
    }
}

    </style>
</head>
<body>

    <header>
        <h1>All Posts</h1>
        <br>    
        <a class="delet-button" href="login.jsp">log out</a>        <br><br>
        
    </header>

    <main>
        <div class="posts-container">
            <% if (posts.size() == 0) { %>
                <p>No posts available. Be the first to create one!</p>
            <% } else { %>
                <% for (Map<String, String> post : posts) { %>
                    <div class="post">
                        <h2><%= post.get("title") %></h2>
                        <p><%= post.get("content") %></p>
                        <small>Posted on: <%= post.get("created_at") %> by <%= post.get("author") %></small>
                        <br>
                        <% if (loggedInUser != null && loggedInUser.equals(post.get("author"))) { %>
                            <a class="create-button" href="editPost.jsp?id=<%= post.get("id")  %>">Edit</a>
                            <a class="delet-button" href="deletePost.jsp?id=<%= post.get("id")  %>" onclick="return confirm('Are you sure you want to delete this post?');">Delete</a>
                        <% } %>
                    </div>
                <% } %>
            <% } %>
        </div>
    </main>
    <a href="createPost.jsp" class="create-button">Create New Post</a>
</body>
</html>

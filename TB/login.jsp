<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/techblog";  // Change DB URL, name, and port as necessary
    String username = "root";                            // DB username
    String password = "";                            // DB password

    Connection connection = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, password);
    } catch (Exception e) {
        e.printStackTrace();
    }
    String message = null;

    // Handle login
    if (request.getParameter("login") != null) {
        String uname = request.getParameter("username");
        String pass = request.getParameter("password");

        try {
            String query = "SELECT * FROM users WHERE username = ? AND password = ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, uname);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("username", uname);
                response.sendRedirect("viewPost.jsp");
            } else {
                message = "Invalid username or password.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Handle signup
    if (request.getParameter("signup") != null) {
        String uname = request.getParameter("newUsername");
        String pass = request.getParameter("newPassword");

        try {
            String query = "INSERT INTO users (username, password) VALUES (?, ?)";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, uname);
            ps.setString(2, pass);
            ps.executeUpdate();

            message = "Account created successfully! Please login.";
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Error creating account. Try again.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <title>TechBlog - Login</title>
    <style>
        /* Reset some default browser styles */
body, h1, h2, p, form {
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
    height: 100vh;
}

/* Main header styling */
h1 {
    font-size: 2.5em;
    color: #15b5cd; /* Green color for header */
    margin-bottom: 20px;
}

/* Form styling */
form {
    background-color: #fff; /* White background for the form */
    border-radius: 8px; /* Rounded corners */
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Soft shadow */
    padding: 20px;
    width: 300px; /* Fixed width for forms */
    margin-bottom: 20px;
}

/* Form labels */
label {
    display: block;
    margin-bottom: 8px;
    font-weight: bold; /* Bold labels */
}

/* Input fields */
input[type="text"],
input[type="password"] {
    width: 100%; /* Full width */
    padding: 10px; /* Padding inside inputs */
    margin-bottom: 15px; /* Space between fields */
    border: 1px solid #ccc; /* Light border */
    border-radius: 4px; /* Rounded corners */
    font-size: 1em; /* Font size for inputs */
}

/* Input fields on focus */
input[type="text"]:focus,
input[type="password"]:focus {
    border-color: #15b5cd; /* Change border color on focus */
    outline: none; /* Remove default outline */
}

/* Submit buttons */
input[type="submit"] {
    background-color: #15b5cd; /* Green background */
    color: white; /* White text */
    border: none; /* Remove border */
    border-radius: 4px; /* Rounded corners */
    padding: 10px 15px; /* Padding for buttons */
    font-size: 1em; /* Font size for buttons */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s; /* Smooth transition */
}

/* Button hover effect */
input[type="submit"]:hover {
    background-color: #15b5cd; /* Darker green on hover */
}

/* Message styling */
p {
    color: red; /* Red text for messages */
    margin-top: 15px; /* Space above messages */
    font-weight: bold; /* Bold text */
}

/* Responsive styling */
@media (max-width: 480px) {
    body {
        padding: 10px; /* Padding on smaller screens */
    }

    form {
        width: 100%; /* Full width on small screens */
    }
}

    </style>
</head>
<body>
    <h1>Welcome to TechBlog</h1>
    <form method="POST">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required><br>
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required><br>
        <input type="submit" name="login" value="Login">
    </form>

    <h2>Don't have an account? Sign Up!</h2>
    <form method="POST">
        <label for="newUsername">Username:</label>
        <input type="text" id="newUsername" name="newUsername" required><br>
        <label for="newPassword">Password:</label>
        <input type="password" id="newPassword" name="newPassword" required><br>
        <input type="submit" name="signup" value="Sign Up">
    </form>

    <% if (message != null) { %>
        <p><%= message %></p>
    <% } %>
</body>
</html>

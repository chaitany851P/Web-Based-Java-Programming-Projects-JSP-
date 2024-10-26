<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Add Book</h2>

    <form method="POST" action="add_book.jsp">
        <label for="title">Title:</label>
        <input type="text" name="title" id="title" required>

        <label for="author">Author:</label>
        <input type="text" name="author" id="author" required>

        <label for="price">Price:</label>
        <input type="number" name="price" id="price" step="0.01" required>

        <label for="discount">Discount:</label>
        <input type="number" name="discount" id="discount" step="0.01" required>

        <label for="imageUrl">Image URL:</label>
        <input type="text" name="imageUrl" id="imageUrl">

        <input type="submit" value="Add Book">
    </form>

    <%
        // Database connection variables
        String dbURL = "jdbc:mysql://localhost:3306/online_book_store"; // Update with your DB URL
        String dbUser = "root"; // Update with your DB username
        String dbPassword = ""; // Update with your DB password

        // Handling form submission
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String price = request.getParameter("price");
            String discount = request.getParameter("discount");
            String imageUrl = request.getParameter("imageUrl");

            // Debugging output
            out.println("<div>Price: " + price + "</div>");
            out.println("<div>Discount: " + discount + "</div>");

            if (price != null && discount != null) {
                try {
                    // Insert data into the database
                    Connection conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
                    String sql = "INSERT INTO books (title, author, price, discount, image_url) VALUES (?, ?, ?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, title);
                    pstmt.setString(2, author);
                    pstmt.setBigDecimal(3, new BigDecimal(price));
                    pstmt.setBigDecimal(4, new BigDecimal(discount));
                    pstmt.setString(5, imageUrl);
                    pstmt.executeUpdate();
                    out.println("<h3>Book added successfully!</h3>");
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<h3 class='error'>Error adding book: " + e.getMessage() + "</h3>");
                } catch (NumberFormatException e) {
                    out.println("<h3 class='error'>Error: Invalid number format</h3>");
                    e.printStackTrace();
                }
            } else {
                out.println("<h3 class='error'>Error: Price or discount is null</h3>");
            }
        }
    %>
</div>

</body>
</html>

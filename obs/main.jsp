<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Online Book Store</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eeef8;
        }
        .container {
            width: 80%;
            margin: 0 auto;
        }
        .header {
            text-align: center;
            padding: 20px;
            background-color: #333;
            color: #fff;
        }
        .bestsellers {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }
        .book {
            background-color: #fff;
            border: 1px solid #ddd;
            margin: 10px;
            padding: 15px;
            width: 200px;
            text-align: center;
        }
        .book img {
            width: 100%;
            height: auto;
        }
        .book-title {
            font-size: 18px;
            margin: 10px 0;
        }
        .author {
            font-size: 16px;
            color: #555;
        }
        .price, .discount {
            font-size: 16px;
            margin: 5px 0;
        }
        .add-to-cart {
            display: block;
            margin: 10px 0;
            padding: 10px;
            background-color: #007BFF;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }
        .view-all {
            text-align: right;
            margin: 20px 0;
        }
        .view-all a {
            color: #007BFF;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Online Book Store</h1> 
        </div>
        
        <div class="bestsellers">

            <%
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    String url = "jdbc:mysql://localhost:3306/online_book_store"; // Your DB URL
                    String dbUser = "root"; // Your DB username
                    String dbPassword = ""; // Your DB password

                    // Load MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(url, dbUser, dbPassword);

                    // Fetch all books
                    String query = "SELECT title, author, price, discount, image_url FROM books"; // Assuming you have a 'books' table with these columns
                    stmt = con.createStatement();
                    rs = stmt.executeQuery(query);

                    // Loop through result set
                    while (rs.next()) {
                        String bookTitle = rs.getString("title");
                        String bookAuthor = rs.getString("author");
                        String bookPrice = rs.getString("price");
                        String bookDiscount = rs.getString("discount");
                        String bookImage = rs.getString("image_url");

                        // Display book details
                        out.println("<div class='book'>");
                        out.println("<img src='" + bookImage + "' alt='" + bookTitle + "'>");
                        out.println("<div class='book-title'>" + bookTitle + "</div>");
                        out.println("<div class='author'>by " + bookAuthor + "</div>");
                        out.println("<div class='price'>₹" + bookPrice + "</div>");
                        out.println("<div class='discount'>" + bookDiscount + " off</div>");
                        
                        // Create a form for buying the book
                        out.println("<form action='buy_book.jsp' method='post'>");
                        out.println("<input type='hidden' name='title' value='" + bookTitle + "'/>");
                        out.println("<input type='hidden' name='author' value='" + bookAuthor + "'/>");
                        out.println("<input type='hidden' name='price' value='" + bookPrice + "'/>");
                        out.println("<input type='hidden' name='discount' value='" + bookDiscount + "'/>");
                        out.println("<input type='hidden' name='image_url' value='" + bookImage + "'/>");
                        out.println("<button type='submit' class='add-to-cart'>Buy Now</button>");
                        out.println("</form>");
                        out.println("</div>");
                    }
                } catch (ClassNotFoundException e) {
                    out.println("<p>Error: Unable to load database driver.</p>");
                    e.printStackTrace();
                } catch (SQLException e) {
                    out.println("<p>Error connecting to the database.</p>");
                    e.printStackTrace();
                } finally {
                    // Close resources
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>

        </div>
    </div>
</body>
</html>

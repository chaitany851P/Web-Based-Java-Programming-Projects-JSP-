<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Purchase Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 20px;
            padding: 20px;
            border: 1px solid #ccc;
        }
        .confirmation {
            text-align: center;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="confirmation">
        <h2>Purchase Confirmation</h2>
        <%
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            String price = request.getParameter("price");
            String discount = request.getParameter("discount");
            String imageUrl = request.getParameter("image_url");

            if (title != null && author != null && price != null) {
                out.println("<h3>You have purchased:</h3>");
                out.println("<p><strong>Title:</strong> " + title + "</p>");
                out.println("<p><strong>Author:</strong> " + author + "</p>");
                out.println("<p><strong>Price:</strong> ₹" + price + "</p>");
                out.println("<p><strong>Discount:</strong> " + discount + " off</p>");
                out.println("<img src='" + imageUrl + "' alt='" + title + "' style='width:200px;height:auto;'><br/>");
                out.println("<p>Thank you for your purchase!</p>");
            } else {
                out.println("<p>No book details were provided. Please go back and try again.</p>");
            }
        %>
        <a href="main.jsp">Back to Store</a>
    </div>
</body>
</html>

<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@include file="dbcon.jsp" %>
<link rel="stylesheet" type="text/css" href="style.css">
<h1>Place your Order!!</h1>
<%
    // Get the item ID from the request
    int itemId = Integer.parseInt(request.getParameter("itemId"));

    // Query to select the item details
    String query = "SELECT * FROM items WHERE id = ?";
    PreparedStatement ps = conn.prepareStatement(query);
    ps.setInt(1, itemId);
    ResultSet rs = ps.executeQuery();

    // Check if the item exists
    if (rs.next()) {
        String itemName = rs.getString("name");
        String itemPrice = rs.getString("price");
        String imageUrl = rs.getString("image_url");

        // Display the item details
        out.println("Item Name: " + itemName + "<br>");
        out.println("Item Price: $" + itemPrice + "<br>");
        out.println("<img src='" + imageUrl + "' alt='" + itemName + "' /><br>");

        // Add place order button or any additional functionality
        out.println("<a href='placeOrder.jsp?itemId=" + itemId + "'>Place Order</a>");
    } else {
        out.println("<p>Item not found.</p>");
    }

    // Close ResultSet and PreparedStatement
    rs.close();
    ps.close();
%>

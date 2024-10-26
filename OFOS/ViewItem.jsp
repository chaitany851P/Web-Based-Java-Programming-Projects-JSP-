<%@page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@include file="dbcon.jsp" %>
<link rel="stylesheet" type="text/css" href="style.css">

<%
    String userRole = (String) session.getAttribute("role");

    // Check if userRole is null and redirect or handle accordingly
    if (userRole == null) {
        out.println("<p>Please log in to view items.</p>");
        return; // Stop further processing
    }

    // Handle delete request
    String itemIdToDelete = request.getParameter("deleteId");
    if (itemIdToDelete != null) {
        try {
            int itemId = Integer.parseInt(itemIdToDelete);
            String deleteQuery = "DELETE FROM items WHERE id = ?";
            PreparedStatement psDelete = conn.prepareStatement(deleteQuery);
            psDelete.setInt(1, itemId);
            int rowsAffected = psDelete.executeUpdate();
            psDelete.close();

            if (rowsAffected > 0) {
                out.println("<p>Item deleted successfully.</p>");
            } else {
                out.println("<p>Item not found.</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error deleting item: " + e.getMessage() + "</p>");
        }
    }

    // Query to select items
    String query = "SELECT * FROM items";
    PreparedStatement ps = conn.prepareStatement(query);
    ResultSet rs = ps.executeQuery();
    if (userRole.equals("user")) {
    } else if (userRole.equals("admin")) {
        out.println("<h1>Admin Side</h1>");

    }
    // Check if ResultSet is empty
    if (!rs.isBeforeFirst()) { // This checks if the ResultSet is empty
        out.println("<p>Items will be listed soon.</p>");
    } else {
        while (rs.next()) {
            int itemId = rs.getInt("id");
            String itemName = rs.getString("name");
            String itemPrice = rs.getString("price");
            String imageUrl = rs.getString("image_url");
            
            out.println("<img src='" + imageUrl + "' alt='" + itemName + "' /><br>");
            out.println("Name: " + itemName + "<br>");
            out.println("Price: $" + itemPrice + "<br>");

            if (userRole.equals("user")) {
                out.println("<a href='order.jsp?itemId=" + itemId + "'>Place Order</a><br><br>");
            } else if (userRole.equals("admin")) {
                out.println("<a href='editItem.jsp?itemId=" + itemId + "'>Edit</a> | ");
                out.println("<a href='ViewItem.jsp?deleteId=" + itemId + "' onclick=\"return confirm('Are you sure you want to delete this item?');\">Delete</a><br><br>");
            }
        }

        // Display "Add New Item" link for admin users
        if (userRole.equals("admin")) {
            out.println("<a href='addItem.jsp'>Add New Item</a><br><br>");
        }
    }

    // Close ResultSet and PreparedStatement
    rs.close();
    ps.close();
%>

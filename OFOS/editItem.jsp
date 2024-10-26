<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@include file="dbcon.jsp" %>
<link rel="stylesheet" type="text/css" href="style.css">
<h1>EDIT item </h1>
<%
    // Get the itemId from the request
    String itemIdStr = request.getParameter("itemId");
    int itemId = Integer.parseInt(itemIdStr); // Convert the itemId to an integer

    // Define a flag to check for submission success
    boolean isUpdated = false;

    // Check if the form is submitted
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String name = request.getParameter("name");
        String price = request.getParameter("price");

        // Update item in the database
        String updateQuery = "UPDATE items SET name = ?, price = ? WHERE id = ?";
        PreparedStatement updatePs = conn.prepareStatement(updateQuery);
        updatePs.setString(1, name);
        updatePs.setString(2, price);
        updatePs.setInt(3, itemId);
        
        // Execute the update and check if successful
        isUpdated = updatePs.executeUpdate() > 0;
        
        // Close the update statement
        updatePs.close();
    }

    // Redirect based on the update success
    if (isUpdated) {
        // Redirect to viewItem.jsp with the role parameter
        response.sendRedirect("ViewItem.jsp?role=admin");
    } else {
        out.println("<p>Error updating the item. Please try again.</p>");
    }

    // Optionally, display the item for editing if not redirected
    if (!isUpdated) {
        String query = "SELECT * FROM items WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setInt(1, itemId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            String name = rs.getString("name");
            String price = rs.getString("price");
            String imageUrl = rs.getString("image_url");

            out.println("<h1>Edit Item</h1>");
            out.println("<form action='editItem.jsp?itemId=" + itemId + "' method='post'>");
            out.println("Item Name: <input type='text' name='name' value='" + name + "' /><br>");
            out.println("Price: <input type='text' name='price' value='" + price + "' /><br>");
            out.println("<input type='hidden' name='itemId' value='" + itemId + "' />");
            out.println("<input type='submit' value='Update' />");
            out.println("</form>");
            out.println("<img src='" + imageUrl + "' alt='" + name + "' /><br>");
        } else {
            out.println("<p>Item not found.</p>");
        }

        // Close ResultSet and PreparedStatement
        rs.close();
        ps.close();
    }
%>

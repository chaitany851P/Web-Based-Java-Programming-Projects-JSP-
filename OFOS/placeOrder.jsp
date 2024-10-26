<%@page import="java.sql.Connection, java.sql.PreparedStatement" %>
<%@include file="dbcon.jsp" %>
<link rel="stylesheet" type="text/css" href="style.css">

<%
    // Get the userId from session (assuming user is logged in)
    Integer userId = (Integer) session.getAttribute("userId");

    // Check if user is logged in
    if (userId == null) {
        out.println("<p>Please log in to place an order.</p>");
        return; // Stop further processing
    }

    // Get the itemId from the request parameter
    int itemId = Integer.parseInt(request.getParameter("itemId"));

    // Insert the order into the database
    String insertOrderQuery = "INSERT INTO orders (item_id, user_id) VALUES (?, ?)";
    PreparedStatement ps = conn.prepareStatement(insertOrderQuery);
    ps.setInt(1, itemId);
    ps.setInt(2, userId);

    // Execute the insert query
    int rowsAffected = ps.executeUpdate();

    // Check if the order was successfully placed
    if (rowsAffected > 0) {
        out.println("<h2>Order placed successfully!</h2>");
        
        
    } else {
        out.println("<h2>Failed to place the order. Please try again later.</h2>");
    }

    // Close the PreparedStatement
    ps.close();
%>

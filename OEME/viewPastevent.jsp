<%@ page import="java.sql.*" %>
<%@ include file="dbCon.jsp" %>
<html>
<head>
    <title>Past Events</title>
</head>
<body style="background-color:white;color:teal;">

<h2>Past Events</h2>

<%
    // Ensure user is logged in by checking session
    if (session.getAttribute("role") == null) {
        // If no session attribute for 'role', redirect to login page
        response.sendRedirect("login.jsp");
        return;
    }

    // Handle event deletion
    String deleteId = request.getParameter("delete");
    if (deleteId != null) {
        try {
            String deleteQuery = "DELETE FROM events WHERE id = ?";
            PreparedStatement deleteStmt = con.prepareStatement(deleteQuery);
            deleteStmt.setInt(1, Integer.parseInt(deleteId));
            deleteStmt.executeUpdate();
            deleteStmt.close();
            out.println("<p>Event deleted successfully.</p>");
        } catch (SQLException e) {
            out.println("<p>Error deleting event: " + e.getMessage() + "</p>");
        }
    }

    // Query to get past events
    String query = "SELECT * FROM events"; 
    Statement stmt = con.createStatement();
    ResultSet rs = stmt.executeQuery(query);

    // Check user role for displaying appropriate links
    boolean isAdmin = session.getAttribute("role").equals("admin");

    while (rs.next()) {
        String eventName = rs.getString("name");
        String description = rs.getString("description");
        String imgUrl = rs.getString("imgurl"); // Image URL from the database
        String date = rs.getString("date");
        String time = rs.getString("time");
        String budget = rs.getString("budget");
        
        // Display event details
        out.println("<h3>" + eventName + "</h3>");
        out.println("<p>Description: " + description + "</p>");
        out.println("<p>Date: " + date + "</p>");
        out.println("<p>Time: " + time + "</p>");
        out.println("<p>Budget: " + budget + "</p>");

        // Display the image using the imgurl field
        if (imgUrl != null && !imgUrl.isEmpty()) {
            out.println("<img src='" + imgUrl + "' alt='Event Image' style='width:300px;height:auto;' /><br>");
        } else {
            out.println("<p>No image available for this event.</p>");
        }

        // Display admin controls if the logged-in user is an admin
        if (isAdmin) {
            out.println("<a href='editEvent.jsp?id=" + rs.getInt("id") + "'>Edit</a> ");
            out.println("<a href='?delete=" + rs.getInt("id") + "' onclick='return confirm(\"Are you sure you want to delete this event?\");'>Delete</a>");
        }

        out.println("<hr>"); // For separating events
    }

    // Links for non-admin users
    if (!isAdmin) {
        out.println("<h3><a href='requestEvent.jsp'>Request</a></h3>");
        out.println("<h3><a href='approveEvent.jsp'>View Request</a></h3>");
    }

    rs.close();
    stmt.close();
%>

</body>
</html>

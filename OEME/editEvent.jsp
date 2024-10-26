<%@ page import="java.sql.*, java.math.BigDecimal" %>
<%@ include file="dbCon.jsp" %>
<html>
<head>
    <title>Edit Event</title>
</head>
<body style="background-color:white;color:teal;">

<h2>Edit Event</h2>

<%
    // Ensure user is logged in by checking session
    if (session.getAttribute("role") == null) {
        // If no session attribute for 'role', redirect to login page
        response.sendRedirect("login.jsp");
        return;
    }

    String message = "";

    // Get the event ID from the request
    String eventId = request.getParameter("id");
    if (eventId != null) {
        // Query to fetch event details
        String query = "SELECT * FROM events WHERE id = ?";
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setInt(1, Integer.parseInt(eventId));
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            // Populate fields with current event data
            String name = rs.getString("name");
            String description = rs.getString("description");
            String imgUrl = rs.getString("imgurl");
            String date = rs.getString("date");
            String time = rs.getString("time");
            BigDecimal budget = rs.getBigDecimal("budget");
%>

            <form method="post" action="editEvent.jsp?id=<%= eventId %>">
                <label for="eventName">Event Name:</label><br>
                <input type="text" id="eventName" name="eventName" value="<%= name %>" required><br><br>

                <label for="description">Description:</label><br>
                <textarea id="description" name="description" required><%= description %></textarea><br><br>

                <label for="imgUrl">Image URL:</label><br>
                <input type="text" id="imgUrl" name="imgUrl" value="<%= imgUrl %>"><br><br>

                <label for="date">Date:</label><br>
                <input type="date" id="date" name="date" value="<%= date %>" required><br><br>

                <label for="time">Time:</label><br>
                <input type="time" id="time" name="time" value="<%= time %>" required><br><br>

                <label for="budget">Budget:</label><br>
                <input type="number" id="budget" name="budget" step="0.01" min="0" value="<%= budget != null ? budget : "" %>" required><br><br>

                <input type="submit" value="Update Event">
            </form>

<%
        } else {
            message = "Event not found.";
        }
        rs.close();
        pstmt.close();
    }

    // Handle form submission for updating event
    if (request.getMethod().equalsIgnoreCase("post")) {
        String updatedEventId = request.getParameter("id");
        if (updatedEventId != null) {
            try {
                String updateQuery = "UPDATE events SET name = ?, description = ?, date = ?, time = ?, budget = ?, imgurl = ? WHERE id = ?";
                PreparedStatement updateStmt = con.prepareStatement(updateQuery);
                updateStmt.setString(1, request.getParameter("eventName"));
                updateStmt.setString(2, request.getParameter("description"));
                updateStmt.setString(3, request.getParameter("date"));
                updateStmt.setString(4, request.getParameter("time"));

                String budgetStr = request.getParameter("budget");
                if (budgetStr != null && !budgetStr.isEmpty()) {
                    updateStmt.setBigDecimal(5, new BigDecimal(budgetStr)); // Convert to BigDecimal for decimal handling
                } else {
                    message = "Budget is required and cannot be empty.";
                }

                updateStmt.setString(6, request.getParameter("imgUrl"));
                updateStmt.setInt(7, Integer.parseInt(updatedEventId));
                updateStmt.executeUpdate();
                updateStmt.close();
                message = "Event updated successfully!";
            } catch (SQLException e) {
                message = "Error updating event: " + e.getMessage();
            } catch (NumberFormatException e) {
                message = "Invalid budget format. Please enter a valid number.";
            }
        }
    }

    // Display any messages (success or error)
    if (!message.isEmpty()) {
        out.println("<p>" + message + "</p>");
    }
%>

</body>
</html>

<%@ include file="dbCon.jsp" %>
<html>
<head>
    <title>Requested Events</title>
</head>
<body style="background-color:white;color:teal;">
    <h2>Requested Events</h2>
    <%
        String query = "SELECT * FROM requested_events";
        PreparedStatement pst = con.prepareStatement(query);
        ResultSet rs = pst.executeQuery();

        // Check if any events are found
        if (!rs.next()) {
            out.println("<p>No events found.</p>");
        } else {
            // Process the first row
            do {
                out.println("<div>");
                out.println("<h3>" + rs.getString("name") + "</h3>");
                out.println("<p>Date: " + rs.getString("date") + "</p>");
                out.println("<p>Time: " + rs.getString("time") + "</p>");
                out.println("<p>Place: " + rs.getString("place") + "</p>");
                out.println("<p>Budget: " + rs.getString("budget") + "</p>");

                // Get the event ID to use in approve/disapprove actions
                int eventId = rs.getInt("id");

                // Add approve/disapprove links
                out.println("<a href='requestEventAction.jsp?action=approve&id=" + eventId + "'>Approve</a> | ");
                out.println("<a href='requestEventAction.jsp?action=disapprove&id=" + eventId + "'>Disapprove</a>");

                out.println("</div><hr>");
            } while (rs.next()); // Move to the next record
        }

        // Clean up
        rs.close();
        pst.close();
    %>
</body>
</html>

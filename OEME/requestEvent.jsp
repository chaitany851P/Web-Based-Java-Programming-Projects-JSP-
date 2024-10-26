<%@ include file="dbCon.jsp" %>
<html>
<head>
    <title>Request Event</title>
</head>
<body style="background-color:white;color:teal;">
    <h2>Request New Event</h2>
    <form action="requestEvent.jsp" method="post">
        <label>Event Name:</label> <input type="text" name="name" required><br>
        <label>Date:</label> <input type="date" name="date" required><br>
        <label>Time:</label> <input type="time" name="time" required><br>
        <label>Place:</label> <input type="text" name="place" required><br>
        <label>Budget:</label> <input type="number" name="budget" required><br>
        <button type="submit">Request Event</button>
    </form>

    <% 
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String name = request.getParameter("name");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String place = request.getParameter("place");
        String budget = request.getParameter("budget");
        
        // Get the username from the session
        String uname = (String) session.getAttribute("uname"); // Adjust based on how you store username

        // Check if username is not null
        if (uname == null) {
            out.println("<p>You must be logged in to request an event.</p>");
        } else {
            String query = "INSERT INTO requested_events (name, date, time, place, budget, uname) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, date);
            pst.setString(3, time);
            pst.setString(4, place);
            pst.setString(5, budget);
            pst.setString(6, uname); // Set the username

            pst.executeUpdate();

            out.println("<p>Event requested successfully!</p>");
        }
    }
    %>
</body>
</html>

<%@ include file="dbCon.jsp" %>
<html>
<head><title>Add Event</title></head>
<body style="background-color:white;color:teal;">
    <h2>Add New Event</h2>
    <form action="addEvents.jsp" method="post">
        <label>Name:</label> <input type="text" name="name" required><br>
        <label>Description:</label> <textarea name="description" required></textarea><br>
        <label>Image URL:</label> <input type="text" name="imgurl" required><br>
        <label>Date:</label> <input type="date" name="date" required><br>
        <label>Time:</label> <input type="time" name="time" required><br>
        <label>Budget:</label> <input type="number" name="budget" required><br>
        <button type="submit">Add Event</button>
    </form>

    <% 
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String imgurl = request.getParameter("imgurl");
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String budget = request.getParameter("budget");

        String query = "INSERT INTO events (name, description, imgurl, date, time, budget) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement pst = con.prepareStatement(query);
        pst.setString(1, name);
        pst.setString(2, description);
        pst.setString(3, imgurl);
        pst.setString(4, date);
        pst.setString(5, time);
        pst.setString(6, budget);
        pst.executeUpdate();

        out.println("<p>Event added successfully!</p>");
    }
    %>
</body>
</html>

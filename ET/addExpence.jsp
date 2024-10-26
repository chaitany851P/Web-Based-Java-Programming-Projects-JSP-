<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@include file="dbcon.jsp" %>
<html>
<head>
    <title>Add Expense</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script>
        window.onload = function() {
            // Set the current date
            var today = new Date();
            var date = today.toISOString().split('T')[0]; // Get YYYY-MM-DD format
            document.getElementById("date").value = date;

            // Set the current time
            var time = today.toTimeString().split(' ')[0].substring(0, 5); // Get HH:MM format
            document.getElementById("time").value = time;
        };
    </script>
</head>
<body>
    <div class="container">
        <h2>Add New Expense</h2>
        <form action="addExpence.jsp" method="post">
            Date: <input type="date" id="date" name="date" required><br>
            Time: <input type="time" id="time" name="time" required><br>
            Description: <input type="text" name="description" required><br>
            Amount: <input type="number" step="0.01" name="amount" required><br>
            <input type="submit" value="Add Expense" class="btn">
        </form>
    </div>
</body>
</html>

<%
    if(request.getMethod().equals("POST")){
        // No need to declare HttpSession, just use the session object
        int userid = (Integer)session.getAttribute("userid");

        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String description = request.getParameter("description");
        double amount = Double.parseDouble(request.getParameter("amount"));
        
        Connection con = (Connection)application.getAttribute("dbcon");
        PreparedStatement ps = con.prepareStatement("INSERT INTO expenses(userid, date, time, description, amount) VALUES(?, ?, ?, ?, ?)");
        ps.setInt(1, userid);
        ps.setString(2, date);
        ps.setString(3, time);
        ps.setString(4, description);
        ps.setDouble(5, amount);
        ps.executeUpdate();
        
        response.sendRedirect("viewExpence.jsp");
    }
%>

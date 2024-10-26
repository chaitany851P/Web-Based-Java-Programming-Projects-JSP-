<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Request Appointment</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Request Appointment</h2>
    <form action="requestAppointment.jsp" method="post">
        <p>Booking appointment with: <strong><%= request.getParameter("doctorname") %></strong></p>
        <input type="hidden" name="doctorname" value="<%= request.getParameter("doctorname") %>">
        <input type="hidden" name="userid" value="<%= request.getParameter("userid") %>">
        <input type="hidden" name="doctorid" value="<%= request.getParameter("doctorid") %>">
        <input type="date" name="appointment_date" required>
        <input type="time" name="appointment_time" required>
        <input type="submit" value="Book Appointment">
    </form>

    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String doctorname = request.getParameter("doctorname");
            String userid = request.getParameter("userid"); // Get the current user ID
            String doctorid = request.getParameter("doctorid"); // Get the selected doctor ID
            String date = request.getParameter("appointment_date");
            String time = request.getParameter("appointment_time");

            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                conn = getConnection();
                String sql = "INSERT INTO appointments (userid, doctorid, appointment_date, appointment_time, status) VALUES (?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userid); // Set user ID
                pstmt.setString(2, doctorid); // Set doctor ID
                pstmt.setString(3, date);
                pstmt.setString(4, time);
                pstmt.setString(5, "pending"); // Set the status to "pending" or whatever is appropriate
                
                int result = pstmt.executeUpdate();
                if (result > 0) {
                    out.println("<p>Appointment booked successfully.</p>");
                } else {
                    out.println("<p>Failed to book appointment.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            }
        }
    %>
</body>
</html>

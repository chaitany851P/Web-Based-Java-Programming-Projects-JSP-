<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Your Appointments</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Your Appointments</h2>
    <table>
        <tr>
            <th>Appointment ID</th>
            <th>Doctor ID</th>
            <th>Appointment Date</th>
            <th>Appointment Time</th>
            <th>Status</th>
        </tr>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = getConnection();
                 // Debug message

                // Ensure that the user ID is set in the session
                Integer currentUserId = (Integer) session.getAttribute("userid");
                if (currentUserId == null) {
                    out.println("<p>You must log in to view your appointments.</p>");
                    return; // Stop processing if the user is not logged in
                }

                 // Debug message

                String sql = "SELECT * FROM appointments WHERE userid = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, currentUserId);
                rs = pstmt.executeQuery();

                if (!rs.isBeforeFirst()) { // Check if the result set is empty
                    out.println("<tr><td colspan='5'>No appointments found.</td></tr>");
                } else {
                    while (rs.next()) {
                        int appointmentId = rs.getInt("id");
                        int doctorId = rs.getInt("doctorid");
                        String appointmentDate = rs.getString("appointment_date");
                        String appointmentTime = rs.getString("appointment_time");
                        String status = rs.getString("status");
        %>
        <tr>
            <td><%= appointmentId %></td>
            <td><%= doctorId %></td>
            <td><%= appointmentDate %></td>
            <td><%= appointmentTime %></td>
            <td><%= status %></td>
        </tr>
        <%
                    }
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage()); // Debug message
                e.printStackTrace(); // Print stack trace for debugging
            } finally {
                if (rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }
            }
        %>
    </table>
</body>
</html>

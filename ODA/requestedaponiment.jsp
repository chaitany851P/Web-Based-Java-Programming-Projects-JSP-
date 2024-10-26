<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Requested Appointments</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Requested Appointments</h2>
    <table>
        <tr>
            <th>Appointment ID</th>
            <th>User ID</th>
            <th>Doctor ID</th>
            <th>Appointment Date</th>
            <th>Appointment Time</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                conn = getConnection();
                stmt = conn.createStatement();
                String sql = "SELECT * FROM appointments WHERE status = 'pending'";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    int appointmentId = rs.getInt("id"); // Assuming there's a column 'id' for appointment ID
                    int userId = rs.getInt("userid");
                    int doctorId = rs.getInt("doctorid");
                    String appointmentDate = rs.getString("appointment_date");
                    String appointmentTime = rs.getString("appointment_time");
                    String status = rs.getString("status");
        %>
        <tr>
            <td><%= appointmentId %></td>
            <td><%= userId %></td>
            <td><%= doctorId %></td>
            <td><%= appointmentDate %></td>
            <td><%= appointmentTime %></td>
            <td><%= status %></td>
            <td>
                <form action="" method="post" style="display:inline;">
                    <input type="hidden" name="appointment_id" value="<%= appointmentId %>">
                    <input type="hidden" name="action" value="approve">
                    <input type="submit" value="Approve">
                </form>
                <form action="" method="post" style="display:inline;">
                    <input type="hidden" name="appointment_id" value="<%= appointmentId %>">
                    <input type="hidden" name="action" value="disapprove">
                    <input type="submit" value="Disapprove">
                </form>
            </td>
        </tr>
        <%
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace(); }
                if (stmt != null) try { stmt.close(); } catch(SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }
            }

            // Handling the form submission for approving/disapproving appointments
            if (request.getMethod().equalsIgnoreCase("POST")) {
                int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));
                String action = request.getParameter("action");
                PreparedStatement pstmt = null;

                try {
                    conn = getConnection();
                    if ("approve".equals(action)) {
                        String sql = "UPDATE appointments SET status = 'approved' WHERE id = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, appointmentId);
                        int result = pstmt.executeUpdate();

                        if (result > 0) {
                            out.println("<script>alert('Appointment approved successfully.');</script>");
                        } else {
                            out.println("<script>alert('Failed to approve appointment.');</script>");
                        }
                    } else if ("disapprove".equals(action)) {
                        String sql = "DELETE FROM appointments WHERE id = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, appointmentId);
                        int result = pstmt.executeUpdate();

                        if (result > 0) {
                            out.println("<script>alert('Appointment disapproved and deleted successfully.');</script>");
                        } else {
                            out.println("<script>alert('Failed to disapprove appointment.');</script>");
                        }
                    }
                } catch(Exception e) {
                    e.printStackTrace();
                } finally {
                    if (pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }
                }
            }
        %>
    </table>
</body>
</html>

<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>View Doctors</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Doctors List</h2>
    <table>
        <tr>
            <th>Doctor Name</th>
            <th>Age</th>
            <th>Degree</th>
            <th>Image</th>
            <th>Action</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                conn = getConnection();
                stmt = conn.createStatement();
                String sql = "SELECT * FROM doctors";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String doctorname = rs.getString("doctorname");
                    int age = rs.getInt("age");
                    String degree = rs.getString("degree");
                    String img = rs.getString("img");
                    int doctorId = rs.getInt("id"); // Assuming there's a column 'id' for doctor ID
                    // Retrieve current user ID from session
                    Integer currentUserId = (Integer) session.getAttribute("userid"); // Use actual user ID from session

                    if (currentUserId == null) {
                        out.println("<tr><td colspan='5'>Please log in to book appointments.</td></tr>");
                        break;
                    }
        %>
        <tr>
            <td><%= doctorname %></td>
            <td><%= age %></td>
            <td><%= degree %></td>
            <td><img src="<%= img %>" alt="Doctor Image" style="width:100px;height:auto;"></td>
            <td>
                <form action="requestAppointment.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="doctorname" value="<%= doctorname %>">
                    <input type="hidden" name="age" value="<%= age %>">
                    <input type="hidden" name="degree" value="<%= degree %>">
                    <input type="hidden" name="userid" value="<%= currentUserId %>"> <!-- Current user's ID -->
                    <input type="hidden" name="doctorid" value="<%= doctorId %>"> <!-- Doctor's ID -->
                    <input type="submit" value="Book Appointment">
                </form>
                <form action="UserAppointments.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="userid" value="<%= currentUserId %>"> <!-- Pass user ID to UserAppointments -->
                    <button type="submit">View My Appointments</button>
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
        %>
    </table>
</body>
</html>

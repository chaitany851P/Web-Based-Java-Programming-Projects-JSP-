<%@ include file="database.jsp" %>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">

    </head>
<body>
    <h2>Admin Dashboard</h2>
    <h3>All USERs' Attendance</h3>
    
    <%
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            String sql = "SELECT a.id, u.username, a.pinch_in, a.pinch_out FROM attendance a JOIN users u ON a.user_id = u.id";
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();

            out.println("<table border='1'><tr><th>Employee</th><th>Pinch In</th><th>Pinch Out</th><th>Actions</th></tr>");
            while(rs.next()) {
                int attendanceId = rs.getInt("id");
                out.println("<tr>");
                out.println("<td>" + rs.getString("username") + "</td>");
                out.println("<td>" + rs.getTimestamp("pinch_in") + "</td>");
                out.println("<td>" + rs.getTimestamp("pinch_out") + "</td>");
                out.println("<td>");
                out.println("<a href='editAttendance.jsp?id=" + attendanceId + "'>Edit</a> | ");
                out.println("<a href='deleteAttendance.jsp?id=" + attendanceId + "'>Delete</a>");
                
                out.println("</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        } catch(Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if(rs != null) rs.close();
            if(pst != null) pst.close();
            if(conn != null) conn.close();
        }
    %>
</body>
</html>

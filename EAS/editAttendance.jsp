<%@ include file="database.jsp" %>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">

    </head>
<body>
    <h2>Edit Attendance</h2>

    <%
        String id = request.getParameter("id");
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String pinchIn = "";
        String pinchOut = "";

        if(id != null) {
            try {
                conn = getConnection();
                String sql = "SELECT pinch_in, pinch_out FROM attendance WHERE id=?";
                pst = conn.prepareStatement(sql);
                pst.setString(1, id);
                rs = pst.executeQuery();

                if(rs.next()) {
                    pinchIn = rs.getTimestamp("pinch_in").toString();
                    pinchOut = rs.getTimestamp("pinch_out").toString();
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if(rs != null) rs.close();
                if(pst != null) pst.close();
                if(conn != null) conn.close();
            }
        }
    %>

    <form action="editAttendance.jsp" method="post">
        Pinch In: <input type="datetime-local" name="pinch_in" value="<%=pinchIn.substring(0, 16)%>"><br>
        Pinch Out: <input type="datetime-local" name="pinch_out" value="<%=pinchOut.substring(0, 16)%>"><br>
        <input type="hidden" name="id" value="<%=id%>">
        <input type="submit" value="Update">
    </form>

    <%
        if(request.getMethod().equalsIgnoreCase("post")) {
            String pinchInUpdated = request.getParameter("pinch_in");
            String pinchOutUpdated = request.getParameter("pinch_out");
            String attendanceId = request.getParameter("id");

            try {
                conn = getConnection();
                String sql = "UPDATE attendance SET pinch_in=?, pinch_out=? WHERE id=?";
                pst = conn.prepareStatement(sql);
                pst.setString(1, pinchInUpdated);
                pst.setString(2, pinchOutUpdated);
                pst.setString(3, attendanceId);
                int result = pst.executeUpdate();

                if(result > 0) {
                    out.println("Attendance record updated successfully!");
                    response.sendRedirect("Adminview.jsp");
                } else {
                    out.println("Failed to update attendance record.");
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if(pst != null) pst.close();
                if(conn != null) conn.close();
            }
        }
    %>

</body>
</html>

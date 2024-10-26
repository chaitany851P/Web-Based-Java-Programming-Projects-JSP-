<%@ include file="database.jsp" %>
<html>
<body>
    <h2>Delete Attendance Record</h2>

    <%
        String id = request.getParameter("id");
        Connection conn = null;
        PreparedStatement pst = null;

        if(id != null) {
            try {
                conn = getConnection();
                String sql = "DELETE FROM attendance WHERE id=?";
                pst = conn.prepareStatement(sql);
                pst.setString(1, id);
                int result = pst.executeUpdate();

                if(result > 0) {
                    out.println("Attendance record deleted successfully!");
                } else {
                    out.println("Failed to delete the record.");
                }
            } catch(Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if(pst != null) pst.close();
                if(conn != null) conn.close();
            }
        }
        response.sendRedirect("Adminview.jsp");
    %>

</body>
</html>

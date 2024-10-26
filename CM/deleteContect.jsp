<%@ include file="dbcon.jsp" %>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("id");
    String query = "DELETE FROM contacts WHERE id=?";
    PreparedStatement pst = conn.prepareStatement(query);
    pst.setString(1, id);

    int result = pst.executeUpdate();
    if (result > 0) {
        response.sendRedirect("viewContect.jsp");
    } else {
        out.println("<p style='color:red;'>Failed to delete contact!</p>");
    }
%>

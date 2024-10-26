<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection con = (Connection)application.getAttribute("dbcon");
    PreparedStatement ps = con.prepareStatement("DELETE FROM expenses WHERE id=?");
    ps.setInt(1, id);
    ps.executeUpdate();
    response.sendRedirect("viewExpence.jsp");
%>

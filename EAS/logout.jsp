<%
    // Invalidate session
    if (session != null) {
        session.invalidate();
    }
    response.sendRedirect("login.jsp");
%>

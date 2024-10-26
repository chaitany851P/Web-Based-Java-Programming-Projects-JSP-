<%@ include file="dbCon.jsp" %>
<%
    String action = request.getParameter("action");
    int eventId = Integer.parseInt(request.getParameter("id"));

    if ("approve".equals(action)) {
        String updateQuery = "UPDATE requested_events SET status = 'approved' WHERE id = ?";
        PreparedStatement pst = con.prepareStatement(updateQuery);
        pst.setInt(1, eventId);
        pst.executeUpdate();
        pst.close();
    } else if ("disapprove".equals(action)) {
        String updateQuery = "UPDATE requested_events SET status = 'disapproved' WHERE id = ?";
        PreparedStatement pst = con.prepareStatement(updateQuery);
        pst.setInt(1, eventId);
        pst.executeUpdate();
        pst.close();
    }

    // Optionally, you can send a response back if needed
    out.print("Success"); // Or any other response
%>

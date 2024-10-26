<%@ include file="dbCon.jsp" %>
<%
    String uname = (String) session.getAttribute("uname"); 

    // Check if username is null or empty
    if (uname == null || uname.isEmpty()) {
        out.println("<h2>Error</h2>");
        out.println("<p>No username provided. Please log in to view your requests.</p>");
    } else {
        PreparedStatement pst = null;
        ResultSet rs = null;
        
        try {
            String query = "SELECT * FROM requested_events WHERE uname = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, uname);
            rs = pst.executeQuery();

            if (rs.next()) {
                out.println("<h2>Requested Events for User: " + uname + "</h2>");
                do {
                    out.println("<div>");
                    out.println("<h3>" + rs.getString("name") + "</h3>");
                    out.println("<p>Date: " + rs.getString("date") + "</p>");
                    out.println("<p>Time: " + rs.getString("time") + "</p>");
                    out.println("<p>Place: " + rs.getString("place") + "</p>");
                    out.println("<p>Budget: " + rs.getString("budget") + "</p>");

                    // Check the approval status
                    String status = rs.getString("status");
                    if ("approved".equalsIgnoreCase(status)) {
                        out.println("<p>Status: <strong style='color:green;'>Approved</strong></p>");
                    } else if ("disapproved".equalsIgnoreCase(status)) {
                        out.println("<p>Status: <strong style='color:red;'>Disapproved</strong></p>");
                    } else {
                        out.println("<p>Status: <strong style='color:orange;'>Pending</strong></p>");
                    }
                    out.println("</div><hr>");
                } while (rs.next());
            } else {
                out.println("<p>No events found for the specified username.</p>");
            }
        } catch (SQLException e) {
            out.println("<h2>Error occurred while retrieving events.</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
        } finally {
            // Clean up resources
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (pst != null) try { pst.close(); } catch (SQLException e) {}
            if (con != null) try { con.close(); } catch (SQLException e) {}
        }
    }
%>

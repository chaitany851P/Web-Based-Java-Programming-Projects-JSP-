<%@ include file="database.jsp" %>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">

    </head>
<body>
    <h2>USER Dashboard</h2>
    <form action="Empview.jsp" method="post">
        <input type="submit" name="action" value="Pinch In"><br><br>
        <input type="submit" name="action" value="Pinch Out">
    </form>

    <%
        String action = request.getParameter("action");
        if(action != null) {
            Connection conn = null;
            PreparedStatement pst = null;
            try {
                conn = getConnection();
                int userId = 7; // Assuming logged-in user's ID
                if(action.equals("Pinch In")) {
                    String sql = "INSERT INTO attendance (user_id, pinch_in) VALUES (?, NOW())";
                    pst = conn.prepareStatement(sql);
                    pst.setInt(1, userId);
                    pst.executeUpdate();
                    out.println("Pinch In successful!");
                } else if(action.equals("Pinch Out")) {
                    String sql = "UPDATE attendance SET pinch_out = NOW() WHERE user_id = ? AND pinch_out IS NULL";
                    pst = conn.prepareStatement(sql);
                    pst.setInt(1, userId);
                    pst.executeUpdate();
                    out.println("Pinch Out successful!");
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

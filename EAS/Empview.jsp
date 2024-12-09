<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ include file="database.jsp" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        .logout-btn {
            background-color: #ff4d4d; /* Red background */
            color: white;
            padding: 8px 15px;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .logout-btn:hover {
            background-color: #e60000; /* Darker red on hover */
        }
    </style>
</head>
<body>
    <a href="login.jsp" class="logout-btn">Logout</a>
    <h2>USER Dashboard</h2>
    <%
        // Get user ID from session
        if (session == null || session.getAttribute("userId") == null) {
            out.println("Please log in first!");
            response.sendRedirect("login.jsp");
        } else {
            int userId = (Integer) session.getAttribute("userId");
    %>
    <form action="Empview.jsp" method="post">
        <input type="submit" name="action" value="Pinch In"><br><br>
        <input type="submit" name="action" value="Pinch Out">
    </form>
    
    <!-- Logout Button -->
    

    <%
        String action = request.getParameter("action");
        if (action != null) {
            Connection conn = null;
            PreparedStatement pst = null;
            try {
                conn = getConnection();
                if (action.equals("Pinch In")) {
                    String sql = "INSERT INTO attendance (user_id, pinch_in) VALUES (?, NOW())";
                    pst = conn.prepareStatement(sql);
                    pst.setInt(1, userId);
                    pst.executeUpdate();
                    out.println("Pinch In successful!");
                } else if (action.equals("Pinch Out")) {
                    String sql = "UPDATE attendance SET pinch_out = NOW() WHERE user_id = ? AND pinch_out IS NULL";
                    pst = conn.prepareStatement(sql);
                    pst.setInt(1, userId);
                    pst.executeUpdate();
                    out.println("Pinch Out successful!");
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            }
        }
    %>
</body>
</html>
<%
        }
    %>

<%@ page import="java.sql.*" %>
<%@ include file="dbconnect.jsp" %>
<html>
<head>
    <title>Approved Appointments</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Your Approved Appointments</h2>
    <table>
        <tr>
            <th>Doctor Name</th>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
        </tr>
        <%
            String username = (String) session.getAttribute("username");

            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = getConnection();
                String sql = "SELECT * FROM appointments WHERE status='Approved' AND username=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();

                while(rs.next()) {
                    String doctorname = rs.getString("doctorname");
                    String date = rs.getString("date");
                    String time = rs.getString("time");
                    String status = rs.getString("status");
        %>
        <tr>
            <td><%= doctorname %></td>
            <td><%= date %></td>
            <td><%= time %></td>
            <td><%= status %></td>
        </tr>
        <%
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            }
        %>
    </table>
</body>
</html>

<%@ include file="database.jsp" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        /* CSS for logout button and table styling */
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
        table {
            margin-top: 50px;
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }
        
        a.delete-link {
            color: red; /* Delete link in red */
            text-decoration: none;
            font-weight: bold;
        }
        a.delete-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <!-- Logout Button -->
    <a href="login.jsp" class="logout-btn">Logout</a>

    <h2>Admin Dashboard</h2>
    <h3>All USERs' Attendance</h3>
    
    <%
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            conn = getConnection();
            String sql = "SELECT a.id, u.username, a.pinch_in, a.pinch_out FROM attendance a JOIN users u ON a.user_id = u.id";
            pst = conn.prepareStatement(sql);
            rs = pst.executeQuery();

            out.println("<table>");
            out.println("<tr><th>Employee</th><th>Pinch In</th><th>Pinch Out</th><th>Actions</th></tr>");
            while(rs.next()) {
                int attendanceId = rs.getInt("id");
                out.println("<tr>");
                out.println("<td>" + rs.getString("username") + "</td>");
                out.println("<td>" + rs.getTimestamp("pinch_in") + "</td>");
                out.println("<td>" + rs.getTimestamp("pinch_out") + "</td>");
                out.println("<td>");
                out.println("<a href='editAttendance.jsp?id=" + attendanceId + "'>Edit</a> | ");
                out.println("<a href='deleteAttendance.jsp?id=" + attendanceId + "' class='delete-link'>Delete</a>");
                out.println("</td>");
                out.println("</tr>");
            }
            out.println("</table>");
        } catch(Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        } finally {
            if(rs != null) rs.close();
            if(pst != null) pst.close();
            if(conn != null) conn.close();
        }
    %>
</body>
</html>

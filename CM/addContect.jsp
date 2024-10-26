<%@ include file="dbcon.jsp" %>
<%@ page import="java.sql.*" %>
<%
    // The session object is already available, so you don't need to declare it again
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
    }
%>

<html>
<head>
    <title>Add Contact</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Add New Contact</h2>
    <form action="addContect.jsp" method="post">
        Name: <input type="text" name="name" required><br>
        Phone: <input type="text" name="phone" required><br>
        Email: <input type="email" name="email" required><br>
        Address: <input type="text" name="address" required><br>
        <input type="submit" value="Add Contact">
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String user_email = (String) session.getAttribute("email");
            String query = "INSERT INTO contacts(user_id, name, phone, email, address) VALUES ((SELECT id FROM users WHERE email=?), ?, ?, ?, ?)";
            
            PreparedStatement pst = conn.prepareStatement(query);
            pst.setString(1, user_email);
            pst.setString(2, name);
            pst.setString(3, phone);
            pst.setString(4, email);
            pst.setString(5, address);
            
            int result = pst.executeUpdate();
            if (result > 0) {
                response.sendRedirect("viewContect.jsp");
            } else {
                out.println("<p style='color:red;'>Failed to add contact!</p>");
            }
        }
    %>
</body>
</html>

<%@ include file="dbcon.jsp" %>
<%@ page import="java.sql.*" %>
<%
    // The session object is already available, so you don't need to declare it again
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
    }


    String id = request.getParameter("id");
    String query = "SELECT * FROM contacts WHERE id=?";
    PreparedStatement pst = conn.prepareStatement(query);
    pst.setString(1, id);
    ResultSet rs = pst.executeQuery();

    String name = "", phone = "", email = "", address = "";
    if (rs.next()) {
        name = rs.getString("name");
        phone = rs.getString("phone");
        email = rs.getString("email");
        address = rs.getString("address");
    }
%>

<html>
<head>
    <title>Edit Contact</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Edit Contact</h2>
    <form action="editContect.jsp?id=<%= id %>" method="post">
        Name: <input type="text" name="name" value="<%= name %>" required><br>
        Phone: <input type="text" name="phone" value="<%= phone %>" required><br>
        Email: <input type="email" name="email" value="<%= email %>" required><br>
        Address: <input type="text" name="address" value="<%= address %>" required><br>
        <input type="submit" value="Update Contact">
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            name = request.getParameter("name");
            phone = request.getParameter("phone");
            email = request.getParameter("email");
            address = request.getParameter("address");

            String updateQuery = "UPDATE contacts SET name=?, phone=?, email=?, address=? WHERE id=?";
            pst = conn.prepareStatement(updateQuery);
            pst.setString(1, name);
            pst.setString(2, phone);
            pst.setString(3, email);
            pst.setString(4, address);
            pst.setString(5, id);

            int result = pst.executeUpdate();
            if (result > 0) {
                response.sendRedirect("viewContect.jsp");
            } else {
                out.println("<p style='color:red;'>Failed to update contact!</p>");
            }
        }
    %>
</body>
</html>

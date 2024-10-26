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
    <title>Contact Manager</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Welcome, <%= session.getAttribute("email") %></h2> <a href="login.jsp">Logout</a>
    <form action="viewContect.jsp" method="get">
        Search: <input type="text" name="search">
        <input type="submit" value="Search">
    </form>
    <br>
    <a href="addContect.jsp">Add New Contact</a> | 
    <h3>Your Contacts</h3>

    <%
        String searchQuery = request.getParameter("search");
        String email = (String) session.getAttribute("email");
        String query = "SELECT * FROM contacts WHERE user_id = (SELECT id FROM users WHERE email=?)";
        
        if (searchQuery != null && !searchQuery.isEmpty()) {
            query += " AND name LIKE ?";
        }

        PreparedStatement pst = conn.prepareStatement(query);
        pst.setString(1, email);
        if (searchQuery != null && !searchQuery.isEmpty()) {
            pst.setString(2, "%" + searchQuery + "%");
        }

        ResultSet rs = pst.executeQuery();
        while (rs.next()) {
            out.println("<div>");
            out.println("Name: " + rs.getString("name") + "<br>");
            out.println("Phone: " + rs.getString("phone") + "<br>");
            out.println("Email: " + rs.getString("email") + "<br>");
            out.println("Address: " + rs.getString("address") + "<br>");
            out.println("<a href='editContect.jsp?id=" + rs.getInt("id") + "'>Edit</a> | ");
            out.println("<a href='deleteContect.jsp?id=" + rs.getInt("id") + "'>Delete</a>");
            out.println("</div><br>");
        }
    %>
</body>
</html>

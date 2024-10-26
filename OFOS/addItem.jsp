<%@include file="dbcon.jsp" %>
<%
    if (request.getParameter("addItem") != null) {
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String imageUrl = request.getParameter("image_url");

        String query = "INSERT INTO items (name, price, image_url) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, name);
        ps.setString(2, price);
        ps.setString(3, imageUrl);
        ps.executeUpdate();

        response.sendRedirect("ViewItem.jsp?role=admin");
    }
%>
<link rel="stylesheet" type="text/css" href="style.css">
<h1>ADD item</h1>
<form method="POST">
    Name: <input type="text" name="name" required /><br>
    Price: <input type="text" name="price" required /><br>
    Image URL: <input type="text" name="image_url" required /><br>
    <input type="submit" name="addItem" value="Add Item" />
</form>

<%@ include file="database.jsp" %>
<html>
    <head>
        <link rel="stylesheet" href="style.css">
    </head>
<body>
    <h2>Add New Plant</h2>
    <form action="addPlant.jsp" method="post">
        Plant Name: <input type="text" name="name"><br>
        Image URL: <input type="text" name="img_url"><br>
        Price: <input type="text" name="price"><br>
        <input type="submit" value="Add Plant">
    </form>
    <%
        if(request.getParameter("name") != null) {
            String name = request.getParameter("name");
            String img_url = request.getParameter("img_url");
            String price = request.getParameter("price");

            try {
                String query = "INSERT INTO plants (name, img_url, price) VALUES (?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, name);
                stmt.setString(2, img_url);
                stmt.setString(3, price);
                stmt.executeUpdate();
                out.println("Plant added successfully! <a href='viewPlant.jsp'>View Plants</a>");
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error adding plant.");
            }
        }
    %>
</body>
</html>

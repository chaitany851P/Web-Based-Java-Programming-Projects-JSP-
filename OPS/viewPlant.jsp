<%@ include file="database.jsp" %>
<html>
    
<head>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h2>Available Plants</h2>
    <%
        try {
            String query = "SELECT * FROM plants";
            PreparedStatement stmt = conn.prepareStatement(query);
            ResultSet rs = stmt.executeQuery();

            while(rs.next()) {
                out.println("<div>");
                out.println("<h3>" + rs.getString("name") + "</h3>");
                out.println("<img src='" + rs.getString("img_url") + "' width='100' height='100'/><br>");
                out.println("Price: $" + rs.getString("price") + "<br>");
                out.println("<form action='buyPlant.jsp' method='post'>");
                out.println("<input type='hidden' name='plant_id' value='" + rs.getInt("id") + "'/>");
                out.println("<input type='submit' value='Buy Plant'/>");
                out.println("</form>");
                out.println("</div><hr>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</body>
</html>

<%@ page import="java.sql.*, javax.servlet.http.*" %>
<html>
<head>
    <title>Edit Expense</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <style>
        body{
            align-items: center;
        }
    </style>
</head>
<body>
    <div class="container">
    <h2>Edit Expense</h2>

    <%
        int id = Integer.parseInt(request.getParameter("id"));
        Connection con = (Connection)application.getAttribute("dbcon");
        PreparedStatement ps = con.prepareStatement("SELECT * FROM expenses WHERE id=?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
    %>
    <form action="editExpence.jsp?id=<%= id %>" method="post">
        Date: <input type="date" name="date" value="<%= rs.getString("date") %>" required><br>
        Time: <input type="time" name="time" value="<%= rs.getString("time") %>" required><br>
        Description: <input type="text" name="description" value="<%= rs.getString("description") %>" required><br>
        Amount: <input type="number" step="0.01" name="amount" value="<%= rs.getDouble("amount") %>" required><br>
        <input type="submit" value="Save Changes" class="btn">
    </form>
    <%
        }
    %>
    </div>
</body>
</html>

<%
    if(request.getMethod().equals("POST")){
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        String description = request.getParameter("description");
        double amount = Double.parseDouble(request.getParameter("amount"));
        
        ps = con.prepareStatement("UPDATE expenses SET date=?, time=?, description=?, amount=? WHERE id=?");
        ps.setString(1, date);
        ps.setString(2, time);
        ps.setString(3, description);
        ps.setDouble(4, amount);
        ps.setInt(5, id);
        ps.executeUpdate();
        
        response.sendRedirect("viewExpence.jsp");
    }
%>

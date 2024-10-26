<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@include file="dbcon.jsp" %>
<html>
<head>
    <title>View Expenses</title>
    <link rel="stylesheet" type="text/css" href="style.css">

</head>
<body>
    <div class="container">
        <h2>Your Expenses</h2>
        <a href="login.jsp" style="background: red;color: ;" class="btn">Logout</a>

        <%
            if(session.getAttribute("userid") == null){
                response.sendRedirect("login.jsp");
            }

            Connection con = (Connection)application.getAttribute("dbcon");
            int userid = (Integer)session.getAttribute("userid");

            // Fetch filter date from the request
            String date = request.getParameter("date");

            String query = "SELECT * FROM expenses WHERE userid=?";
            if (date != null && !date.isEmpty()) {
                query += " AND date = ?";
            }

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userid);

            if (date != null && !date.isEmpty()) {
                ps.setString(2, date);
            }

            ResultSet rs = ps.executeQuery();
        %>

        <!-- Form to filter expenses by a single date -->
        <form action="viewExpence.jsp" method="get">
            Date: <input type="date" name="date" value="<%= date != null ? date : "" %>">
            <input type="submit" value="Filter" class="btn">
        </form>

        <table>
            <tr>
                <th>Date</th>
                <th>Time</th>
                <th>Description</th>
                <th>Amount</th>
                <th>Actions</th>
            </tr>
            <%
                while(rs.next()){
            %>
            <tr>
                <td><%= rs.getString("date") %></td>
                <td><%= rs.getString("time") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getDouble("amount") %></td>
                <td>
                    <a href="editExpence.jsp?id=<%= rs.getInt("id") %>">Edit</a>
                    <a href="removeExpence.jsp?id=<%= rs.getInt("id") %>">Remove</a>
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <a href="addExpence.jsp" class="btn">Add New Expense</a>
    </div>
</body>
</html>
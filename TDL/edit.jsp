<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>

<%
    int taskId = Integer.parseInt(request.getParameter("task_id"));
    String selectTask = "SELECT * FROM tasks WHERE task_id=?";
    PreparedStatement ps = conn.prepareStatement(selectTask);
    ps.setInt(1, taskId);
    ResultSet rs = ps.executeQuery();
    rs.next();
%>
<link rel="stylesheet" href="styles.css">
<h2>Edit Task</h2>
<div class="container">
<form action="edit.jsp" method="post">
    <input type="hidden" name="task_id" value="<%= taskId %>" />
    <input type="text" name="task_name" value="<%= rs.getString("task_name") %>" required />
    <textarea name="task_description"><%= rs.getString("task_description") %></textarea>
    <input type="date" name="due_date" value="<%= rs.getDate("due_date") %>" required />
    <select name="status">
        <option value="Pending" <%= rs.getString("status").equals("Pending") ? "selected" : "" %>>Pending</option>
        <option value="Completed" <%= rs.getString("status").equals("Completed") ? "selected" : "" %>>Completed</option>
    </select>
    <button type="submit" name="update_task">Update Task</button>
</form>
</div>
<%
    // Update Task Logic
    if (request.getParameter("update_task") != null) {
        String taskName = request.getParameter("task_name");
        String taskDescription = request.getParameter("task_description");
        String dueDate = request.getParameter("due_date");
        String status = request.getParameter("status");

        String updateTask = "UPDATE tasks SET task_name=?, task_description=?, due_date=?, status=? WHERE task_id=?";
        PreparedStatement psUpdate = conn.prepareStatement(updateTask);
        psUpdate.setString(1, taskName);
        psUpdate.setString(2, taskDescription);
        psUpdate.setString(3, dueDate);
        psUpdate.setString(4, status);
        psUpdate.setInt(5, taskId);
        psUpdate.executeUpdate();

        response.sendRedirect("index.jsp");
    }
%>

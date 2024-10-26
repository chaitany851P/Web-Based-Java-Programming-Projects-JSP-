<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="styles.css">
    <title>To-Do List</title>
</head>
<body>
    <div class="container">
        <h2>To-Do List</h2>
        <a href="add.jsp" class="btn">Add New Task</a>

        <table border="1">
            <tr>
                <th>Task</th>
                <th>Description</th>
                <th>Due Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        <%
            String selectTasks = "SELECT * FROM tasks WHERE status = 'Pending'";
            PreparedStatement ps = conn.prepareStatement(selectTasks);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("task_name") %></td>
                <td><%= rs.getString("task_description") %></td>
                <td><%= rs.getDate("due_date") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <a href="edit.jsp?task_id=<%= rs.getInt("task_id") %>">Edit</a> |
                    <a href="index.jsp?delete_task=<%= rs.getInt("task_id") %>">Delete</a> |
                    <a href="index.jsp?complete_task=<%= rs.getInt("task_id") %>">Mark as Completed</a>
                </td>
            </tr>
        <%
            }
        %>
        </table>

        <%
            // Delete Task
            if (request.getParameter("delete_task") != null) {
                int taskId = Integer.parseInt(request.getParameter("delete_task"));

                String deleteTask = "DELETE FROM tasks WHERE task_id=?";
                PreparedStatement psDelete = conn.prepareStatement(deleteTask);
                psDelete.setInt(1, taskId);
                psDelete.executeUpdate();

                response.sendRedirect("index.jsp");
            }

            // Mark Task as Completed (removes completed tasks)
            if (request.getParameter("complete_task") != null) {
                int taskId = Integer.parseInt(request.getParameter("complete_task"));

                String markCompleted = "UPDATE tasks SET status='Completed' WHERE task_id=?";
                PreparedStatement psComplete = conn.prepareStatement(markCompleted);
                psComplete.setInt(1, taskId);
                psComplete.executeUpdate();

                String removeCompleted = "DELETE FROM tasks WHERE status='Completed'";
                PreparedStatement psRemove = conn.prepareStatement(removeCompleted);
                psRemove.executeUpdate();

                response.sendRedirect("index.jsp");
            }
        %>
    </div>
</body>
</html>

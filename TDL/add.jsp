<%@ include file="db.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="styles.css">
    <title>Add New Task</title>
</head>
<body>
    <div class="container">
        <h2>Add New Task</h2>
        <form action="add.jsp" method="post">
            <input type="text" name="task_name" placeholder="Task Name" required />
            <textarea name="task_description" placeholder="Task Description"></textarea>
            <input type="date" name="due_date" required />
            <button type="submit" name="add_task">Add Task</button>
        </form>

        <a href="index.jsp" class="btn">Back to To-Do List</a>
    </div>

    <%
        if (request.getParameter("add_task") != null) {
            String taskName = request.getParameter("task_name");
            String taskDescription = request.getParameter("task_description");
            String dueDate = request.getParameter("due_date");

            String insertTask = "INSERT INTO tasks (task_name, task_description, due_date) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(insertTask);
            ps.setString(1, taskName);
            ps.setString(2, taskDescription);
            ps.setString(3, dueDate);
            ps.executeUpdate();

            response.sendRedirect("index.jsp");
        }
    %>
</body>
</html>

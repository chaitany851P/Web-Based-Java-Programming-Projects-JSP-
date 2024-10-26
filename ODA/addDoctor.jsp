<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
<head>
    <title>Add Doctor</title>
    
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Add Doctor</h2>
    
    <form method="post" action="addDoctor.jsp">
        Doctor Name: <input type="text" name="doctorname" required><br>
        Age: <input type="number" name="age" required><br>
        Degree: <input type="text" name="degree" required><br>
        Image URL: <input type="text" name="img"><br>
        <input type="submit" value="Add Doctor">
    </form>
    
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String doctorname = request.getParameter("doctorname");
            String ageStr = request.getParameter("age");
            String degree = request.getParameter("degree");
            String img = request.getParameter("img");
            
            // Check if age is provided and not null/empty
            int age = 0;
            if (ageStr != null && !ageStr.trim().isEmpty()) {
                try {
                    age = Integer.parseInt(ageStr);
                } catch (NumberFormatException e) {
                    out.println("<p style='color:red;'>Invalid age format. Please enter a valid number.</p>");
                }
            }

            if (doctorname != null && degree != null && !doctorname.isEmpty() && !degree.isEmpty() && age > 0) {
                // Database connection and insertion code here
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/doctorappointment", "root", "");
                    PreparedStatement pst = con.prepareStatement("INSERT INTO doctors(doctorname, age, degree, img) VALUES (?, ?, ?, ?)");
                    pst.setString(1, doctorname);
                    pst.setInt(2, age);
                    pst.setString(3, degree);
                    pst.setString(4, img);

                    int result = pst.executeUpdate();
                    if (result > 0) {
                        out.println("<p>Doctor added successfully!</p>");
                    } else {
                        out.println("<p>Error adding doctor.</p>");
                    }

                } catch (Exception e) {
                    out.println("Database connection error: " + e.getMessage());
                }
            } else {
                out.println("<p style='color:red;'>Please fill in all the required fields correctly.</p>");
            }
        }
    %>
</body>
</html>

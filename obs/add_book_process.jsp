<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book Added</title>
</head>
<body>
<%
    String title = "";
    String author = "";
    String price = "";
    String discount = "";
    String imageUrl = "";

    Connection con = null;
    PreparedStatement ps = null;

    // Check if the request is a file upload
    if (ServletFileUpload.isMultipartContent(request)) {
        try {
            // Create a factory for disk-based file items
            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            // Parse the request
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    switch (item.getFieldName()) {
                        case "title":
                            title = item.getString();
                            break;
                        case "author":
                            author = item.getString();
                            break;
                        case "price":
                            price = item.getString();
                            break;
                        case "discount":
                            discount = item.getString();
                            break;
                    }
                } else {
                    // Handle the file upload
                    String fileName = new File(item.getName()).getName();
                    String filePath = "uploads/" + fileName; // Store files in the 'uploads' directory
                    File uploadFile = new File(application.getRealPath("") + File.separator + filePath);
                    item.write(uploadFile); // Save the file
                    imageUrl = filePath; // Use the path for database
                }
            }

            // Database connection parameters
            String dbURL = "jdbc:mysql://localhost:3306/online_book_store"; // Update with your DB URL
            String dbUser = "root"; // Update with your DB username
            String dbPassword = ""; // Update with your DB password

            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // SQL Insert Query
            String sql = "INSERT INTO books (title, author, price, discount, image_url) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setDouble(3, Double.parseDouble(price));
            ps.setString(4, discount);
            ps.setString(5, imageUrl);

            int rowsInserted = ps.executeUpdate();
            if (rowsInserted > 0) {
%>
                <h1>Book Added Successfully!</h1>
                <p><a href="add_book.jsp">Add another book</a></p>
%>
            } else {
%>
                <h1>Error adding book!</h1>
                <p><a href="add_book.jsp">Try again</a></p>
%>
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h1>Error: " + e.getMessage() + "</h1>");
        } finally {
            if (ps != null) try { ps.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    } else {
%>
        <h1>Not a file upload request!</h1>
        <p><a href="add_book.jsp">Go back</a></p>
<%
    }
%>
</body>
</html>

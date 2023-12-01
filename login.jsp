<%@ page import="java.sql.*" %>

<%
// JDBC driver and database URL
String jdbcUrl = "jdbc:mysql://localhost:3306/cardb";
String dbUser = "root";
String dbPassword = "";

Connection conn = null;
PreparedStatement stmt = null;

try {
    // Establish the database connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

    // Retrieve form data
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    // Insert data into the database
    String sql = "INSERT INTO login (username, password) VALUES (?, ?)";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, username);
    stmt.setString(2, password);
    int rowsAffected = stmt.executeUpdate();

    if (rowsAffected > 0) {
        out.println("Registration successful!");
    } else {
        out.println("Registration failed. Please try again.");
    }
} catch (Exception e) {
    e.printStackTrace();
    out.println("An error occurred: " + e.getMessage());
} finally {
    try {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    } catch (SQLException se) {
        se.printStackTrace();
    }
}
%>

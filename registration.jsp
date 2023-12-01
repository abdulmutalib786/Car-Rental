<%@ page import="java.sql.*,java.security.*,java.util.*" %>
<%@ page import="javax.xml.bind.DatatypeConverter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
String jdbcUrl = "jdbc:mysql://localhost:3306/cardb"; // Update with your database URL
String dbUser = "root"; // Update with your MySQL username
String dbPassword = ""; // Update with your MySQL password

Connection conn = null;
PreparedStatement stmt = null;

try {
    // Establish the database connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

    // Retrieve form data
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String gender = request.getParameter("g1");
    String password = request.getParameter("password");

    // Hash the password (use a stronger hashing algorithm in production)
    MessageDigest md = MessageDigest.getInstance("SHA-256");
    md.update(password.getBytes("UTF-8"));
    byte[] hashedPassword = md.digest();
    String hashedPasswordHex = DatatypeConverter.printHexBinary(hashedPassword);

    // Insert data into the database
    String sql = "INSERT INTO registration (username, email, phone, gender, password) VALUES (?, ?, ?, ?, ?)";

    stmt = conn.prepareStatement(sql);
    stmt.setString(1, username);
    stmt.setString(2, email);
    stmt.setString(3, phone);
    stmt.setString(4, gender);
    stmt.setString(5, hashedPasswordHex);

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

package com.pixelportal.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
	private static final String URL = "jdbc:mysql://127.0.0.1:3306/pixelportal_db?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=utf8";

	private static final String USER = "root";
	private static final String PASSWORD = "angel";

	public static Connection getConnection() throws SQLException {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			throw new SQLException("MySQL JDBC driver not found.", e);
		}
		return DriverManager.getConnection(URL, USER, PASSWORD);
	}

	public static void main(String[] args) {
		try (Connection connection = DatabaseConnection.getConnection()) {
			System.out.println("Connection successful!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}

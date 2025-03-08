package com.pixelportal.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.pixelportal.database.DatabaseConnection;

@WebServlet("/FriendRequestServlet")
public class FriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int userId = Integer.parseInt(request.getParameter("userId"));
		int friendId = Integer.parseInt(request.getParameter("friendId"));

		try (Connection conn = DatabaseConnection.getConnection()) {
			String checkSql = "SELECT COUNT(*) FROM friends WHERE user_id = ? AND friend_id = ?";
			try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
				checkStmt.setInt(1, userId);
				checkStmt.setInt(2, friendId);
				try (ResultSet rs = checkStmt.executeQuery()) {
					if (rs.next() && rs.getInt(1) > 0) {
						response.sendRedirect("ProfileServlet?userId=" + userId + "&error=duplicate_request");
						return;
					}
				}
			}

			String sql = "INSERT INTO friends (user_id, friend_id, status) VALUES (?, ?, 'requested')";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, userId);
				stmt.setInt(2, friendId);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		response.sendRedirect("ProfileServlet?userId=" + userId);
	}
}

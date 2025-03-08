package com.pixelportal.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.pixelportal.database.DatabaseConnection;
import com.pixelportal.model.User;

@WebServlet("/RejectFriendRequestServlet")
public class RejectFriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		User sessionUser = (User) session.getAttribute("user");
		int userId = sessionUser.getUserId();
		int friendId = Integer.parseInt(request.getParameter("friendId"));

		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "DELETE FROM friends WHERE user_id = ? AND friend_id = ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, friendId);
				stmt.setInt(2, userId);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		response.sendRedirect("ProfileServlet?userId=" + userId);
	}
}

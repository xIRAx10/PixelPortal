package com.pixelportal.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.pixelportal.database.DatabaseConnection;
import com.pixelportal.model.User; // Asegúrate de importar la clase User

@WebServlet("/FriendListServlet")
public class FriendListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		User sessionUser = (User) session.getAttribute("user");
		int userId = sessionUser.getUserId();

		ArrayList<User> friends = new ArrayList<>();
		ArrayList<User> pendingRequests = new ArrayList<>();

		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "SELECT * FROM users WHERE user_id IN (SELECT friend_id FROM friends WHERE user_id = ? AND status = 'accepted')";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, userId);
				try (ResultSet rs = stmt.executeQuery()) {
					while (rs.next()) {
						User user = new User();
						user.setUserId(rs.getInt("user_id"));
						user.setUsername(rs.getString("username"));
						user.setAvatarUrl(rs.getString("avatar_url"));
						friends.add(user);
					}
				}
			}

			sql = "SELECT * FROM users WHERE user_id IN (SELECT user_id FROM friends WHERE friend_id = ? AND status = 'requested')";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, userId);
				try (ResultSet rs = stmt.executeQuery()) {
					while (rs.next()) {
						User user = new User();
						user.setUserId(rs.getInt("user_id"));
						user.setUsername(rs.getString("username"));
						user.setAvatarUrl(rs.getString("avatar_url"));
						pendingRequests.add(user);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.setAttribute("friends", friends);
		request.setAttribute("pendingRequests", pendingRequests);
		request.getRequestDispatcher("friends.jsp").forward(request, response);
	}
}

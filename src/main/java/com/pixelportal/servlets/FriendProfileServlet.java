package com.pixelportal.servlets;

import com.pixelportal.dao.UserDAO;
import com.pixelportal.dao.CommentDAO;
import com.pixelportal.model.User;
import com.pixelportal.model.Comment;
import com.pixelportal.model.Game;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FriendProfileServlet")
public class FriendProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserDAO userDAO = new UserDAO();
	private CommentDAO commentDAO = new CommentDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userIdParam = req.getParameter("userId");
		User sessionUser = (User) req.getSession().getAttribute("user");
		User profileUser = null;
		int userId = 0;

		if (userIdParam != null && !userIdParam.isEmpty()) {
			try {
				userId = Integer.parseInt(userIdParam);
				profileUser = userDAO.getUserById(userId);
			} catch (NumberFormatException e) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid userId parameter");
				return;
			}
		}

		if (profileUser == null) {
			resp.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
			return;
		}

		List<Comment> userComments = commentDAO.getCommentsByUserId(userId);
		List<Game> userGames = userDAO.getUserGames(userId);
		List<User> userFriends = userDAO.getUserFriends(userId);

		req.setAttribute("profileUser", profileUser);
		req.setAttribute("userComments", userComments);
		req.setAttribute("userGames", userGames);
		req.setAttribute("userFriends", userFriends);

		req.getRequestDispatcher("FriendProfile.jsp").forward(req, resp);
	}
}

package com.pixelportal.servlets;

import com.pixelportal.dao.UserDAO;
import com.pixelportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteAvatarServlet")
public class DeleteAvatarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User sessionUser = (User) request.getSession().getAttribute("user");

		if (sessionUser == null) {
			response.setStatus(HttpServletResponse.SC_FORBIDDEN);
			return;
		}

		String defaultAvatarUrl = "assets/avatars/default-avatar.png";
		sessionUser.setAvatarUrl(defaultAvatarUrl);
		userDAO.updateUserAvatar(sessionUser.getUserId(), defaultAvatarUrl);

		request.getSession().setAttribute("user", sessionUser);

		response.setContentType("application/json");
		response.getWriter().write("{\"avatarUrl\": \"" + defaultAvatarUrl + "\"}");
	}
}

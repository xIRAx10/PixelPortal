package com.pixelportal.servlets;

import com.pixelportal.dao.UserDAO;
import com.pixelportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/SearchUsersServlet")
public class SearchUsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String searchQuery = request.getParameter("searchQuery");
		User sessionUser = (User) request.getSession().getAttribute("user");

		if (sessionUser == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		List<User> searchResults = null;
		if (searchQuery != null && !searchQuery.trim().isEmpty()) {
			searchResults = userDAO.searchUsersByUsername(searchQuery);
		}

		request.setAttribute("profileUser", sessionUser);
		request.setAttribute("searchResults", searchResults);

		request.getRequestDispatcher("Profile.jsp").forward(request, response);
	}
}

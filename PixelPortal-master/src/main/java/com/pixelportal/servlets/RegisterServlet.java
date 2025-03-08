package com.pixelportal.servlets;

import com.pixelportal.dao.UserDAO;
import com.pixelportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String confirmPassword = request.getParameter("confirmPassword");

		if (username == null || email == null || password == null || confirmPassword == null
				|| !password.equals(confirmPassword)) {
			response.sendRedirect("Signup.jsp?error=Invalid+input");
			return;
		}

		if (!isValidPassword(password)) {
			response.sendRedirect(
					"Signup.jsp?error=Password+must+be+at+least+8+characters+long+and+contain+at+least+one+special+character");
			return;
		}

		User newUser = new User();
		newUser.setUsername(username);
		newUser.setEmail(email);
		newUser.setPassword(password);
		newUser.setStatus("active");
		newUser.setBio("");
		newUser.setAvatarUrl("");

		UserDAO userDAO = new UserDAO();
		boolean isRegistered = userDAO.registerUser(newUser);

		if (isRegistered) {
			response.sendRedirect("Login.jsp?success=Registration+successful");
		} else {
			response.sendRedirect("Signup.jsp?error=Registration+failed");
		}
	}

	private boolean isValidPassword(String password) {
		if (password.length() < 8) {
			return false;
		}
		boolean hasSpecialChar = password.chars().anyMatch(ch -> !Character.isLetterOrDigit(ch));
		return hasSpecialChar;
	}
}

package com.pixelportal.servlets;

import com.pixelportal.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Base64;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO = new UserDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");

		if (email == null || email.isEmpty()) {
			req.setAttribute("error", "El correo electrónico es obligatorio.");
			req.getRequestDispatcher("ResetPassword.jsp").forward(req, resp);
			return;
		}

		String newPassword = generateNewPassword();

		boolean isUpdated = userDAO.updateUserPasswordByEmail(email, newPassword);

		if (isUpdated) {
			req.setAttribute("message", "La nueva contraseña ha sido enviada a su correo electrónico.");
		} else {
			req.setAttribute("error", "No se encontró ninguna cuenta con ese correo electrónico.");
		}

		req.getRequestDispatcher("ResetPassword.jsp").forward(req, resp);
	}

	private String generateNewPassword() {
		SecureRandom random = new SecureRandom();
		byte[] bytes = new byte[24];
		random.nextBytes(bytes);
		return Base64.getEncoder().encodeToString(bytes).substring(0, 8);
	}
}

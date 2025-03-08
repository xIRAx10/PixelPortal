package com.pixelportal.servlets;

import com.pixelportal.dao.UserDAO;
import com.pixelportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;

@WebServlet("/UploadAvatarServlet")
@MultipartConfig
public class UploadAvatarServlet extends HttpServlet {
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

		Part filePart = request.getPart("avatar");
		if (filePart != null && filePart.getSize() > 0) {
			String fileName = getFileName(filePart);
			String uploadPath = getServletContext().getRealPath("") + File.separator + "assets" + File.separator
					+ "avatars";
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdirs();
			}
			String filePath = uploadPath + File.separator + fileName;
			filePart.write(filePath);

			String avatarUrl = "assets/avatars/" + fileName;
			sessionUser.setAvatarUrl(avatarUrl);
			userDAO.updateUserAvatar(sessionUser.getUserId(), avatarUrl);

			request.getSession().setAttribute("user", sessionUser);

			response.setContentType("application/json");
			response.getWriter().write("{\"avatarUrl\": \"" + avatarUrl + "\"}");
		} else {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		}
	}

	private String getFileName(Part part) {
		for (String content : part.getHeader("content-disposition").split(";")) {
			if (content.trim().startsWith("filename")) {
				return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
			}
		}
		return null;
	}
}

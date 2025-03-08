package com.pixelportal.servlets;

import com.pixelportal.dao.CommentDAO;
import com.pixelportal.model.Comment;
import com.pixelportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddCommentServlet")
public class AddCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CommentDAO commentDAO = new CommentDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		User sessionUser = (User) req.getSession().getAttribute("user");

		if (sessionUser == null) {
			resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
			return;
		}

		String commentText = req.getParameter("comment");
		int profileUserId = Integer.parseInt(req.getParameter("profileUserId"));

		Comment comment = new Comment();
		comment.setProfileUserId(profileUserId);
		comment.setAuthorUserId(sessionUser.getUserId());
		comment.setCommentText(commentText);

		commentDAO.addComment(comment);

		resp.sendRedirect("ProfileServlet?userId=" + profileUserId);
	}
}

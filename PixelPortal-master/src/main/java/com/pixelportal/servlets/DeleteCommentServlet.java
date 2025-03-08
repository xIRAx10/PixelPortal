package com.pixelportal.servlets;

import com.pixelportal.dao.CommentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/DeleteCommentServlet")
public class DeleteCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private CommentDAO commentDAO = new CommentDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String commentIdParam = req.getParameter("commentId");
		if (commentIdParam == null || commentIdParam.isEmpty()) {
			resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing commentId parameter");
			return;
		}

		int commentId = Integer.parseInt(commentIdParam);
		boolean deleted = commentDAO.deleteComment(commentId);

		if (deleted) {
			resp.sendRedirect(req.getHeader("Referer"));
		} else {
			resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete comment");
		}
	}
}

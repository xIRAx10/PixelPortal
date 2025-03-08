package com.pixelportal.servlets;

import com.pixelportal.dao.ReviewDAO;
import com.pixelportal.model.Review;
import com.pixelportal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddReviewServlet")
public class AddReviewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReviewDAO reviewDAO = new ReviewDAO();

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");

		User sessionUser = (User) req.getSession().getAttribute("user");
		if (sessionUser == null) {
			resp.sendRedirect("Login.jsp");
			return;
		}

		int userId = sessionUser.getUserId();
		int gameId = Integer.parseInt(req.getParameter("gameId"));
		int rating = Integer.parseInt(req.getParameter("rating-" + gameId));
		String reviewText = req.getParameter("reviewText");

		Review review = new Review();
		review.setUserId(userId);
		review.setGameId(gameId);
		review.setRating(rating);
		review.setReviewText(reviewText);

		reviewDAO.addReview(review);

		resp.sendRedirect("Library.jsp");
	}
}

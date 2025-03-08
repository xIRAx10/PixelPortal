package com.pixelportal.servlets;

import com.pixelportal.database.DatabaseConnection;
import com.pixelportal.model.Game;
import com.pixelportal.model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String searchQuery = request.getParameter("buscar");

		if (searchQuery != null && !searchQuery.trim().isEmpty()) {
			try (Connection connection = DatabaseConnection.getConnection()) {
				String sql = "SELECT g.*, d.name as developer_name, p.name as publisher_name FROM games g "
						+ "LEFT JOIN developers d ON g.developer_id = d.developer_id "
						+ "LEFT JOIN publishers p ON g.publisher_id = p.publisher_id "
						+ "WHERE LOWER(g.title) LIKE ? OR LOWER(d.name) = LOWER(?) OR LOWER(p.name) = LOWER(?)";
				try (PreparedStatement statement = connection.prepareStatement(sql)) {
					String lowerSearchQuery = "%" + searchQuery.toLowerCase() + "%";
					statement.setString(1, lowerSearchQuery);
					statement.setString(2, searchQuery.toLowerCase());
					statement.setString(3, searchQuery.toLowerCase());

					try (ResultSet resultSet = statement.executeQuery()) {
						List<Game> games = new ArrayList<>();
						while (resultSet.next()) {
							Game game = new Game();
							game.setGameId(resultSet.getInt("game_id"));
							game.setTitle(resultSet.getString("title"));
							game.setCoverImageUrl(resultSet.getString("cover_image_url"));
							game.setDescription(resultSet.getString("description"));
							game.setPrice(resultSet.getBigDecimal("price").doubleValue());
							game.setReleaseDate(resultSet.getTimestamp("release_date"));
							game.setDeveloperName(resultSet.getString("developer_name"));
							game.setPublisherName(resultSet.getString("publisher_name"));
							game.setGameGenre(resultSet.getString("game_genre"));

							// Load reviews
							List<Review> reviews = new ArrayList<>();
							String reviewSql = "SELECT * FROM reviews WHERE game_id = ?";
							try (PreparedStatement reviewStatement = connection.prepareStatement(reviewSql)) {
								reviewStatement.setInt(1, game.getGameId());
								try (ResultSet reviewResultSet = reviewStatement.executeQuery()) {
									while (reviewResultSet.next()) {
										Review review = new Review();
										review.setReviewId(reviewResultSet.getInt("review_id"));
										review.setUserId(reviewResultSet.getInt("user_id"));
										review.setGameId(reviewResultSet.getInt("game_id"));
										review.setRating(reviewResultSet.getInt("rating"));
										review.setReviewText(reviewResultSet.getString("review_text"));
										review.setReviewDate(reviewResultSet.getTimestamp("review_date"));
										reviews.add(review);
									}
								}
							} catch (Exception e) {
								e.printStackTrace();
							}
							game.setReviews(reviews);
							games.add(game);
						}

						request.setAttribute("games", games);
						request.getRequestDispatcher("GameView.jsp").forward(request, response);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new ServletException("Error al realizar la búsqueda: " + e.getMessage(), e);
			}
		} else {
			response.sendRedirect("Index.jsp?error=empty");
		}
	}
}

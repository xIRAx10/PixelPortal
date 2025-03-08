package com.pixelportal.dao;

import com.pixelportal.model.Review;
import com.pixelportal.database.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {
	public void addReview(Review review) {
		String sql = "INSERT INTO reviews (user_id, game_id, rating, review_text, review_date, username) VALUES (?, ?, ?, ?, NOW(), ?)";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, review.getUserId());
			stmt.setInt(2, review.getGameId());
			stmt.setInt(3, review.getRating());
			stmt.setString(4, review.getReviewText());
			stmt.setString(5, review.getUsername());

			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Review> getReviewsByGameId(int gameId) {
		List<Review> reviews = new ArrayList<>();
		String sql = "SELECT * FROM reviews WHERE game_id = ?";

		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, gameId);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				Review review = new Review();
				review.setReviewId(rs.getInt("review_id"));
				review.setUserId(rs.getInt("user_id"));
				review.setGameId(rs.getInt("game_id"));
				review.setRating(rs.getInt("rating"));
				review.setReviewText(rs.getString("review_text"));
				review.setReviewDate(rs.getTimestamp("review_date"));
				review.setUsername(rs.getString("username"));
				reviews.add(review);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return reviews;
	}
}

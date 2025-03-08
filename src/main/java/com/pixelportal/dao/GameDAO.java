package com.pixelportal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.pixelportal.database.DatabaseConnection;
import com.pixelportal.model.Game;
import com.pixelportal.model.Review;

public class GameDAO {

	public Game getGameById(int gameId) {
		String query = "SELECT g.*, d.name AS developer_name, p.name AS publisher_name " + "FROM games g "
				+ "LEFT JOIN developers d ON g.developer_id = d.developer_id "
				+ "LEFT JOIN publishers p ON g.publisher_id = p.publisher_id " + "WHERE g.game_id = ?";
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, gameId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				Game game = new Game();
				game.setGameId(rs.getInt("game_id"));
				game.setTitle(rs.getString("title"));
				game.setCoverImageUrl(rs.getString("cover_image_url"));
				game.setDescription(rs.getString("description"));
				game.setPrice(rs.getBigDecimal("price").doubleValue());
				game.setReleaseDate(rs.getTimestamp("release_date"));
				game.setDeveloperName(rs.getString("developer_name"));
				game.setPublisherName(rs.getString("publisher_name"));
				game.setGameGenre(rs.getString("game_genre"));

				List<Review> reviews = new ArrayList<>();
				String reviewSql = "SELECT * FROM reviews WHERE game_id = ?";
				try (PreparedStatement reviewStmt = conn.prepareStatement(reviewSql)) {
					reviewStmt.setInt(1, game.getGameId());
					ResultSet reviewRs = reviewStmt.executeQuery();
					while (reviewRs.next()) {
						Review review = new Review();
						review.setReviewId(reviewRs.getInt("review_id"));
						review.setUserId(reviewRs.getInt("user_id"));
						review.setGameId(reviewRs.getInt("game_id"));
						review.setRating(reviewRs.getInt("rating"));
						review.setReviewText(reviewRs.getString("review_text"));
						review.setReviewDate(reviewRs.getTimestamp("review_date"));
						reviews.add(review);
					}
				}
				game.setReviews(reviews);

				return game;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<Game> getAllGames() {
		String query = "SELECT game_id, title, cover_image_url, description, price, release_date, developer_id, publisher_id, game_genre FROM games";
		List<Game> games = new ArrayList<>();
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Game game = new Game();
				game.setGameId(rs.getInt("game_id"));
				game.setTitle(rs.getString("title"));
				game.setCoverImageUrl(rs.getString("cover_image_url"));
				game.setDescription(rs.getString("description"));
				game.setPrice(rs.getBigDecimal("price").doubleValue());
				game.setReleaseDate(rs.getTimestamp("release_date"));
				game.setDeveloperId(rs.getInt("developer_id"));
				game.setPublisherId(rs.getInt("publisher_id"));
				game.setGameGenre(rs.getString("game_genre"));
				games.add(game);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return games;
	}

	public List<Game> searchGames(String searchQuery) {
		String query = "SELECT g.*, d.name AS developer_name, p.name AS publisher_name " + "FROM games g "
				+ "LEFT JOIN developers d ON g.developer_id = d.developer_id "
				+ "LEFT JOIN publishers p ON g.publisher_id = p.publisher_id "
				+ "WHERE LOWER(g.title) LIKE ? OR LOWER(d.name) = LOWER(?) OR LOWER(p.name) = LOWER(?)";
		List<Game> games = new ArrayList<>();
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			String lowerSearchQuery = "%" + searchQuery.toLowerCase() + "%";
			stmt.setString(1, lowerSearchQuery);
			stmt.setString(2, searchQuery.toLowerCase());
			stmt.setString(3, searchQuery.toLowerCase());
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Game game = new Game();
				game.setGameId(rs.getInt("game_id"));
				game.setTitle(rs.getString("title"));
				game.setCoverImageUrl(rs.getString("cover_image_url"));
				game.setDescription(rs.getString("description"));
				game.setPrice(rs.getBigDecimal("price").doubleValue());
				game.setDeveloperName(rs.getString("developer_name"));
				game.setPublisherName(rs.getString("publisher_name"));
				game.setGameGenre(rs.getString("game_genre"));
				games.add(game);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return games;
	}
}

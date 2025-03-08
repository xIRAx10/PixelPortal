package com.pixelportal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.pixelportal.database.DatabaseConnection;
import com.pixelportal.model.Game;

public class CartDAO {

	public List<Game> getCartItems(int userId) throws SQLException {
		String sql = "SELECT g.game_id, g.title, g.cover_image_url, g.description, g.price " + "FROM cart_items ci "
				+ "JOIN games g ON ci.game_id = g.game_id "
				+ "WHERE ci.cart_id = (SELECT cart_id FROM carts WHERE user_id = ?)";
		List<Game> cartItems = new ArrayList<>();
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			try (ResultSet rs = stmt.executeQuery()) {
				while (rs.next()) {
					Game game = new Game();
					game.setGameId(rs.getInt("game_id"));
					game.setTitle(rs.getString("title"));
					game.setCoverImageUrl(rs.getString("cover_image_url"));
					game.setDescription(rs.getString("description"));
					game.setPrice(rs.getBigDecimal("price").doubleValue()); // Convertir BigDecimal a double
					cartItems.add(game);
				}
			}
		}
		return cartItems;
	}

	public void removeCartItem(int userId, int gameId, Connection conn) throws SQLException {
		String sql = "DELETE FROM cart_items WHERE cart_id = (SELECT cart_id FROM carts WHERE user_id = ?) AND game_id = ?";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.setInt(2, gameId);
			stmt.executeUpdate();
		}
	}

	public void clearCart(int userId, Connection conn) throws SQLException {
		String sql = "DELETE FROM cart_items WHERE cart_id = (SELECT cart_id FROM carts WHERE user_id = ?)";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.executeUpdate();
		}
	}

	public void addCartItem(int userId, int gameId, Connection conn) throws SQLException {
		String getCartIdSql = "SELECT cart_id FROM carts WHERE user_id = ?";
		int cartId;
		try (PreparedStatement getCartIdStmt = conn.prepareStatement(getCartIdSql)) {
			getCartIdStmt.setInt(1, userId);
			try (ResultSet rs = getCartIdStmt.executeQuery()) {
				if (rs.next()) {
					cartId = rs.getInt("cart_id");
				} else {
					String createCartSql = "INSERT INTO carts (user_id) VALUES (?)";
					try (PreparedStatement createCartStmt = conn.prepareStatement(createCartSql,
							PreparedStatement.RETURN_GENERATED_KEYS)) {
						createCartStmt.setInt(1, userId);
						createCartStmt.executeUpdate();
						try (ResultSet generatedKeys = createCartStmt.getGeneratedKeys()) {
							if (generatedKeys.next()) {
								cartId = generatedKeys.getInt(1);
							} else {
								throw new SQLException("Creating cart failed, no ID obtained.");
							}
						}
					}
				}
			}
		}

		String sql = "INSERT INTO cart_items (cart_id, game_id) VALUES (?, ?)";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, cartId);
			stmt.setInt(2, gameId);
			stmt.executeUpdate();
		}
	}
}

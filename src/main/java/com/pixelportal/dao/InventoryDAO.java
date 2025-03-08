package com.pixelportal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.sql.Timestamp;

public class InventoryDAO {
	public void addGameToUserInventory(int userId, int gameId, LocalDateTime purchaseDate, String licenseType,
			Connection conn) throws SQLException {
		String sql = "INSERT INTO inventory_users (user_id, game_id, purchase_date, license_type) VALUES (?, ?, ?, ?)";
		try (PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, userId);
			stmt.setInt(2, gameId);
			stmt.setTimestamp(3, Timestamp.valueOf(purchaseDate));
			stmt.setString(4, licenseType);
			int rowsAffected = stmt.executeUpdate();
			if (rowsAffected == 0) {
				throw new SQLException("No rows affected while adding game to inventory.");
			}
		}
	}
}

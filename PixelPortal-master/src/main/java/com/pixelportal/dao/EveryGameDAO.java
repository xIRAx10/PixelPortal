package com.pixelportal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.pixelportal.database.DatabaseConnection;
import com.pixelportal.model.Game;

public class EveryGameDAO {

	public List<Game> getAllGames() {
		String query = "SELECT * FROM games";
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
				game.setPrice(rs.getDouble("price"));
				games.add(game);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return games;
	}
}

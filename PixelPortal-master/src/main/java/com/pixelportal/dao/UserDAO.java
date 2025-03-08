package com.pixelportal.dao;

import com.pixelportal.model.Game;
import com.pixelportal.model.User;
import com.pixelportal.database.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	public User getUserById(int userId) {
		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "SELECT * FROM users WHERE user_id = ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, userId);
				try (ResultSet rs = stmt.executeQuery()) {
					if (rs.next()) {
						User user = new User();
						user.setUserId(rs.getInt("user_id"));
						user.setUsername(rs.getString("username"));
						user.setEmail(rs.getString("email"));
						user.setAvatarUrl(rs.getString("avatar_url"));
						user.setStatus(rs.getString("status"));
						user.setBio(rs.getString("bio"));
						return user;
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<User> getUserFriends(int userId) {
		List<User> friends = new ArrayList<>();
		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "SELECT * FROM users WHERE user_id IN (SELECT friend_id FROM friends WHERE user_id = ? AND status = 'accepted')";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, userId);
				try (ResultSet rs = stmt.executeQuery()) {
					while (rs.next()) {
						User user = new User();
						user.setUserId(rs.getInt("user_id"));
						user.setUsername(rs.getString("username"));
						user.setAvatarUrl(rs.getString("avatar_url"));
						friends.add(user);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return friends;
	}

	public List<User> getPendingFriendRequests(int userId) {
		List<User> pendingRequests = new ArrayList<>();
		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "SELECT * FROM users WHERE user_id IN (SELECT user_id FROM friends WHERE friend_id = ? AND status = 'requested')";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, userId);
				try (ResultSet rs = stmt.executeQuery()) {
					while (rs.next()) {
						User user = new User();
						user.setUserId(rs.getInt("user_id"));
						user.setUsername(rs.getString("username"));
						user.setAvatarUrl(rs.getString("avatar_url"));
						pendingRequests.add(user);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pendingRequests;
	}

	public boolean areFriends(int userId1, int userId2) {
		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "SELECT * FROM friends WHERE (user_id = ? AND friend_id = ? AND status = 'accepted') OR (user_id = ? AND friend_id = ? AND status = 'accepted')";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, userId1);
				stmt.setInt(2, userId2);
				stmt.setInt(3, userId2);
				stmt.setInt(4, userId1);
				try (ResultSet rs = stmt.executeQuery()) {
					return rs.next();
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public void updateUserBio(int userId, String bio) {
		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "UPDATE users SET bio = ? WHERE user_id = ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setString(1, bio);
				stmt.setInt(2, userId);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<User> searchUsersByUsername(String username) {
		List<User> users = new ArrayList<>();
		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "SELECT * FROM users WHERE username LIKE ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setString(1, "%" + username + "%");
				try (ResultSet rs = stmt.executeQuery()) {
					while (rs.next()) {
						User user = new User();
						user.setUserId(rs.getInt("user_id"));
						user.setUsername(rs.getString("username"));
						user.setAvatarUrl(rs.getString("avatar_url"));
						users.add(user);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return users;
	}

	public List<Game> getUserGames(int userId) {
		List<Game> games = new ArrayList<>();
		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "SELECT g.* FROM games g JOIN inventory_users iu ON g.game_id = iu.game_id WHERE iu.user_id = ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setInt(1, userId);
				try (ResultSet rs = stmt.executeQuery()) {
					while (rs.next()) {
						Game game = new Game();
						game.setGameId(rs.getInt("game_id"));
						game.setTitle(rs.getString("title"));
						game.setCoverImageUrl(rs.getString("cover_image_url"));
						game.setDescription(rs.getString("description"));
						game.setPrice(rs.getDouble("price"));
						game.setReleaseDate(rs.getTimestamp("release_date"));
						game.setDeveloperId(rs.getInt("developer_id"));
						game.setPublisherId(rs.getInt("publisher_id"));
						game.setGameGenre(rs.getString("game_genre"));
						games.add(game);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return games;
	}

	public void updateUserAvatar(int userId, String avatarUrl) {
		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "UPDATE users SET avatar_url = ? WHERE user_id = ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setString(1, avatarUrl);
				stmt.setInt(2, userId);
				stmt.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public boolean registerUser(User user) {
		String sql = "INSERT INTO users (username, email, password, status, bio, avatar_url) VALUES (?, ?, ?, ?, ?, ?)";
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, user.getUsername());
			stmt.setString(2, user.getEmail());
			stmt.setString(3, user.getPassword());
			stmt.setString(4, user.getStatus());
			stmt.setString(5, user.getBio());
			stmt.setString(6, user.getAvatarUrl());
			int rowsInserted = stmt.executeUpdate();
			return rowsInserted > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public boolean updateUserPasswordByEmail(String email, String newPassword) {
		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "UPDATE users SET password = ? WHERE email = ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setString(1, newPassword);
				stmt.setString(2, email);
				int rowsUpdated = stmt.executeUpdate();
				return rowsUpdated > 0;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	public User validateUser(String username, String password) {
		try (Connection conn = DatabaseConnection.getConnection()) {
			String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
			try (PreparedStatement stmt = conn.prepareStatement(sql)) {
				stmt.setString(1, username);
				stmt.setString(2, password);
				try (ResultSet rs = stmt.executeQuery()) {
					if (rs.next()) {
						User user = new User();
						user.setUserId(rs.getInt("user_id"));
						user.setUsername(rs.getString("username"));
						user.setEmail(rs.getString("email"));
						user.setAvatarUrl(rs.getString("avatar_url"));
						user.setStatus(rs.getString("status"));
						user.setBio(rs.getString("bio"));
						return user;
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}

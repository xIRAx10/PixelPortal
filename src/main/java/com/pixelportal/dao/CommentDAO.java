package com.pixelportal.dao;

import com.pixelportal.model.Comment;
import com.pixelportal.database.DatabaseConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

	public void addComment(Comment comment) {
		String query = "INSERT INTO profile_comments (profile_user_id, author_user_id, comment_text, created_at) VALUES (?, ?, ?, NOW())";
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, comment.getProfileUserId());
			stmt.setInt(2, comment.getAuthorUserId());
			stmt.setString(3, comment.getCommentText());
			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<Comment> getCommentsByUserId(int userId) {
		List<Comment> comments = new ArrayList<>();
		String query = "SELECT c.*, u.username AS author_username, u.avatar_url AS author_avatar_url "
				+ "FROM profile_comments c " + "JOIN users u ON c.author_user_id = u.user_id "
				+ "WHERE c.profile_user_id = ? " + "ORDER BY c.created_at DESC";
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, userId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Comment comment = new Comment();
				comment.setCommentId(rs.getInt("comment_id"));
				comment.setProfileUserId(rs.getInt("profile_user_id"));
				comment.setAuthorUserId(rs.getInt("author_user_id"));
				comment.setCommentText(rs.getString("comment_text"));
				comment.setCreatedAt(rs.getTimestamp("created_at"));
				comment.setAuthorUsername(rs.getString("author_username"));
				comment.setAuthorAvatarUrl(rs.getString("author_avatar_url"));
				comments.add(comment);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return comments;
	}

	public boolean deleteComment(int commentId) {
		String query = "DELETE FROM profile_comments WHERE comment_id = ?";
		try (Connection conn = DatabaseConnection.getConnection();
				PreparedStatement stmt = conn.prepareStatement(query)) {
			stmt.setInt(1, commentId);
			int rowsAffected = stmt.executeUpdate();
			return rowsAffected > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
}

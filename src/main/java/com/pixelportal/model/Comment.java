package com.pixelportal.model;

import java.sql.Timestamp;

public class Comment {
	private int commentId;
	private int profileUserId;
	private int authorUserId;
	private String commentText;
	private Timestamp createdAt;
	private String authorUsername;
	private String authorAvatarUrl;

	public int getCommentId() {
		return commentId;
	}

	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}

	public int getProfileUserId() {
		return profileUserId;
	}

	public void setProfileUserId(int profileUserId) {
		this.profileUserId = profileUserId;
	}

	public int getAuthorUserId() {
		return authorUserId;
	}

	public void setAuthorUserId(int authorUserId) {
		this.authorUserId = authorUserId;
	}

	public String getCommentText() {
		return commentText;
	}

	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getAuthorUsername() {
		return authorUsername;
	}

	public void setAuthorUsername(String authorUsername) {
		this.authorUsername = authorUsername;
	}

	public String getAuthorAvatarUrl() {
		return authorAvatarUrl;
	}

	public void setAuthorAvatarUrl(String authorAvatarUrl) {
		this.authorAvatarUrl = authorAvatarUrl;
	}
}

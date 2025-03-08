package com.pixelportal.model;

public class User {
	private int userId;
	private String username;
	private String email;
	private String password;
	private String avatarUrl;
	private String status;
	private String bio;
	private String privacySettings;

	public User() {
	}

	public User(int userId, String username, String avatarUrl) {
		this.userId = userId;
		this.username = username;
		this.avatarUrl = avatarUrl;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getAvatarUrl() {
		return avatarUrl;
	}

	public void setAvatarUrl(String avatarUrl) {
		this.avatarUrl = avatarUrl;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public String getPrivacySettings() {
		return privacySettings;
	}

	public void setPrivacySettings(String privacySettings) {
		this.privacySettings = privacySettings;
	}
}

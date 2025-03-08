package com.pixelportal.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pixelportal.dao.InventoryDAO;
import com.pixelportal.model.User;
import com.pixelportal.database.DatabaseConnection;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/AddGameToLibraryServlet")
public class AddGameToLibraryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(AddGameToLibraryServlet.class.getName());

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		if (user == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		int userId = user.getUserId();
		int gameId = Integer.parseInt(request.getParameter("gameId"));
		InventoryDAO inventoryDAO = new InventoryDAO();
		Connection conn = null;

		try {
			conn = DatabaseConnection.getConnection();
			conn.setAutoCommit(false);
			LOGGER.log(Level.INFO, "Database connection established.");

			inventoryDAO.addGameToUserInventory(userId, gameId, LocalDateTime.now(), "Standard", conn);
			conn.commit();
			LOGGER.log(Level.INFO, "Game added to inventory and transaction committed.");

			response.sendRedirect("Library.jsp");
		} catch (SQLException e) {
			LOGGER.log(Level.SEVERE, "Error adding game to library", e);
			if (conn != null) {
				try {
					conn.rollback();
					LOGGER.log(Level.INFO, "Transaction rolled back.");
				} catch (SQLException rollbackEx) {
					LOGGER.log(Level.SEVERE, "Error rolling back transaction", rollbackEx);
				}
			}
			throw new ServletException("Error adding game to library", e);
		} finally {
			if (conn != null) {
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException ex) {
					LOGGER.log(Level.SEVERE, "Error closing connection", ex);
				}
			}
		}
	}
}

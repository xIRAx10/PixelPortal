package com.pixelportal.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pixelportal.dao.CartDAO;
import com.pixelportal.dao.InventoryDAO;
import com.pixelportal.model.Game;
import com.pixelportal.model.User;
import com.pixelportal.database.DatabaseConnection;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/ProcessPaymentServlet")
public class ProcessPaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger LOGGER = Logger.getLogger(ProcessPaymentServlet.class.getName());

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		if (user == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		int userId = user.getUserId();
		CartDAO cartDAO = new CartDAO();
		InventoryDAO inventoryDAO = new InventoryDAO();
		Connection conn = null;

		try {
			conn = DatabaseConnection.getConnection();
			conn.setAutoCommit(false);
			LOGGER.log(Level.INFO, "Database connection established.");

			List<Game> cartItems = (List<Game>) session.getAttribute("cart");
			if (cartItems == null || cartItems.isEmpty()) {
				response.sendRedirect("WelcomeView.jsp");
				return;
			}
			LOGGER.log(Level.INFO, "Retrieved {0} items from cart.", cartItems.size());

			for (Game game : cartItems) {
				inventoryDAO.addGameToUserInventory(userId, game.getGameId(), LocalDateTime.now(), "Standard", conn);
				LOGGER.log(Level.INFO, "Moved game {0} to inventory.", game.getTitle());
			}

			conn.commit();
			LOGGER.log(Level.INFO, "Transaction committed.");

			response.sendRedirect("RemoveFromCartServlet?redirect=WelcomeView.jsp");

		} catch (SQLException e) {
			LOGGER.log(Level.SEVERE, "Error processing payment", e);
			if (conn != null) {
				try {
					conn.rollback();
					LOGGER.log(Level.INFO, "Transaction rolled back.");
				} catch (SQLException rollbackEx) {
					LOGGER.log(Level.SEVERE, "Error rolling back transaction", rollbackEx);
				}
			}
			throw new ServletException("Error processing payment", e);
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

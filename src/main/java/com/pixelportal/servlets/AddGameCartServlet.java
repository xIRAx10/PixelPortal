package com.pixelportal.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.pixelportal.dao.CartDAO;
import com.pixelportal.dao.GameDAO;
import com.pixelportal.model.Game;
import com.pixelportal.model.User;
import com.pixelportal.database.DatabaseConnection;

@WebServlet("/AddToCartServlet")
public class AddGameCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String gameId = request.getParameter("gameId");

		if (gameId == null || gameId.isEmpty()) {
			System.out.println("ID del juego no especificado.");
			response.sendRedirect("GameView.jsp?error=Id+del+juego+no+especificado");
			return;
		}

		GameDAO gameDAO = new GameDAO();
		Game game = gameDAO.getGameById(Integer.parseInt(gameId));
		if (game == null) {
			System.out.println("Juego no encontrado con ID: " + gameId);
			response.sendRedirect("GameView.jsp?error=Juego+no+encontrado");
			return;
		}

		User user = (User) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect("Login.jsp");
			return;
		}

		List<Game> cart = (List<Game>) session.getAttribute("cart");
		if (cart == null) {
			cart = new ArrayList<>();
		}

		cart.add(game);
		session.setAttribute("cart", cart);

		System.out.println("Juego añadido al carrito: " + game.getTitle());
		System.out.println("Carrito actual tiene " + cart.size() + " juegos.");

		try (Connection conn = DatabaseConnection.getConnection()) {
			CartDAO cartDAO = new CartDAO();
			cartDAO.addCartItem(user.getUserId(), game.getGameId(), conn);
			System.out.println("Juego añadido al carrito en la base de datos: " + game.getTitle());
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendRedirect("GameView.jsp?error=Error+al+añadir+juego+al+carrito+en+la+base+de+datos");
			return;
		}

		response.sendRedirect("GameView.jsp?success=Juego+añadido+al+carrito.");
	}
}
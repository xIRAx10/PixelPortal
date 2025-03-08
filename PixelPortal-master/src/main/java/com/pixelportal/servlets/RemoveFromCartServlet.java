package com.pixelportal.servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.pixelportal.model.Game;

@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		String gameId = request.getParameter("gameId");

		List<Game> cart = (List<Game>) session.getAttribute("cart");
		if (cart != null) {
			if (gameId == null || gameId.isEmpty()) {
				cart.clear();
				System.out.println("Carrito limpiado.");
				response.sendRedirect("ShoppingCart.jsp?success=Carrito+limpiado.");
			} else {
				cart.removeIf(game -> game.getGameId() == Integer.parseInt(gameId));
				System.out.println("Juego eliminado del carrito: " + gameId);
				response.sendRedirect("ShoppingCart.jsp?success=Juego+eliminado+del+carrito.");
			}
			session.setAttribute("cart", cart);
		} else {
			response.sendRedirect("ShoppingCart.jsp?error=El+carrito+esta+vacio.");
		}
	}
}
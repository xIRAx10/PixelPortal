package com.pixelportal.servlets;

import com.pixelportal.dao.GameDAO;
import com.pixelportal.model.Game;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/FilterGamesServlet")
public class FilterGamesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String minPriceStr = request.getParameter("min-price");
		String maxPriceStr = request.getParameter("max-price");
		String category = request.getParameter("category");

		double minPrice = (minPriceStr != null && !minPriceStr.isEmpty()) ? Double.parseDouble(minPriceStr) : 0;
		double maxPrice = (maxPriceStr != null && !maxPriceStr.isEmpty()) ? Double.parseDouble(maxPriceStr) : 50;

		GameDAO gameDAO = new GameDAO();
		List<Game> allGames = gameDAO.getAllGames();

		System.out.println("Selected category: " + category);
		System.out.println("Total games before filtering: " + allGames.size());

		List<Game> filteredGames = allGames.stream()
				.filter(game -> game.getPrice() >= minPrice && game.getPrice() <= maxPrice)
				.filter(game -> category == null || category.isEmpty() || "all".equals(category)
						|| (game.getGameGenre() != null && game.getGameGenre().equalsIgnoreCase(category)))
				.collect(Collectors.toList());

		System.out.println("Total games after filtering: " + filteredGames.size());
		filteredGames.forEach(
				game -> System.out.println("Filtered Game: " + game.getTitle() + ", Genre: " + game.getGameGenre()));

		request.setAttribute("allGames", filteredGames);
		request.getRequestDispatcher("Index.jsp").forward(request, response);
	}
}

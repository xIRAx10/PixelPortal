package com.pixelportal.servlets;

import com.pixelportal.dao.GameDAO;
import com.pixelportal.model.Game;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/GameViewServlet")
public class GameViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String searchQuery = request.getParameter("buscar");
		String gameIdParam = request.getParameter("gameId");
		GameDAO gameDAO = new GameDAO();
		List<Game> games = new ArrayList<>();

		if (searchQuery != null && !searchQuery.trim().isEmpty()) {
			games = gameDAO.searchGames(searchQuery);
		} else if (gameIdParam != null && !gameIdParam.trim().isEmpty()) {
			try {
				int gameId = Integer.parseInt(gameIdParam);
				Game game = gameDAO.getGameById(gameId);
				if (game != null) {
					games.add(game);
				}
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		request.setAttribute("games", games);
		request.getRequestDispatcher("GameView.jsp").forward(request, response);
	}
}
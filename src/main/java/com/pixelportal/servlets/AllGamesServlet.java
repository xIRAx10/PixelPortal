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

@WebServlet("/AllGamesServlet")
public class AllGamesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		GameDAO gameDAO = new GameDAO();
		List<Game> allGames = gameDAO.getAllGames();
		request.setAttribute("allGames", allGames);
		request.getRequestDispatcher("Index.jsp").forward(request, response);
	}
}

package com.pixelportal.servlets;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.pixelportal.dao.UserDAO;
import com.pixelportal.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

//        System.out.println("Login attempt for username: " + username); // Debug

        UserDAO userDAO = new UserDAO();
        User user = userDAO.validateUser(username, password);

        if (user != null) {
//            System.out.println("User validated successfully: " + username); // Debug
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("Index.jsp");
        } else {
//            System.out.println("Invalid username or password for user: " + username); // Debug
            response.sendRedirect("Login.jsp?error=" + URLEncoder.encode("Usuario o contraseña inválidos", "UTF-8"));
            }
    }
}
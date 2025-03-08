<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.pixelportal.model.User"%>
<%
User loggedInUser = (User) session.getAttribute("user");
boolean isLoggedIn = loggedInUser != null;
%>

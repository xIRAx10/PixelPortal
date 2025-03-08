<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="com.pixelportal.model.User"%>
<%@ page import="com.pixelportal.model.Comment"%>
<%@ page import="com.pixelportal.model.Game"%>
<%@ page import="com.pixelportal.database.DatabaseConnection"%>
<%@ include file="auth.jsp"%>
<%
response.setContentType("text/html; charset=UTF-8");
response.setCharacterEncoding("UTF-8");

User profileUser = (User) request.getAttribute("profileUser");
List<Comment> userComments = (List<Comment>) request.getAttribute("userComments");
Boolean isFriendAttr = (Boolean) request.getAttribute("isFriend");
boolean isFriend = isFriendAttr != null && isFriendAttr;
List<Game> userGames = (List<Game>) request.getAttribute("userGames");
List<User> userFriends = (List<User>) request.getAttribute("userFriends");
User sessionUser = (User) session.getAttribute("user");
List<User> pendingRequests = (List<User>) request.getAttribute("pendingRequests");

boolean isLoggeadoIn = sessionUser != null;
int userId = isLoggedIn ? sessionUser.getUserId() : 0;

boolean isBanned = profileUser != null && "banned".equals(profileUser.getStatus());

String avatarUrl = profileUser != null ? profileUser.getAvatarUrl() : null;
String username = profileUser != null ? profileUser.getUsername() : "Usuario desconocido";
String bio = profileUser != null ? profileUser.getBio() : null;

int friendRequestsCount = 0;
if (isLoggedIn) {
    try (Connection conn = DatabaseConnection.getConnection()) {
        String sql = "SELECT COUNT(*) FROM friends WHERE friend_id = ? AND status = 'requested'";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    friendRequestsCount = rs.getInt(1);
                }
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
}
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Mi perfil - Pixel Portal</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@latest/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<style>
header {
	background: linear-gradient(to bottom, black 95%, #2EEAE3);
	width: 100%;
	min-height: 100px;
	display: flex;
	align-items: center;
	justify-content: space-between;
	padding: 0 5%;
}

header img {
	border: 1px solid black;
}

nav {
	height: 50%;
	display: flex;
	align-items: center;
}

.logo {
	margin-top: 2em;
	border: 1px solid black;
	width: 200px;
	display: flex;
	height: 100px;
	position: relative;
}

.navbar-toggler {
	border: 3px solid black !important;
	background: linear-gradient(to right, #2EEAE3, #66b3e8);
}

.navbar-toggler-icon {
	background-image:
		url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='%23ffffff' class='bi bi-list' viewBox='0 0 16 16'%3e%3cpath fill-rule='evenodd' d='M.5 5.5A.5.5 0 0 1 1 5h14a.5.5 0 0 1 0 1H1a.5.5 0 0 1-.5-.5zm0 4A.5.5 0 0 1 1 9h14a.5.5 0 0 1 0 1H1a.5.5 0 0 1-.5-.5zM1 13.5a.5.5 0 0 0 0 .5h14a.5.5 0 0 0 0-1H1a.5.5 0 0 0 0 .5z'/%3e%3c/svg%3e")
		!important;
}

.form-control {
	border-color: white !important;
}

.btn.border-white {
	border-color: white !important;
	background: linear-gradient(to right, #2EEAE3, #66b3e8) !important;
}

.btn.border-white i {
	color: white !important;
}

.imgLogo {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

footer div ul {
	text-align: center;
	margin: 0 auto;
	width: 30%;
}

.contenedor-small {
	padding-right: 27px;
}

.accordion-header-nav {
	text-align: center;
	cursor: pointer;
	width: 100%;
}

.accordion-content-nav {
	display: none;
	position: absolute;
	background-color: black;
	z-index: 1;
	color: white;
	margin-top: 0;
	width: 10%;
}

.margenHeader {
	margin: 0;
	height: 30px;
	padding-top: 3px;
	padding-left: 8px;
}

.usuario:hover {
	width: 100%;
}

.accordion-header-small {
	cursor: pointer;
	color: white !important;
}

.accordion-header-small.active i {
	transform: rotate(180deg);
	color: white !important;
}

.accordion-content-small {
	display: none;
	text-align: center;
}

@media ( max-width : 990px) {
	.nav-item {
		border-bottom: 1px solid white;
	}
	.navbar-nav {
		border-top: 1px solid white;
		margin-top: 20px;
	}
	.navbar-collapse {
		margin-bottom: -10px;
	}
}

nav li:last-of-type {
	border-bottom: none;
}

footer .nav-link:hover {
	transition: 0.2s ease-in-out;
	color: #FF30E9;
}

header a {
	color: white !important;
}

header a:hover {
	transition: 0.2s ease-in-out;
	color: #FF30E9 !important;
	cursor: pointer !important;
}

footer {
	background: linear-gradient(to top, black 95%, #2EEAE3);
}

body {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background: radial-gradient(ellipse at bottom, #0d1d31 0%, #0c0d13 100%);
	margin: 0;
	position: relative;
}

:root {
	--primary-color: #D4B3E2;
}

.stars {
	position: absolute;
	top: 0;
	left: 0;
	width: 80%;
	height: 70%;
	transform: rotate(-45deg);
	overflow: hidden;
	z-index: -1;
}

@
@keyframes fall { 
    0% {
        transform: translate3d(104em, 0, 0);
    }
    100% {
        transform: translate3d(-100em, 100vh, 0);
    }
}

@keyframes tail-fade { 
    0% {
        opacity: 1;
    }
    100% {
        opacity: 0;
    }
}
@keyframes tail-fade { 
    0% {
        opacity: 1;
    }
    100% {
        opacity: 0;
    }
}

.star {
	--star-color: var(--primary-color);
	--star-tail-length: 6em;
	--star-tail-height: 2px;
	--star-width: calc(var(--star-tail-length)/6);
	--fall-duration: 9s;
	--tail-fade-duration: var(--fall-duration);
	position: absolute;
	top: var(--top-offset);
	left: 0;
	width: var(--star-tail-length);
	height: var(--star-tail-height);
	color: var(--star-color);
	background: linear-gradient(45deg, currentColor, transparent);
	border-radius: 50%;
	filter: drop-shadow(0 0 6px currentColor);
	transform: translate3d(104em, 0, 0);
	animation: fall var(--fall-duration) var(--fall-delay) linear infinite,
		tail-fade var(--tail-fade-duration) var(--fall-delay) ease-out
		infinite;
}

@media screen and (max-width: 750px) {
	.star {
		animation: fall var(--fall-duration) var(--fall-delay) linear infinite;
	}
}

main {
	color: white;
}

.efectoBoton {
	background: linear-gradient(to right, #2EEAE3 20%, #66b3e8 80%);
}

.efectoBoton:hover {
	background: linear-gradient(to right, #2EEAE3 20%, #D4B3E2 80%);
}

.efectoBoton:active {
	background: linear-gradient(to right, #2abdb8 20%, #965daf 80%);
}

.avatar {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	object-fit: cover;
	margin-bottom: 20px;
}

.comment {
	border: 1px solid #ccc;
	padding: 10px;
	margin-bottom: 10px;
	border-radius: 5px;
}

.comment-author {
	font-weight: bold;
}

.comment-text {
	margin-top: 5px;
}

.friend {
	display: inline-block;
	margin-right: 10px;
	margin-bottom: 10px;
}

.game {
	display: inline-block;
	margin-right: 10px;
	margin-bottom: 10px;
}

.custom-file-input {
	display: none;
}

.custom-file-label {
	display: inline-block;
	cursor: pointer;
	padding: 10px 20px;
	border: 1px solid transparent;
	border-radius: 4px;
	background: linear-gradient(to right, #2EEAE3 20%, #66b3e8 80%);
	color: white;
	text-align: center;
}

.custom-file-label:hover {
	background: linear-gradient(to right, #2EEAE3 20%, #D4B3E2 80%);
}

.custom-file-label:active {
	background: linear-gradient(to right, #2abdb8 20%, #965daf 80%);
}

.avatar {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	object-fit: cover;
}

.card-img-top {
	width: 100%;
	height: 150px;
	object-fit: cover;
}

.fondoGuay {
	background-color: #1A1A1A;
	color: white;
}

.game-image {
	max-width: 400px;
	max-height: 450px;
	width: auto;
	height: auto;
}

.notification-badge {
	position: absolute;
	top: 0;
	right: -10px;
	padding: 5px 10px;
	border-radius: 50%;
	background-color: #ff69b4;
	color: white;
	font-size: 14px;
	font-weight: bold;
}
.custom-dropdown {
    background-color: #1A1A1A !important;
}

.custom-dropdown .dropdown-item {
    color: white;
}

.custom-dropdown .dropdown-item:hover {
    background-color: #333333;
}
.neon-pink {
    color: #FF6EC7;
}
</style>
</head>
<body>
	<div class="stars"></div>
	<div class="container-fluid">
		<div class="row">
			<header class="d-flex align-items-center justify-content-center col-12">
            <div class="container-fluid">
                <a href="Index.jsp" class="logo">
                    <img class="imgLogo" src="assets/img/logo.png" />
                </a>
                <div class="d-flex align-items-center justify-content-end" style="margin-top: -50px; margin-bottom: 20px;">
                    <form class="form-inline w-50" action="SearchServlet" method="GET">
                        <div class="input-group">
                            <input type="search" name="buscar" placeholder="Buscar" class="form-control border-white">
                            <button class="btn border-white" type="submit">
                                <i class="bi bi-search text-white"></i>
                            </button>
                        </div>
                    </form>
                </div>

                <nav class="navbar navbar-expand-lg navbar-dark bg-dark bg-transparent mb-4">
                    <div class="container-fluid">
                        <button class="navbar-toggler border border-2 mt-5" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav w-100 list-unstyled d-lg-flex justify-content-lg-center">
                                <li class="nav-item mx-xl-3">
                                    <a class="nav-link text-center mx-auto fs-3" href="Index.jsp">Inicio</a>
                                </li>

                                <% if (isLoggeadoIn) { %>
                                <!--Usuario pantallas lg o más-->
                                <li class="nav-item dropdown mx-xl-3 d-none d-lg-block position-relative">
                                    <a class="nav-link dropdown-toggle text-center mx-auto fs-3" href="#" id="userDropdown"
                                        role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Usuario
                                    </a>
                                    <ul class="dropdown-menu custom-dropdown" aria-labelledby="userDropdown">
                                        <li>
                                            <a class="dropdown-item text-white" href="ProfileServlet?userId=<%= userId %>">Perfil</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item text-white" href="Friends.jsp">Amigos</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item text-white" href="Library.jsp">Mi biblioteca</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item text-white" href="LogoutServlet">Logout</a>
                                        </li>
                                    </ul>
                                    <% if (friendRequestsCount > 0) { %>
                                    <div class="neon-pink friend-request-notification ">
                                        ¡Tienes una nueva solicitud de amistad!
                                    </div>
                                    <% } %>
                                </li>
                                <!--Usuario pantallas md o menor-->
                                <li class="nav-item mx-xl-3 d-lg-none position-relative">
                                    <a class="nav-link text-center mx-auto fs-3" data-bs-toggle="collapse"
                                        href="#collapseUserMenu" role="button" aria-expanded="false" aria-controls="collapseUserMenu">
                                        Usuario
                                        <i class="bi bi-chevron-down"></i>
                                    </a>
                                    <div class="collapse" id="collapseUserMenu">
                                        <a class="text-decoration-none d-block usuario margenHeader ml-2"
                                            href="ProfileServlet?userId=<%= userId %>">Perfil</a>
                                        <a class="text-decoration-none d-block usuario margenHeader" href="Friends.jsp">Amigos</a>
                                        <a class="text-decoration-none d-block usuario margenHeader" href="Library.jsp"
                                            style="margin-bottom: 0px;">Mi biblioteca</a>
                                        <a class="text-decoration-none d-block usuario margenHeader" href="LogoutServlet"
                                            style="margin-bottom: 0px;">Logout</a>
                                    </div>
                                    <% if (friendRequestsCount > 0) { %>
                                    <div class="neon-pink friend-request-notification d-lg-none">
                                        ¡Tienes una nueva solicitud de amistad!
                                    </div>
                                    <% } %>
                                </li>
                                <% } else { %>
                                <li class="nav-item mx-xl-3">
                                    <a class="nav-link text-center mx-auto fs-3" href="Login.jsp">Inicio de sesión</a>
                                </li>
                                <% } %>

                                <li class="nav-item mx-xl-3">
                                    <a class="nav-link text-center mx-auto fs-3" href="Support.jsp">Atención al cliente</a>
                                </li>
                                <li class="nav-item mx-xl-3">
                                    <a class="nav-link text-center mx-auto fs-3" href="ShoppingCart.jsp">Carrito <i
                                            class="bi bi-cart"></i>
                                        <span id="cart-counter" class="badge bg-primary">
                                            <%= session.getAttribute("cart") != null ? ((List<Game>) session.getAttribute("cart")).size() : 0 %>
                                        </span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </header>
		</div>

<main>
    <% if (isBanned) { %>
    <div class="alert alert-danger text-center">Este usuario ha sido baneado de la plataforma de manera permanente.</div>
    <% } else { %>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-4 text-center">
                <img id="avatarImage"
                    src="<%= avatarUrl != null ? avatarUrl : "assets/avatars/default-avatar.png" %>"
                    alt="Avatar" class="avatar">
                <h2><%= username %></h2>
                <p><%= bio != null ? bio : "No hay biografía disponible." %></p>
                <% if (sessionUser != null && profileUser != null && sessionUser.getUserId() != profileUser.getUserId() && !isFriend) { %>
                <form action="FriendRequestServlet" method="post">
                    <input type="hidden" name="userId" value="<%= sessionUser.getUserId() %>">
                    <input type="hidden" name="friendId" value="<%= profileUser.getUserId() %>">
                    <button type="submit" class="btn efectoBoton text-white mt-2">Enviar solicitud de amistad</button>
                </form>
                <% } %>
                <% if (sessionUser != null && profileUser != null && sessionUser.getUserId() == profileUser.getUserId()) { %>
                <form class="mt-4" id="uploadAvatarForm" action="UploadAvatarServlet" method="post"
                    enctype="multipart/form-data">
                    <div>
                        <input class="custom-file-input" type="file" id="avatar" name="avatar" accept="image/*" required> 
                        <label for="avatar" class="custom-file-label">Cambiar avatar</label>
                    </div>
                    <button type="submit" class="btn efectoBoton text-white mt-3 mb-3">Subir avatar</button>
                </form>
                <button id="deleteAvatarButton" class="btn efectoBoton text-white">Eliminar avatar</button>
                <% } %>
            </div>
            <div class="col-md-8">
                <% if (sessionUser != null && profileUser != null && sessionUser.getUserId() == profileUser.getUserId()) { %>
                <h3>Editar perfil</h3>
                <form action="ProfileServlet" method="post" class="mt-3">
                    <div class="mb-3">
                        <label for="bio" class="form-label">Biografía</label>
                        <textarea class="form-control" id="bio" name="bio" rows="2"
                            placeholder="Escribe algo sobre ti..."><%= bio != null ? bio : "" %></textarea>
                    </div>
                    <button type="submit" class="btn efectoBoton text-white">Guardar cambios</button>
                </form>
                <% } %>
                <h3 class="mt-4">Mis juegos</h3>
                <div class="d-flex flex-wrap">
                    <% if (userGames != null && !userGames.isEmpty()) {
                        for (Game game : userGames) { %>
                    <div class="game">
                        <img src="<%= game.getCoverImageUrl() %>" alt="<%= game.getTitle() %>" class="img-thumbnail game-image">
                        <p><%= game.getTitle() %></p>
                    </div>
                    <% } } else { %>
                    <p>No hay juegos en la biblioteca.</p>
                    <% } %>
                </div>
                <h3>Mis amigos</h3>
                <div class="row">
                    <% if (userFriends != null && !userFriends.isEmpty()) {
                        for (User friend : userFriends) { %>
                    <div class="col-6 col-md-3 mb-2">
                        <a href="ProfileServlet?userId=<%= friend.getUserId() %>" class="text-decoration-none">
                            <div class="card h-100 text-center fondoGuay">
                                <div class="d-flex flex-column align-items-center justify-content-center">
                                    <div class="d-flex align-items-center justify-content-center" style="height: 100px;">
                                        <img src="<%= friend.getAvatarUrl() %>" alt="<%= friend.getUsername() %>"
                                            class="img-thumbnail mx-auto d-block" style="width: 80px; height: 80px; object-fit: cover;">
                                    </div>
                                    <div class="card-body p-2">
                                        <h6 class="card-title mb-0 text-white"><%= friend.getUsername() %></h6>
                                    </div>
                                </div>
                                <% if (sessionUser != null && sessionUser.getUserId() == profileUser.getUserId()) { %>
                                <div class="card-footer w-100 text-center">
                                    <form action="RemoveFriendServlet" method="post">
                                        <input type="hidden" name="friendId" value="<%= friend.getUserId() %>">
                                        <button type="submit" class="efectoBoton text-white rounded w-75">Eliminar</button>
                                    </form>
                                </div>
                                <% } %>
                            </div>
                        </a>
                    </div>
                    <% } } else { %>
                    <p>No hay amigos en la lista.</p>
                    <% } %>
                </div>

                <% if (sessionUser != null && profileUser != null && sessionUser.getUserId() == profileUser.getUserId()) { %>
                <h3>Solicitudes de amistad pendientes</h3>
                <div class="d-flex flex-wrap">
                    <% if (pendingRequests != null && !pendingRequests.isEmpty()) {
                        for (User pendingUser : pendingRequests) { %>
                    <div class="friend-request">
                        <img src="<%= pendingUser.getAvatarUrl() %>" alt="<%= pendingUser.getUsername() %>" class="img-thumbnail w-25">
                        <p><%= pendingUser.getUsername() %></p>
                        <form action="AcceptFriendRequestServlet" method="post" style="display: inline;">
                            <input type="hidden" name="userId" value="<%= sessionUser.getUserId() %>">
                            <input type="hidden" name="friendId" value="<%= pendingUser.getUserId() %>">
                            <button type="submit" class="btn btn-success btn-sm">Aceptar</button>
                        </form>
                        <form action="RejectFriendRequestServlet" method="post" style="display: inline;">
                            <input type="hidden" name="userId" value="<%= sessionUser.getUserId() %>">
                            <input type="hidden" name="friendId" value="<%= pendingUser.getUserId() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Rechazar</button>
                        </form>
                    </div>
                    <% } } else { %>
                    <p>No hay solicitudes de amistad pendientes.</p>
                    <% } %>
                </div>
                <% } %>

                <h3 class="mt-4">Buscar usuarios</h3>
                <form action="ProfileServlet" method="get" class="mb-3">
                    <div class="input-group">
                        <input type="text" name="searchQuery" class="form-control" placeholder="Buscar usuarios...">
                        <button type="submit" class="btn efectoBoton text-white">Buscar</button>
                    </div>
                </form>
                <% List<User> searchResults = (List<User>) request.getAttribute("searchResults");
                if (searchResults != null) { %>
                <h3>Resultados de la búsqueda</h3>
                <div class="d-flex flex-wrap">
                    <% if (searchResults != null && !searchResults.isEmpty()) {
                        for (User user : searchResults) { %>
                    <a href="ProfileServlet?userId=<%= user.getUserId() %>" class="text-decoration-none">
                        <div class="card m-2" style="width: 12rem;">
                            <div class="card-body text-center fondoGuay">
                                <img src="<%= user.getAvatarUrl() %>" class="card-img-top" alt="<%= user.getUsername() %>">
                                <p class="card-text text-white"><%= user.getUsername() %></p>
                            </div>
                        </div>
                    </a>
                    <% } } else { %>
                    <p>No hay resultados de búsqueda.</p>
                    <% } %>
                </div>
                <% } %>

                <h3>Comentarios</h3>
                <% if (profileUser != null) {
                    if (sessionUser != null && sessionUser.getUserId() != profileUser.getUserId()) { %>
                <form action="AddCommentServlet" method="post" class="mt-3">
                    <div class="mb-3">
                        <label for="comment" class="form-label">Escribe un comentario</label>
                        <textarea class="form-control" id="comment" name="comment" rows="2" placeholder="Escribe tu comentario aquí..." required></textarea>
                    </div>
                    <input type="hidden" name="profileUserId" value="<%= profileUser.getUserId() %>">
                    <button type="submit" class="btn efectoBoton text-white">Enviar comentario</button>
                </form>
                <% } %>
                <div class="comments mt-3">
                    <% if (userComments != null && !userComments.isEmpty()) {
                        for (Comment comment : userComments) { %>
                    <div class="comment mb-3">
                        <div class="d-flex">
                            <img src="<%= comment.getAuthorAvatarUrl() %>" alt="Avatar" class="rounded-circle me-2" style="width: 40px; height: 40px;">
                            <div>
                                <div class="comment-author">
                                    <strong><%= comment.getAuthorUsername() %></strong>
                                </div>
                                <div class="comment-date"><%= comment.getCreatedAt() %></div>
                            </div>
                        </div>
                        <div class="comment-text mt-2"><%= comment.getCommentText() %></div>
                        <% if (sessionUser != null && sessionUser.getUserId() == profileUser.getUserId()) { %>
                        <form action="DeleteCommentServlet" method="post" class="mt-2">
                            <input type="hidden" name="commentId" value="<%= comment.getCommentId() %>">
                            <button type="submit" class="btn btn-danger btn-sm">Eliminar</button>
                        </form>
                        <% } %>
                    </div>
                    <% } } else { %>
                    <p>No hay comentarios.</p>
                    <% } %>
                </div>
                <% } else { %>
                <p>Perfil no encontrado.</p>
                <% } %>

            </div>
        </div>
    </div>
    <% } %>
</main>




		<footer class="text-dark p-4 mt-5 row text-white">
			<p style="text-align: center;" class="mt-3">&copy; 2024 Pixel
				Portal® Todos los derechos reservados.</p>
			<hr class="hr-primary mt-3">
			<div class="d-flex">
				<ul class="list-unstyled text-center p-3">
					<li class="fw-bold text-center mb-3">Síguenos</li>
					<li><a href="https://youtube.com"
						class="nav-link text-decoration-none"><i
							class="bi bi-youtube me-1"></i>Youtube</a></li>
					<li><a href="https://www.instagram.com/"
						class="nav-link text-decoration-none"><i
							class="bi bi-instagram me-1"></i>Instagram</a></li>
					<li><a href="https://twitter.com/"
						class="nav-link text-decoration-none"><i
							class="bi bi-twitter-x me-1"></i>Twitter-X</a></li>
					<li><a href="https://es-es.facebook.com/"
						class="nav-link text-decoration-none"><i
							class="bi bi-facebook me-1"></i>Facebook</a></li>
					<li><a href="https://www.tiktok.com/"
						class="nav-link text-decoration-none"><i
							class="bi bi-tiktok me-1"></i>Tik Tok</a></li>
				</ul>
				<ul class="list-unstyled text-center p-3">
					<li class="fw-bold text-center mb-3">Legal</li>
					<li><a href="#" class="nav-link text-decoration-none">Condiciones
							de venta</a></li>
					<li><a href="#" class="nav-link text-decoration-none">Información
							legal</a></li>
					<li><a href="#" class="nav-link text-decoration-none">Política
							de privacidad</a></li>
					<li><a href="#" class="nav-link text-decoration-none">Política
							de cookies</a></li>
					<li><a href="#" class="nav-link text-decoration-none">Contratos</a></li>
				</ul>
			</div>
			<hr class="hr-primary mt-3">
		</footer>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>

	<script>
        document.addEventListener('DOMContentLoaded', function() {
            const navItems = document.querySelectorAll('.hover-nav');
            navItems.forEach(item => {
                const header = item.querySelector('.accordion-header-nav');
                const content = item.querySelector('.accordion-content-nav');
                item.addEventListener('mouseenter', function() {
                    header.classList.add('active');
                    content.style.display = 'block';
                });
                item.addEventListener('mouseleave', function() {
                    header.classList.remove('active');
                    content.style.display = 'none';
                });
            });
        });

        document.addEventListener('DOMContentLoaded', function() {
            const headers = document.querySelectorAll('.accordion-header-small');
            headers.forEach(header => {
                header.addEventListener('click', function() {
                    this.classList.toggle('active');
                    const content = this.nextElementSibling;
                    if (content.style.display === 'block') {
                        content.style.display = 'none';
                    } else {
                        content.style.display = 'block';
                    }
                });
            });
        });

        document.addEventListener('DOMContentLoaded', () => {
            const starsContainer = document.querySelector('.stars');
            const starCount = 30;

            for (let i = 0; i < starCount; i++) {
                const star = document.createElement('div');
                star.classList.add('star');
                star.style.setProperty('--top-offset', `${Math.random() * 100}vh`);
                star.style.setProperty('--fall-duration', `${Math.random() * 6 + 6}s`);
                star.style.setProperty('--fall-delay', `${Math.random() * 10}s`);
                starsContainer.appendChild(star);
            }
        });
    </script>
	<script>
$(document).ready(function() {
    $("#uploadAvatarForm").on("submit", function(event) {
        event.preventDefault();

        var formData = new FormData(this);

        $.ajax({
            url: $(this).attr("action"),
            type: $(this).attr("method"),
            data: formData,
            contentType: false,
            processData: false,
            success: function(response) {
                $("#avatarImage").attr("src", response.avatarUrl);
            },
            error: function() {
                alert("Error al subir la imagen");
            }
        });
    });

    $("#deleteAvatarButton").on("click", function() {
        $.ajax({
            url: "DeleteAvatarServlet",
            type: "POST",
            success: function(response) {
                $("#avatarImage").attr("src", response.avatarUrl);
            },
            error: function() {
                alert("Error al eliminar el avatar");
            }
        });
    });
});
</script>
<script>
document.addEventListener('DOMContentLoaded', () => {
    const starsContainer = document.querySelector('.stars');
    const starCount = 30;

    for (let i = 0; i < starCount; i++) {
        const star = document.createElement('div');
        star.classList.add('star');
        star.style.setProperty('--top-offset', `${Math.random() * 100}vh`);
        star.style.setProperty('--fall-duration', `${Math.random() * 6 + 6}s`);
        star.style.setProperty('--fall-delay', `${Math.random() * 10}s`);
        starsContainer.appendChild(star);
    }
});
</script>
</body>
</html>
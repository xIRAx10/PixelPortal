<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="auth.jsp"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="com.pixelportal.model.Game"%>
<%@ page import="com.pixelportal.model.Review"%>
<%@ page import="com.pixelportal.model.User"%>
<%@ page import="com.pixelportal.database.DatabaseConnection"%>
<%
response.setContentType("text/html; charset=UTF-8");
response.setCharacterEncoding("UTF-8");

User sessionUser = (User) session.getAttribute("user");
boolean isLoggeadoIn = sessionUser != null;
int userId = isLoggedIn ? sessionUser.getUserId() : 0;

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

Game game = (Game) request.getAttribute("game");
List<Game> games = (List<Game>) request.getAttribute("games");
String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Resultados de búsqueda - Pixel Portal</title>
<link rel="stylesheet" type="text/css" href="reset.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">

<style>
header {
	background: linear-gradient(to bottom, black 95%, #2EEAE3);
	width: 100%;
	min-height: 100px;
	display: fix;
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
	border: 3px solid black;
}

.navbar-toggler-icon {
	background-image:
		url("data:image/svg+xml,%3csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3e%3cpath stroke='rgba(0, 0, 0, 1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
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

#min-price-label, #max-price-label {
	display: inline-block;
	width: 50px;
	text-align: center;
}

.primeraColumna {
	height: 100%;
	padding-top: 20%;
	box-shadow: 2px 2px 4px rgb(0, 0, 0);
}

.primeraColumna form {
	width: 70%;
}

.segundaColumna {
	height: 100%;
	padding-top: 20%;
}

.formClasificacion {
	margin-bottom: 50px;
}

.formPrecios {
	margin-bottom: 10%;
}

.rating {
	display: flex;
	flex-direction: row-reverse;
	float: left;
}

.rating input[type="radio"] {
	display: none;
}

.rating label {
	display: inline-block;
	font-size: 24px;
	cursor: pointer;
}

.rating label:hover, .rating input[type="radio"]:checked ~ label,
	.rating label:hover ~ label {
	color: #f0ad4e;
}

.accordion {
	border: 1px solid #ccc;
}

.accordion-header {
	background: linear-gradient(to right, #2EEAE3, #66b3e8);
	padding: 10px;
	cursor: pointer;
	display: flex;
	justify-content: space-between;
}

.accordion-header-small {
	cursor: pointer;
	color: white !important;
}

.accordion-header.active i {
	transform: rotate(180deg);
	color: white !important;
}

.accordion-content {
	display: none;
	padding: 10px;
}

.custom-margin-top {
	margin-top: 5%;
}

@media ( max-width : 767px) {
	.custom-margin-top {
		margin-top: 10%;
	}
}

nav li:last-of-type {
	border-bottom: none;
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
}

.accordion-header-small.active i {
	transform: rotate(180deg);
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

footer .nav-link:hover {
	transition: 0.2s ease-in-out;
	color: #FF30E9;
}

footer {
	background: linear-gradient(to top, black 95%, #2EEAE3);
}

.contenedor-small {
	padding-right: 27px;
}

header a {
	color: white !important;
}

header a:hover {
	transition: 0.2s ease-in-out;
	color: #FF30E9 !important;
	cursor: pointer !important;
}

.bordeDegradado {
	border: 10px solid transparent;
	border-image: linear-gradient(to right, #2EEAE3, #66b3e8) 1;
	border-image-slice: 30;
}

table {
	border: 10px solid;
	border-image: linear-gradient(to right, #2EEAE3, #66b3e8) 1;
	border-image-slice: 1;
}

header button {
	background: linear-gradient(to right, #2EEAE3, #66b3e8);
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
	width: 76%;
	height: 70%;
	transform: rotate(-45deg);
	overflow: hidden;
	z-index: -1;
}

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

.card {
	display: flex;
	flex-direction: column;
	height: 100%;
}

.card-body {
	flex: 1 1 auto;
}

.review-card {
	flex: 1 1 auto;
}

.same-height {
	display: flex;
	flex-wrap: wrap;
}

.card-container {
	display: flex;
	justify-content: center;
}

.fondoGuay {
	background-color: #1A1A1A !important;
	color: white !important;
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
			<header
				class="d-flex align-items-center justify-content-center col-12">
				<div class="container-fluid">
					<a href="Index.jsp" class="logo"> <img class="imgLogo"
						src="assets/img/logo.png" />
					</a>
					<div class="d-flex align-items-center justify-content-end"
						style="margin-top: -50px; margin-bottom: 20px;">
						<form class="form-inline w-50" action="SearchServlet" method="GET">
							<div class="input-group">
								<input type="search" name="buscar" placeholder="Buscar"
									class="form-control border-white">
								<button class="btn border-white" type="submit">
									<i class="bi bi-search text-white"></i>
								</button>
							</div>
						</form>
					</div>

					<nav
						class="navbar navbar-expand-lg navbar-dark bg-dark bg-transparent mb-4">
						<div class="container-fluid">
							<button class="navbar-toggler border border-2 mt-5" type="button"
								data-bs-toggle="collapse" data-bs-target="#navbarNav"
								aria-controls="navbarNav" aria-expanded="false"
								aria-label="Toggle navigation">
								<span class="navbar-toggler-icon"></span>
							</button>

							<div class="collapse navbar-collapse" id="navbarNav">
								<ul
									class="navbar-nav w-100 list-unstyled d-lg-flex justify-content-lg-center">
									<li class="nav-item mx-xl-3"><a
										class="nav-link text-center mx-auto fs-3" href="Index.jsp">Inicio</a>
									</li>

									<% if (isLoggeadoIn) { %>
									<!--Usuario pantallas lg o más-->
									<li
										class="nav-item dropdown mx-xl-3 d-none d-lg-block position-relative">
										<a class="nav-link dropdown-toggle text-center mx-auto fs-3"
										href="#" id="userDropdown" role="button"
										data-bs-toggle="dropdown" aria-expanded="false"> Usuario </a>
										<ul class="dropdown-menu custom-dropdown"
											aria-labelledby="userDropdown">
											<li><a class="dropdown-item text-white"
												href="ProfileServlet?userId=<%= userId %>">Perfil</a></li>
											<li><a class="dropdown-item text-white"
												href="Friends.jsp">Amigos</a></li>
											<li><a class="dropdown-item text-white"
												href="Library.jsp">Mi biblioteca</a></li>
											<li><a class="dropdown-item text-white"
												href="LogoutServlet">Logout</a></li>
										</ul> <% if (friendRequestsCount > 0) { %>
										<div class="neon-pink friend-request-notification ">
											¡Tienes una nueva solicitud de amistad!</div> <% } %>
									</li>
									<!--Usuario pantallas md o menor-->
									<li class="nav-item mx-xl-3 d-lg-none position-relative">
										<a class="nav-link text-center mx-auto fs-3"
										data-bs-toggle="collapse" href="#collapseUserMenu"
										role="button" aria-expanded="false"
										aria-controls="collapseUserMenu"> Usuario <i
											class="bi bi-chevron-down"></i>
									</a>
										<div class="collapse" id="collapseUserMenu">
											<a
												class="text-decoration-none d-block usuario margenHeader ml-2"
												href="ProfileServlet?userId=<%= userId %>">Perfil</a> <a
												class="text-decoration-none d-block usuario margenHeader"
												href="Friends.jsp">Amigos</a> <a
												class="text-decoration-none d-block usuario margenHeader"
												href="Library.jsp" style="margin-bottom: 0px;">Mi
												biblioteca</a> <a
												class="text-decoration-none d-block usuario margenHeader"
												href="LogoutServlet" style="margin-bottom: 0px;">Logout</a>
										</div> <% if (friendRequestsCount > 0) { %>
										<div class="neon-pink friend-request-notification d-lg-none">
											¡Tienes una nueva solicitud de amistad!</div> <% } %>
									</li>
									<% } else { %>
									<li class="nav-item mx-xl-3"><a
										class="nav-link text-center mx-auto fs-3" href="Login.jsp">Inicio
											de sesión</a></li>
									<% } %>

									<li class="nav-item mx-xl-3"><a
										class="nav-link text-center mx-auto fs-3" href="Support.jsp">Atención
											al cliente</a></li>
									<li class="nav-item mx-xl-3"><a
										class="nav-link text-center mx-auto fs-3"
										href="ShoppingCart.jsp">Carrito <i class="bi bi-cart"></i>
											<span id="cart-counter" class="badge bg-primary"> <%= session.getAttribute("cart") != null ? ((List<Game>) session.getAttribute("cart")).size() : 0 %>
										</span>
									</a></li>
								</ul>
							</div>
						</div>
					</nav>
				</div>
			</header>



		</div>
		<main class="text-center text-md-start">
			<div class="container mt-5 mb-5">
				<div id="tooltip" class="alert alert-warning"
					style="display: none; position: fixed; top: 20px; right: 20px; z-index: 1000;">
					¡Ya has añadido este juego al carrito!</div>
				<div id="success-tooltip" class="alert alert-success"
					style="display: none; position: fixed; top: 20px; right: 20px; z-index: 1000;">
					¡Juego añadido al carrito!</div>

				<% 
        Boolean gameAdded = (Boolean) session.getAttribute("gameAdded");
        if (gameAdded != null && gameAdded) {
            session.removeAttribute("gameAdded");
        %>
				<div class="alert alert-success">Tu juego ya está en el
					carrito :D</div>
				<% } %>

				<% if (game != null) { %>
				<div class="row justify-content-center same-height">
					<div class="col-md-8 card-container fondoGuay">
						<div class="card mb-4">
							<img src="<%= game.getCoverImageUrl() %>" class="card-img-top"
								alt="<%= game.getTitle() %>">
							<div class="card-body fondoGuay">
								<h5 class="card-title"><%= game.getTitle() %></h5>
								<p class="card-text"><%= game.getDescription() %></p>
								<p class="card-text">
									Precio:
									<%= game.getPrice() %>
									€
								</p>
								<p class="card-text">
									Desarrollador:
									<%= game.getDeveloperName() %></p>
								<p class="card-text">
									Editor:
									<%= game.getPublisherName() %></p>
								<p class="card-text">
									Género:
									<%= game.getGameGenre() %></p>
								<a href="AddToCartServlet?gameId=<%= game.getGameId() %>"
									class="btn btn-primary efectoBoton w-50 btn-primary text-dark fs-5 mt-auto">Añadir
									al carrito</a>

								<div class="reviews mt-4">
									<h5>Valoraciones de otros usuarios:</h5>
									<% List<Review> reviews = game.getReviews();
                            if (reviews != null && !reviews.isEmpty()) {
                                for (Review review : reviews) { %>
									<div class="review-card mb-3 p-2 border fondoGuay">
										<div class="review-header">
											<%= review.getRating() %>
											<i class="bi bi-star-fill text-warning"></i>
										</div>
										<div class="review-body"><%= review.getReviewText() %></div>
										<div class="review-date"><%= review.getReviewDate() %></div>
									</div>
									<% }
                            } else { %>
									<p>Todavía no hay valoraciones para este juego.</p>
									<% } %>
								</div>
							</div>
						</div>
					</div>
				</div>
				<% } else if (games != null && !games.isEmpty()) { %>
				<h1 class="mt-5 mb-5">Resultados de la búsqueda</h1>
				<div class="row justify-content-center same-height">
					<% for (Game gameResult : games) { %>
					<div class="col-md-4 card-container fondoGuay">
						<div class="card mb-4">
							<img src="<%= gameResult.getCoverImageUrl() %>"
								class="card-img-top" alt="<%= gameResult.getTitle() %>">
							<div class="card-body fondoGuay">
								<h5 class="card-title"><%= gameResult.getTitle() %></h5>
								<p class="card-text"><%= gameResult.getDescription() %></p>
								<p class="card-text">
									Precio:
									<%= gameResult.getPrice() %>
									€
								</p>
								<p class="card-text">
									Desarrollador:
									<%= gameResult.getDeveloperName() %></p>
								<p class="card-text">
									Editor:
									<%= gameResult.getPublisherName() %></p>
								<p class="card-text">
									Género:
									<%= gameResult.getGameGenre() %></p>
								<a href="AddToCartServlet?gameId=<%= gameResult.getGameId() %>"
									class="btn btn-primary efectoBoton w-50 btn-primary text-white border border-primary rounded fs-5 mt-auto">Añadir
									al carrito</a>

								<div class="reviews mt-4">
									<h5>Valoraciones de otros usuarios:</h5>
									<% List<Review> reviews = gameResult.getReviews();
                            if (reviews != null && !reviews.isEmpty()) {
                                for (Review review : reviews) { %>
									<div class="review-card mb-3 p-2 border fondoGuay">
										<div class="review-header">
											<%= review.getRating() %>
											<i class="bi bi-star-fill text-warning"></i>
										</div>
										<div class="review-body"><%= review.getReviewText() %></div>
										<div class="review-date"><%= review.getReviewDate() %></div>
									</div>
									<% }
                            } else { %>
									<p class="fondoGuay">Todavía no hay valoraciones para este
										juego.</p>
									<% } %>
								</div>
							</div>
						</div>
					</div>
					<% } %>
				</div>
				<% } else { %>
				<p>No hay juegos que mostrar :(</p>
				<p>
					<a href="Index.jsp" class="text-decoration none">¡Añade alguno!</a>
				</p>
				<% } %>
			</div>
		</main>


		<footer class=" text-dark p-4 mt-5 row text-white">
			<p style="text-align: center;" class="mt-3">&copy; 2024 Sdream.
				Todos los derechos reservados.</p>
			<hr class="hr-primary  mt-3">

			<div class="d-flex ">
				<ul class="list-unstyled text-center  p-3 ">
					<li class=" fw-bold text-center mb-3">Siguenos</li>
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
				<ul class="list-unstyled text-center  p-3 ">
					<li class=" fw-bold text-center mb-3">Legal</li>
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

			<hr class="hr-primary  mt-3">

		</footer>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>

	<script>
        document.addEventListener('DOMContentLoaded', function() {
            const headers = document.querySelectorAll('.accordion-header');

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

    </script>
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

    </script>
	<script>
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
	<script>
    document.addEventListener("DOMContentLoaded", function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            const tooltip = document.getElementById("tooltip");
            tooltip.style.display = "block";
            setTimeout(() => {
                tooltip.style.display = "none";
            }, 3000);
        }
        if (urlParams.has('success')) {
            const successTooltip = document.getElementById("success-tooltip");
            successTooltip.style.display = "block";
            setTimeout(() => {
                successTooltip.style.display = "none";
            }, 3000);
        }
    });
</script>
	<script>
    document.addEventListener("DOMContentLoaded", function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            const tooltip = document.getElementById("tooltip");
            tooltip.style.display = "block";
            setTimeout(() => {
                tooltip.style.display = "none";
            }, 3000);
        }
        if (urlParams.has('success')) {
            const successTooltip = document.getElementById("success-tooltip");
            const gameTitle = urlParams.get('title');
            document.getElementById("game-title").textContent = decodeURIComponent(gameTitle);
            successTooltip.style.display = "block";
            setTimeout(() => {
                successTooltip.style.display = "none";
            }, 3000);
        }
    });
    </script>
	<script>
    document.addEventListener('DOMContentLoaded', function () {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        })
    });
</script>


</body>
</html>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="com.pixelportal.model.Game"%>
<%@ page import="com.pixelportal.model.User"%>
<%@ page import="com.pixelportal.database.DatabaseConnection"%>
<%@ include file="auth.jsp"%>
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

List<Game> cart = (List<Game>) session.getAttribute("cart");
%>

<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Restablecer contraseña - Pixel Portal</title>
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
	border: 3px solid black;
}

.navbar-toggler-icon {
	background-image:
		url("data:image/svg+xml,%3csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3e%3cpath stroke='rgba(0, 0, 0, 1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
}

.precioJuego {
	background-color: black;
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

.navbar-toggler-icon {
	background-image:
		url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='%23ffffff' class='bi bi-list' viewBox='0 0 16 16'%3e%3cpath fill-rule='evenodd' d='M.5 5.5A.5.5 0 0 1 1 5h14a.5.5 0 0 1 0 1H1a.5.5 0 0 1-.5-.5zm0 4A.5.5 0 0 1 1 9h14a.5.5 0 0 1 0 1H1a.5.5 0 0 1-.5-.5zM1 13.5a.5.5 0 0 0 0 .5h14a.5.5 0 0 0 0-1H1a.5.5 0 0 0 0 .5z'/%3e%3c/svg%3e");
}

footer {
	background: linear-gradient(to top, black 95%, #2EEAE3);
}

.bordeArticle {
	border: 10px solid transparent;
	border-image: linear-gradient(to right, #2EEAE3, #66b3e8) 1;
	border-image-slice: 30;
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
	width: 80%;
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

body {
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	background: radial-gradient(ellipse at bottom, #0d1d31 0%, #0c0d13 100%);
	margin: 0;
}

.main {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
}

.reset-password {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
}

.container {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
	padding: 20px;
	background-color: #1a1a1a;
	border-radius: 10px;
	box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.5);
}

.reset-form {
	width: 100%;
	max-width: 400px;
}

.form-title {
	color: white;
	text-align: center;
	margin-bottom: 20px;
}

.form-group {
	display: flex;
	align-items: center;
	margin-bottom: 15px;
}

.form-group label {
	color: white;
	margin-right: 10px;
}

.form-group input {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.form-button {
	text-align: center;
}

.form-submit {
	background: linear-gradient(to right, #2EEAE3 20%, #66b3e8 80%);
	color: white;
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background 0.3s ease-in-out;
}

.form-submit:hover {
	background: linear-gradient(to right, #2EEAE3 20%, #D4B3E2 80%);
}

.form-submit:active {
	background: linear-gradient(to right, #2abdb8 20%, #965daf 80%);
}

.alert {
	margin-top: 20px;
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

									<%
									if (isLoggeadoIn) {
									%>
									<!--Usuario pantallas lg o más-->
									<li
										class="nav-item dropdown mx-xl-3 d-none d-lg-block position-relative">
										<a class="nav-link dropdown-toggle text-center mx-auto fs-3"
										href="#" id="userDropdown" role="button"
										data-bs-toggle="dropdown" aria-expanded="false"> Usuario </a>
										<ul class="dropdown-menu custom-dropdown"
											aria-labelledby="userDropdown">
											<li><a class="dropdown-item text-white"
												href="ProfileServlet?userId=<%=userId%>">Perfil</a></li>
											<li><a class="dropdown-item text-white"
												href="Friends.jsp">Amigos</a></li>
											<li><a class="dropdown-item text-white"
												href="Library.jsp">Mi biblioteca</a></li>
											<li><a class="dropdown-item text-white"
												href="LogoutServlet">Logout</a></li>
										</ul> <%
 if (friendRequestsCount > 0) {
 %>
										<div class="neon-pink friend-request-notification ">
											¡Tienes una nueva solicitud de amistad!</div> <%
 }
 %>
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
												href="ProfileServlet?userId=<%=userId%>">Perfil</a> <a
												class="text-decoration-none d-block usuario margenHeader"
												href="Friends.jsp">Amigos</a> <a
												class="text-decoration-none d-block usuario margenHeader"
												href="Library.jsp" style="margin-bottom: 0px;">Mi
												biblioteca</a> <a
												class="text-decoration-none d-block usuario margenHeader"
												href="LogoutServlet" style="margin-bottom: 0px;">Logout</a>
										</div> <%
 if (friendRequestsCount > 0) {
 %>
										<div class="neon-pink friend-request-notification d-lg-none">
											¡Tienes una nueva solicitud de amistad!</div> <%
 }
 %>
									</li>
									<%
									} else {
									%>
									<li class="nav-item mx-xl-3"><a
										class="nav-link text-center mx-auto fs-3" href="Login.jsp">Inicio
											de sesión</a></li>
									<%
									}
									%>

									<li class="nav-item mx-xl-3"><a
										class="nav-link text-center mx-auto fs-3" href="Support.jsp">Atención
											al cliente</a></li>
									<li class="nav-item mx-xl-3"><a
										class="nav-link text-center mx-auto fs-3"
										href="ShoppingCart.jsp">Carrito <i class="bi bi-cart"></i>
											<span id="cart-counter" class="badge bg-primary"> <%=session.getAttribute("cart") != null ? ((List<Game>) session.getAttribute("cart")).size() : 0%>
										</span>
									</a></li>
								</ul>
							</div>
						</div>
					</nav>
				</div>
			</header>

		</div>
		<div class="main">
			<section class="reset-password mt-4">
				<div class="container mt-4">
					<div class="reset-content">
						<div class="reset-form">
							<h2 class="form-title">Restablecer contraseña</h2>
							<form method="post" action="ResetPasswordServlet"
								class="register-form" id="reset-form">
								<div class="form-group">
									<label for="email"><i class="zmdi zmdi-email"></i></label> <input
										type="email" name="email" id="email"
										placeholder="Tu correo electrónico" required />
								</div>
								<div class="form-group form-button">
									<input type="submit" name="reset" id="reset"
										class="form-submit" value="Enviar enlace de restablecimiento" />
								</div>
								<%
								if (request.getAttribute("error") != null) {
								%>
								<div class="alert alert-danger" role="alert">
									<%=request.getAttribute("error")%>
								</div>
								<%
								}
								%>
								<%
								if (request.getAttribute("message") != null) {
								%>
								<div class="alert alert-success" role="alert">
									<%=request.getAttribute("message")%>
								</div>
								<%
								}
								%>
							</form>
						</div>
					</div>
				</div>
			</section>
		</div>

		<footer class=" text-dark p-4 mt-5 row text-white">
			<p style="text-align: center;" class="mt-3">&copy; 2024 Pixel
				Portal® Todos los derechos reservados.</p>
			<hr class="hr-primary  mt-3">
			<div class="d-flex ">
				<ul class="list-unstyled text-center  p-3 ">
					<li class=" fw-bold text-center mb-3">Síguenos</li>
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

	<!-- js de acordeón header en pantallas grandes-->
	<script>
    var minPriceInput = document.getElementById('min-price');
    var maxPriceInput = document.getElementById('max-price');
    var minPriceLabel = document.getElementById('min-price-label');
    var maxPriceLabel = document.getElementById('max-price-label');

    function updateMaxPrice() {
        if (parseInt(maxPriceInput.value) < parseInt(minPriceInput.value)) {
            maxPriceInput.value = minPriceInput.value;
        }
        maxPriceLabel.textContent = maxPriceInput.value;
    }

    function updateMinPrice() {
        if (parseInt(minPriceInput.value) > parseInt(maxPriceInput.value)) {
            minPriceInput.value = maxPriceInput.value;
        }
        minPriceLabel.textContent = minPriceInput.value;
    }

    minPriceInput.addEventListener('input', function() {
        updateMinPrice();
    });

    maxPriceInput.addEventListener('input', function() {
        updateMaxPrice();
    });
</script>



	<!-- js de acordeón header en pantallas grandes-->
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
    document.getElementById('min-price').addEventListener('input', function() {
        document.getElementById('min-price-label').textContent = this.value;
    });

    document.getElementById('max-price').addEventListener('input', function() {
        document.getElementById('max-price-label').textContent = this.value;
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

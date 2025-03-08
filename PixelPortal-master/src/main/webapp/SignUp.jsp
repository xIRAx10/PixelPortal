<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>��nete! - Pixel Portal</title>

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
		url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='30' height='30' fill='%23ffffff' class='bi bi-list' viewBox='0 0 16 16'%3e%3cpath fill-rule='evenodd' d='M.5 5.5A.5.5 0 0 1 1 5h14a.5.5 0 0 1 0 1H1a.5.5.5 0 0 1-.5-.5zm0 4A.5.5 0 0 1 1 9h14a.5.5.5 0 0 1 0 1H1a.5.5.5 0 0 1-.5-.5zM1 13.5a.5.5 0 0 0 0 .5h14a.5.5.5 0 0 0 0-1H1a.5.5.5 0 0 0 0 .5z'/%3e%3c/svg%3e");
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

.form-container {
	background-color: #1A1A1A;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0px 15px 16.83px 0.17px rgba(0, 0, 0, 0.05);
}
</style>
</head>
<body>
	<div class="stars"></div>
	<div class="container-fluid">
		<div class="row">
			<!-- Contenido principal de registro -->
			<main>
				<div class="container mt-5">
					<div class="row justify-content-center">
						<div class="col-md-6 form-container">
							<h2 class="mb-4">Registrarse</h2>
							<form method="post" action="RegisterServlet" class="register-form" id="register-form">
								<div class="mb-3">
									<label for="username" class="form-label">Nombre:</label>
									<input type="text" name="username" id="username" class="form-control" placeholder="Tu nombre" required>
								</div>
								<div class="mb-3">
									<label for="email" class="form-label">Correo electr�nico:</label>
									<input type="email" name="email" id="email" class="form-control" placeholder="Tu Email" required>
								</div>
								<div class="mb-3">
									<label for="password" class="form-label">Contrase�a:</label>
									<input type="password" name="password" id="password" class="form-control" placeholder="Contrase�a" data-bs-toggle="tooltip" data-bs-placement="right" title="M�nimo 8 caracteres, incluyendo una may�scula y un car�cter especial." required>
								</div>
								<div class="mb-3">
									<label for="confirmPassword" class="form-label">Repite tu contrase�a:</label>
									<input type="password" name="confirmPassword" id="confirmPassword" class="form-control" placeholder="Repite tu contrase�a" required>
								</div>
								<div class="form-check mb-3">
									<input type="checkbox" name="agree-term" id="agree-term" class="form-check-input">
									<label for="agree-term" class="form-check-label">Acepto todas las condiciones en <a href="#" class="term-service text-info">T�rminos de servicio</a></label>
								</div>
								<div class="mb-3">
									<input type="submit" name="signup" id="signup" class="btn btn-primary efectoBoton w-100" value="Registrarse">
								</div>
								<%
								if (request.getParameter("error") != null) {
								%>
								<div class="alert alert-danger" role="alert">
									<%=request.getParameter("error")%>
								</div>
								<%
								}
								%>
							</form>
							<div class="signup-image">
								<a href="Login.jsp" class="signup-image-link text-white font-weight-bold">Ya tengo cuenta</a>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
	<script>
		var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
		var tooltipList = tooltipTriggerList.map(function(tooltipTriggerEl) {
			return new bootstrap.Tooltip(tooltipTriggerEl)
		})
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

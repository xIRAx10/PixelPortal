<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.pixelportal.model.User"%>
<%
response.setContentType("text/html; charset=UTF-8");
response.setCharacterEncoding("UTF-8");

User sessionUser = (User) session.getAttribute("user");
String userLibraryUrl = "Library.jsp";
if (sessionUser != null) {
	userLibraryUrl = "Library.jsp?userId=" + sessionUser.getUserId();
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Pasarela de pago - Pixel Portal</title>
<link rel="stylesheet" type="text/css" href="reset.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@latest/font/bootstrap-icons.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
<style>
body, html {
	height: 100%;
	margin: 0;
	background: #0C1421;
}

.container-fluid {
	height: 100%;
}

.contenedorForm {
	position: relative;
	top: 50%;
	transform: translateY(-50%);
	margin-left: auto;
	margin-right: auto;
}

h2 {
	border: 1px solid white;
	background-color: #66b3e8;
	width: 100%;
	padding-bottom: 7px;
}

form {
	background-color: #1A1A1A;
	border: 1px solid black;
	margin-top: -10px;
	padding: 20px;
	color: white;
}

header {
	display: flex;
	align-items: center; /* Alinea verticalmente */
	justify-content: center; /* Alinea horizontalmente */
	color: white;
}

label {
	font-size: 1.2em;
	display: inline;
}

input {
	display: inline;
}

@media ( max-width : 990px) {
	@media ( max-width : 990px) {
		#tercerForm fieldset:not(#pagos) label {
			display: block;
			margin-top: 20px;
		}
	}
	#segundoForm input {
		display: block;
		align-items: center;
		margin: auto;
		margin-bottom: 10px;
	}
}

@media ( min-width : 990px) {
	label[for="nombre_visa"] {
		margin-left: -107px;
	}
	label[for="email"] {
		margin-left: -85px;
	}
	label[for="vencimiento_visa"] {
		margin-left: -28px;
	}
	label[for="cvv_visa"] {
		margin-left: -224px;
	}
	#tercerForm input {
		margin-left: 20px;
		margin-top: 20px;
	}
	#segundoForm input {
		margin-left: 20px;
		margin-top: 20px;
	}
	label[for="numero_tarjeta"] {
		margin-left: -87px;
	}
	label[for="fecha_vencimiento"] {
		margin-left: -135px;
	}
	label[for="cvv"] {
		margin-left: -228px;
	}
	label[for="myInput"] {
		margin-left: -60px;
	}
}

.code-container {
	width: 100%;
	height: 200px; 
	padding: 5px;
	overflow-y: auto;
	white-space: pre-wrap;
}

.gracias {
	border: 5px solid #66b3e8;
	background-color: white;
	border-radius: 45px;
	position: relative;
	top: 50%;
	transform: translateY(-50%);
	margin-left: auto;
	margin-right: auto;
}

h4, h6 {
	font-weight: normal;
	margin-top: 30px;
}

#cvv_visa, #cvv {
	width: 35px !important;
}

input[type="submit"], button {
	background: linear-gradient(to right, #2EEAE3 20%, #66b3e8 80%);
}

input[type="submit"]:hover, button:hover {
	background: linear-gradient(to right, #2EEAE3 20%, #D4B3E2 80%);
}

.loader {
	width: fit-content;
	font-size: 50px;
	font-family: monospace;
	line-height: 1.4;
	font-weight: bold;
	background: linear-gradient(#2EEAE3 0 0) left,
		linear-gradient(#2EEAE3 0 0) right;
	background-repeat: no-repeat;
	border-right: 5px solid #0000;
	border-left: 5px solid #0000;
	background-origin: border-box;
	position: relative;
	animation: l9-0 2s infinite;
	margin: 0 auto;
	margin-top: 250px;
}

.loader::before {
	content: "Loading";
	color: #2EEAE3;
}

.loader::after {
	content: "";
	position: absolute;
	top: 100%;
	left: 0;
	width: 22px;
	height: 60px;
	background: linear-gradient(90deg, white 4px, #0000 0 calc(100% - 4px),
		white 0) bottom/22px 20px,
		linear-gradient(90deg, #D4B3E2 4px, #0000 0 calc(100% - 4px), #D4B3E2
		0) bottom 10px left 0/22px 6px, linear-gradient(white 0 0) bottom 3px
		left 0/22px 8px, linear-gradient(white 0 0) bottom 0 left 50%/8px 16px;
	background-repeat: no-repeat;
	animation: l9-1 2s infinite;
}

@
keyframes l9-0 { 0%,25% {
	background-size: 50% 100%
}

25
.1 %, 75 % {
	background-size: 0 0, 50% 100%
}

75
.1 %, 100 %{
	background-size: 0 0, 0 0
}

}
@
keyframes l9-1 { 25% {
	background-position: bottom, bottom 54px left 0, bottom 3px left 0,
		bottom 0 left 50%;
	left: 0
}

25
.1 % {
	background-position: bottom, bottom 10px left 0, bottom 3px left 0,
		bottom 0 left 50%;
	left: 0
}

50
%
{
background-position
:
bottom
,
bottom
10px
left
0
,
bottom
3px
left
0
,
bottom
0
left
50%;
left
:
calc(
100%
-
 
22px
)
}
75
%
{
background-position
:
bottom
,
bottom
54px
left
0
,
bottom
3px
left
0
,
bottom
0
left
50%;
left
:
calc(
100%
-
 
22px
)
}
75
.1 % {
	background-position: bottom, bottom 10px left 0, bottom 3px left 0,
		bottom 0 left 50%;
	left: calc(100% - 22px)
}

}
input[type="submit"]:active, button:active {
	background: linear-gradient(to right, #2abdb8 20%, #965daf 80%);
}

.toggle-btn {
	cursor: pointer;
	user-select: none;
}

.error {
	color: red;
	display: none;
}

#continuar2 {
	display: none;
}

.fondoGuay {
	color: white;
	background-color: #0C1421;
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

</style>
</head>

<body>

	<div class="container-fluid">
		<div class="contenedorForm text-center">

			<header class="w-lg-50 w-75 mx-auto" style="margin-bottom: -10px;">
				<h2>Términos y condiciones</h2>
			</header>
			<form id="primerForm" action="#" method="post"
				class="w-lg-50 w-75 mx-auto text-center">
				<div class="container">
					<div class="code-container">
						<h1>Términos y Condiciones - Pixel Portal</h1>
						<p>Bienvenido a Pixel Portal, la plataforma líder para comprar
							y descargar videojuegos.</p>

						<h3>1. Uso del Sitio</h3>
						<p>Al acceder y utilizar este sitio web, usted acepta cumplir
							con estos términos y condiciones y todas las leyes y regulaciones
							aplicables.</p>
						<h3>2. Compras</h3>
						<p>Al comprar un videojuego en Sdream, usted acepta las
							siguientes condiciones: Los precios de los videojuegos están
							sujetos a cambios sin previo aviso. Las compras son finales y no
							reembolsables, a menos que se indique lo contrario.</p>
						<h3>3. Descargas</h3>
						<p>Una vez que haya completado una compra, puede descargar el
							videojuego correspondiente. Sdream no se hace responsable de los
							problemas técnicos que puedan surgir durante la descarga o
							instalación del juego.</p>

						<h3>4. Privacidad</h3>
						<p>Sdream respeta su privacidad y protege sus datos personales
							de acuerdo con nuestra política de privacidad. Al utilizar
							nuestro sitio web, usted acepta nuestras prácticas de privacidad.</p>

						<h3>5. Modificaciones</h3>
						<p>Sdream se reserva el derecho de modificar estos términos y
							condiciones en cualquier momento sin previo aviso. Se recomienda
							revisar periódicamente esta página para estar al tanto de los
							cambios.</p>

						<h3>6. Contacto</h3>
						<p>Si tiene alguna pregunta sobre estos términos y
							condiciones, por favor contáctenos a través de nuestro formulario
							de contacto en el sitio web.</p>

						<p>Última actualización: 1 de enero de 2024</p>
					</div>


					<input type="checkbox" id="option1" name="option1" value="terminos"
						class="mb-4 mt-3" required> <label for="option1">Acepto
						los términos y condiciones</label> <br> <input type="checkbox"
						id="option2" name="option2" value="propaganda"> <label
						for="option2">Deseo recibir información promocional por
						correo electrónico</label>


					<div class="container">
						<div class="row">
							<div class="col-12">
								<input type="submit" id="continuar1" value="Continuar"
									class="w-50 col-12 mx-auto efectoBoton text-white rounded text-align center"
									style="margin-top: 20px; display: flex; align-items: center; justify-content: center;">
							</div>
						</div>
					</div>


				</div>

			</form>

			<header class="w-lg-50 w-75 mx-auto" style="margin-bottom: -10px;">
				<h2>Contacto</h2>
			</header>
			<form id="segundoForm" action="#" method="post"
				class="w-lg-50 w-75 mx-auto text-center" style="display: none;">

				<fieldset id="infoUsuario">
					<label for="nombre">Nombre:</label> <input type="text" id="nombre"
						name="nombre" required><br> <label for="apellido">Apellido:</label>
					<input type="text" id="apellido" name="apellido" required><br>
					<label for="email">Correo electrónico:</label> <input type="email"
						id="email" name="email" required><br> <label
						for="myInput">Repita el correo: </label> <input type="email"
						id="myInput" required><br> <span class="error"
						id="emailError">Los correos electrónicos no coinciden.</span>
				</fieldset>


				<div class="container">
					<div class="row">
						<div class="col-12">
							<input type="submit" id="continuar2" value="Continuar"
								class="w-50 col-12 mx-auto efectoBoton text-white rounded"
								style="margin-top: 20px; display: flex; align-items: center; justify-content: center;">
						</div>
					</div>
				</div>

			</form>

			<header class="w-lg-50 w-75 mx-auto">
				<h2>Pago</h2>
			</header>


			<form id="tercerForm" action="ProcessPaymentServlet" method="post"
				class="w-lg-50 w-75 mx-auto text-center" style="display: none;">
				<fieldset id="pagos">
					<legend>Tipo de Pago</legend>
					<input type="radio" id="visa" name="tipo_pago" value="visa"
						style="margin-left: -12px;"> <label for="visa"><i
						class="bi bi-credit-card"></i> Visa</label><br> <input type="radio"
						id="paypal" name="tipo_pago" value="paypal"
						style="margin-left: 2px;"> <label for="paypal"><i
						class="bi bi-paypal"></i> PayPal </label><br>
				</fieldset>

				<fieldset id="visa_info" style="display: none;">
					<label for="nombre_visa">Nombre del titular de la tarjeta:</label>
					<input type="text" id="nombre_visa" name="nombre_visa" required
						pattern="[a-zA-Z\s]+" title="Solo letras y espacios permitidos"><br>

					<label for="numero_visa">Número de tarjeta:</label> <input
						type="text" id="numero_visa" name="numero_visa" required
						pattern="\d{16}" title="Debe contener 16 dígitos numéricos"><br>

					<label for="vencimiento_visa">Fecha de vencimiento:</label> <input
						type="text" id="vencimiento_visa" name="vencimiento_visa" required
						placeholder="MM/AA" pattern="(0[1-9]|1[0-2])\/(\d{2})"
						title="Formato MM/AA"><br> <label for="cvv_visa">Código
						de seguridad (CVV):</label> <input type="text" id="cvv_visa"
						name="cvv_visa" required pattern="\d{3}"
						title="Debe contener 3 dígitos numéricos"><br>
				</fieldset>

				<fieldset id="paypal_info" style="display: none;">
					<label for="paypal_email">Correo asociado a PayPal:</label> <input
						type="email" id="paypal_email" name="paypal_email" required><br>

					<label for="repeat_paypal_email">Repita el correo:</label> <input
						type="email" id="repeat_paypal_email" name="repeat_paypal_email"
						required><br> <label for="paypal_password">Contraseña:</label>
					<input type="password" id="paypal_password" name="paypal_password"
						required minlength="8"><br>
				</fieldset>


				<div class="container">
					<div class="row">
						<div class="col-12">
							<button id="pagar"
								class="w-50 col-12 mx-auto efectoBoton rounded text-white"
								style="margin-top: 20px; display: flex; align-items: center; justify-content: center;">Pagar</button>
						</div>
					</div>
				</div>
			</form>

			<!-- Loader de nave espacial -->
			<div class="loader" style="display: none;"></div>

			<!-- Contenedor de agradecimiento -->
			<div class="gracias text-center w-lg-50 w-75 mx-auto"
				style="display: none;">
				<h1 class="mt-3">¡Muchas gracias por tu compra!</h1>
				<h4>Se te enviará la factura de tu compra al correo electrónico
					asociado a tu cuenta.</h4>
				<h6 class="mb-3">
					Para acceder a tu biblioteca de juegos, haz clic <a
						id="libraryLink" href="<%=userLibraryUrl%>">aquí</a>.
				</h6>
			</div>

			<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
			<script
				src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
			<script
				src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>



			<script>
document.querySelectorAll('input[name="tipo_pago"]').forEach((radio) => {
    radio.addEventListener('change', () => {
        if (radio.value === 'visa') {
            document.getElementById('visa_info').style.display = 'block';
            document.getElementById('paypal_info').style.display = 'none';
        } else if (radio.value === 'paypal') {
            document.getElementById('visa_info').style.display = 'none';
            document.getElementById('paypal_info').style.display = 'block';
        }
    });
});

document.getElementById('primerForm').addEventListener('submit', function(event) {
    event.preventDefault();
    document.getElementById('primerForm').style.display = 'none';
    document.getElementById('segundoForm').style.display = 'block';
});

document.getElementById('segundoForm').addEventListener('submit', function(event) {
    event.preventDefault();
    document.getElementById('segundoForm').style.display = 'none';
    document.getElementById('tercerForm').style.display = 'block';
});

document.addEventListener("DOMContentLoaded", function() {
    var contenedorForm = document.querySelector(".contenedorForm");
    var loader = document.querySelector(".loader");
    var contenedorGracias = document.querySelector(".gracias");

    document.getElementById("pagar").addEventListener("click", function(event) {
        event.preventDefault();

        contenedorForm.style.display = "none";

        loader.style.display = "block";

        setTimeout(function() {
            loader.style.display = "none";
            document.getElementById('tercerForm').submit();
        }, 5000);
    });
});

function myFunction() {
    var x = document.getElementById("myInput");
    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}

document.getElementById('segundoForm').addEventListener('submit', function(event) {
    const email = document.getElementById('email').value;
    const confirmEmail = document.getElementById('myInput').value;
    const errorElement = document.getElementById('emailError');

    if (email !== confirmEmail) {
        errorElement.style.display = 'inline';
        event.preventDefault(); 
    } else {
        errorElement.style.display = 'none';
    }
});

document.addEventListener('DOMContentLoaded', function() {
    const emailField = document.getElementById('email');
    const confirmEmailField = document.getElementById('myInput');
    const submitButton = document.getElementById('continuar2');
    const errorElement = document.getElementById('emailError');

    function validateEmails() {
        const email = emailField.value;
        const confirmEmail = confirmEmailField.value;

        if (email !== confirmEmail) {
            errorElement.style.display = 'inline';
            submitButton.style.display = 'none';
        } else {
            errorElement.style.display = 'none';
            submitButton.style.display = 'block';
        }
    }

    emailField.addEventListener('input', validateEmails);
    confirmEmailField.addEventListener('input', validateEmails);

    window.myFunction = function() {
        if (confirmEmailField.type === "password") {
            confirmEmailField.type = "text";
        } else {
            confirmEmailField.type = "password";
        }
    }
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

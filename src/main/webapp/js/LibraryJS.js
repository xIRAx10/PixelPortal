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

	var titulosJuego = document.querySelectorAll(".abrirContenedor");
	var contenedorJuegos = document.querySelector(".contenedorJuegos");

	titulosJuego.forEach(function(titulo) {
		titulo.addEventListener("click", function() {
			contenedorJuegos.style.display = "block";
		});
	});
});

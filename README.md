Pixel Portal

Descripción

Pixel Portal es una plataforma de e-commerce y social media dedicada a la compra de videojuegos, sirviendo como intermediario entre desarrolladores, distribuidores y usuarios finales. Además de la adquisición de títulos, la plataforma ofrece herramientas sociales como sistema de amigos, búsqueda de usuarios, comentarios en perfiles y valoraciones de juegos.

Tecnologías Utilizadas

Backend

Java

JavaServer Pages (JSP)

Java Servlets

Apache Tomcat

Maven para la gestión de dependencias

Frontend

HTML5, CSS, Bootstrap

JavaScript, jQuery

Base de Datos

MySQL Workbench

JBDC (Java Database Connectivity)

Control de Versiones

Git

Entorno de Desarrollo

Visual Studio Code

Eclipse for Java EE Developers

Características Principales

Funcionalidades

Registro e inicio de sesión

Gestión de videojuegos (visualización, búsqueda, filtrado, adquisición)

Sistema de valoraciones y comentarios

Perfil de usuario personalizable con avatar, biografía y amigos

Carrito de compras y proceso de pago seguro (Visa/PayPal)

Biblioteca de juegos adquiridos

Página de soporte para consultas y problemas

Diseño de la Interfaz de Usuario

Paleta de Colores

Se ha seleccionado una combinación de colores con un estilo synthwave inspirado en los neones de los años 80, con un alto contraste para mejorar la accesibilidad:

#2EEAE3

#66B3E8

#D4B3E2

#000000 (negro)

#FFFFFF (blanco)

#FF30E9 (rosa fucsia)

Bocetos

Se desarrollaron prototipos iniciales de:

Página de inicio

Carrito de compras

Biblioteca de juegos

Formulario de pago

Interfaz de usuario

Página de soporte

Diseño Final

Página de Inicio

Muestra todos los juegos con filtros por género y precio.

Listado en formato "cards".

Opción de añadir juegos al carrito tras autenticación.

Carrito de Compras

Visualización de juegos seleccionados y total de compra.

Opción de eliminar productos y proceder al pago.

Formulario de Pago

Aceptación de términos y condiciones.

Ingreso de datos personales y verificación del email.

Pago con tarjeta o PayPal.

Biblioteca de Juegos

Lista de juegos adquiridos.

Opción de jugar, valorar y escribir reseñas.

Perfil de Usuario

Biografía personalizable.

Amigos y solicitudes de amistad.

Comentarios en perfiles.

Subida de avatar.

Página de Soporte

Formulario de contacto con selección de categoría de consulta.

Arquitectura

Se sigue una arquitectura Modelo-Vista-Controlador (MVC), con:

Modelo: Representa los datos en la base de datos.

Vista: Archivos JSP con HTML, CSS y JavaScript.

Controlador: Servlets que manejan la lógica del backend.

DAO (Data Access Objects): Acceso estructurado a la base de datos.

Instalación y Ejecución

Prerrequisitos

Java 11+

Apache Tomcat 9+

MySQL Workbench

Maven

IDE (Eclipse o Visual Studio Code)

Pasos para la Instalación

Clonar el repositorio:

git clone https://github.com/tu_usuario/PixelPortal.git

Configurar la base de datos en MySQL Workbench.

Configurar Apache Tomcat.

Ejecutar el proyecto desde el IDE.

Contribución

Si deseas contribuir al proyecto, sigue estos pasos:

Haz un fork del repositorio.

Crea una rama para tu nueva funcionalidad (git checkout -b feature/nueva-funcionalidad).

Realiza tus cambios y confirma los cambios (git commit -m 'Agrega nueva funcionalidad').

Sube los cambios (git push origin feature/nueva-funcionalidad).

Abre un Pull Request.

Licencia

Este proyecto se distribuye bajo la licencia MIT. Ver LICENSE para más información.


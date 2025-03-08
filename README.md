# Pixel Portal

## Descripción del Proyecto

Pixel Portal es una plataforma e-commerce & social media diseñada para la compra de videojuegos. Sirve como intermediario entre desarrolladores, distribuidores y usuarios finales, ofreciendo también herramientas de interacción social como sistema de amigos, comentarios en perfiles y búsqueda de usuarios.

Este proyecto responde a la creciente demanda de videojuegos y a la importancia de la interacción social en línea, combinando una tienda de títulos independientes y de gran éxito con una comunidad activa dentro de la plataforma.

## Características Principales

- **Compra y gestión de videojuegos**: Catálogo con títulos de diferentes desarrolladores y distribuidores.
- **Funciones sociales**: Sistema de amigos, comentarios en perfiles y búsqueda de usuarios.
- **Sistema de valoraciones y reseñas**: Permite a los usuarios calificar y comentar sobre los juegos adquiridos.
- **Accesibilidad y usabilidad**: Diseño responsivo para distintos dispositivos y navegadores.
- **Demo de videojuego**: Ilustración del funcionamiento de la plataforma mediante un título desarrollado para este propósito.

## Tecnologías Utilizadas

### Backend

- **Lenguaje**: Java
- **Frameworks**: JavaServer Pages (JSP), Java Servlets y Java MVC
- **Servidor**: Apache Tomcat
- **Gestión de dependencias**: Maven

### Frontend

- **Lenguajes**: HTML5, CSS, JavaScript
- **Frameworks y librerías**: Bootstrap, JQuery

### Base de Datos

- **Lenguaje**: SQL
- **Gestor de BD**: MySQL Workbench
- **Conectividad**: JDBC (Java Database Connectivity)

### Herramientas de Desarrollo

- **Control de versiones**: Git
- **Entornos de desarrollo**: Eclipse for Java EE Developers, Visual Studio Code

# Estructura del Proyecto

## 1. Plataforma E-Commerce

La plataforma permite a los usuarios:

- **Registrarse e iniciar sesión.**
- **Gestión de videojuegos** (visualización, búsqueda, filtrado, adquisición)
- **Dejar comentarios** en perfiles de otros usuarios.
- **Sistema de valoraciones** y comentarios.
- **Perfil de usuario** personalizable con avatar, biografía y amigos
- **Carrito de compras** y proceso de pago seguro (Visa/PayPal)
- **Página de soporte** para consultas y problemas

### 1.1 Modelo de Datos

El diseño de la base de datos prioriza la integridad y escalabilidad con las siguientes relaciones clave:

- **Usuarios**: Tienen inventarios, amigos, comentarios de perfil, reseñas y publicaciones.
- **Juegos**: Relacionados con desarrolladores y distribuidores, pueden tener reseñas, posts y pertenecer a inventarios de usuarios.
- **Carritos**: Asociados a usuarios, contienen juegos antes de la compra final.

## 2. Videojuego-Demo: Turbo Dank Meme Space Shooting

Un shooter espacial de estilo arcade, accesible vía navegador web.

### 2.1 Requerimientos

- Navegador moderno con soporte HTML5.
- No requiere instalación adicional.

### 2.2 Estructura de Archivos

- **index.html**: Archivo principal del juego.
- **workermain.js**: Lógica del juego.
- **style.css**: Estilos visuales.
- **data.json**: Configuración del juego.
- **images/**, **icons/**, **media/**: Recursos multimedia.

### 2.3 Controles y Mecánicas

- Mover la nave y disparar a enemigos.
- Diferentes tipos de enemigos con niveles de salud.
- Sistema de puntuación y dificultad balanceada.

## 3. Accesibilidad y Usabilidad

Se realizaron pruebas con validadores y test de usuario:

- **Validación W3C**: Cumplimiento de estándares web.
- **eXaminator**: Puntuación de accesibilidad de 8.32/10.
- **Test de Usuario**: Evaluación con diferentes perfiles, destacando organización y facilidad de navegación.
- **Test A/B**: Comparación entre diseños para optimizar la interfaz de usuario.

# 4. Bocetos y Diseño Final

## 4.1 Bocetos

Se desarrollaron prototipos iniciales de las siguientes páginas:

- **Página de inicio**
- **Carrito de compras**
- **Biblioteca de juegos**
- **Formulario de pago**
- **Interfaz de usuario**
- **Página de soporte**

## 4.2 Diseño Final

### Página de Inicio

- Muestra todos los juegos con filtros por género y precio.
- Listado en formato "cards".
- Opción de añadir juegos al carrito tras autenticación.

### Carrito de Compras

- Visualización de juegos seleccionados y total de compra.
- Opción de eliminar productos y proceder al pago.

### Formulario de Pago

- Aceptación de términos y condiciones.
- Ingreso de datos personales y verificación del email.
- Pago con tarjeta o PayPal.

### Biblioteca de Juegos

- Lista de juegos adquiridos.
- Opción de jugar, valorar y escribir reseñas.

### Perfil de Usuario

- Biografía personalizable.
- Amigos y solicitudes de amistad.
- Comentarios en perfiles.
- Subida de avatar.

### Página de Soporte

- Formulario de contacto con selección de categoría de consulta.

## 4.3 Arquitectura

Se sigue una arquitectura Modelo-Vista-Controlador (MVC), con:

- **Modelo**: Representa los datos en la base de datos.
- **Vista**: Archivos JSP con HTML, CSS y JavaScript.
- **Controlador**: Servlets que manejan la lógica del backend.
- **DAO (Data Access Objects)**: Acceso estructurado a la base de datos.

## 5. Conclusiones

El proyecto ha permitido el aprendizaje y aplicación de tecnologías web y desarrollo de videojuegos, superando retos técnicos en seguridad, accesibilidad y optimización. Aunque se han alcanzado los objetivos, hay mejoras pendientes como:

- Despliegue en servidor externo.
- Chat en tiempo real.
- Implementación de pasarela de pago funcional.
- Autenticación mediante doble factor.

## 6. Instalación y Ejecución

### Prerrequisitos

- **Java 11+**
- **Apache Tomcat 9+**
- **MySQL Workbench**
- **Maven**
- **IDE** (Eclipse o Visual Studio Code)

### 7. Pasos para la Instalación


1. Clonar el repositorio:
   ```bash
   git clone https://github.com/tu_usuario/PixelPortal.git
   ```
   
2. Configurar la base de datos en MySQL Workbench.

3. Configurar Apache Tomcat.

4. Ejecutar el proyecto desde el IDE.


## 8. Bibliografía y Recursos

- **Video Tutorial Construct 3**: YouTube
- **Documento Tutorial Juego de Naves**: Calameo
- **Estándares Web y Accesibilidad**: W3C
- **Validadores de HTML y Accesibilidad**: [W3C Validator](https://validator.w3.org) | [eXaminator](https://www.examinator.com)
- **Recursos de Diseño**: [Google Fonts](https://fonts.google.com) | [Bootstrap Icons](https://icons.getbootstrap.com)
- **Backend y MVC en Java**: [JSP en JavaTpoint](https://www.javatpoint.com)




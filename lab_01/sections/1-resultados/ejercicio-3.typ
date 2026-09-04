= Ejercicio 3:Explica cuáles son las partes básicas de una aplicación móvil (interfaz, lógica, eventos, navegación, datos), siguiendo el mismo procedimiento del ejercicio resuelto por el docente. Acompaña tu explicación con un esquema o diagrama propio.
#v(10pt)

Ejemplo elegido: Aplicación Spotify
#v(5pt)
*Paso 1*. Identificar el tipo de aplicación.
Spotify es una aplicación híbrida/nativa con fuerte dependencia de conexión: se instala como app nativa en Android e iOS, pero gran parte de su contenido (canciones, listas, recomendaciones) se obtiene mediante conexión constante a servidores en la nube, con la opción de guardar contenido para uso sin conexión.

*Paso 2*. Describir su interfaz.
La interfaz de la aplicación móvil de Spotify utiliza un diseño de fondo oscuro y el color verde como color principal. Su estructura se organiza de la siguiente manera:
- Pantalla de Inicio: Muestra filtros superiores en forma de burbujas para dividir música y podcasts. Incluye cuadrículas con reproducciones recientes y secciones de recomendaciones personalizadas.
- Barra Inferior: Contiene pestañas fijas para la navegación: Inicio (pantalla principal), Buscar (barra de exploración y categorías), Tu Biblioteca (colecciones guardadas por el usuario), Premium (detalles del plan y beneficios) y Crear (acceso rápido para armar listas o contenido).
- Pantalla de Reproducción: Muestra la portada del álbum, la línea de progreso, los controles de reproducción y la opción de ver las letras en tiempo real.

*Paso 3*. Describir su lógica de funcionamiento.
En Spotify, la lógica se encarga de reproducir las canciones mediante streaming desde la nube, controlando el orden de las pistas y los modos aleatorio o repetir según la interacción del usuario. Ademas, el sistema sincroniza el progreso del audio en tiempo real entre múltiples dispositivos y utiliza un algoritmo para calcular recomendaciones personalizadas basadas en los hábitos y gustos de escucha del usuario.

*Paso 4*. Describir el manejo de eventos.
En Spotify, tocar una canción la reproduce, deslizar la barra de progreso adelanta o retrocede el audio, y mantener presionada una canción despliega opciones como "Añadir a playlist" o "Descargar", etc.

*Paso 5*. Describir la navegación entre pantallas.
La navegación en Spotify se gestiona mediante una barra inferior que permite el acceso directo a las pantallas principales: Inicio, Buscar, Tu Biblioteca, Premium y Crear. Desde la pantalla de Inicio, el usuario puede acceder a su perfil, así como a canciones, álbumes o listas de reproducción específicas. Al ingresar a una playlist, la interfaz permite navegar hacia la pantalla de detalle del artista o abrir la cola de reproducción. Al seleccionar una canción, se abre la pantalla del reproductor a pantalla completa, la cual permite controlar el progreso del audio, dar play y deslizar la pantalla para visualizar la letra de la canción en tiempo real.

*Paso 6*. Describir el almacenamiento de datos.
Los datos son la información que la app guarda y gestiona. En Spotify se almacenan las playlists creadas, el historial de reproducción, las preferencias del usuario y las canciones descargadas; parte de esta información se guarda localmente en el dispositivo y otra parte en servidores remotos (nube).

*Paso 7*. Esquema que resume los cinco elementos:

#figure(
  image("../../img/ejercicio3-spotify.png", width: 100%),
  caption: [Importancia del desarrollo móvil en la actualidad]
)

= Pregunta 4: Elige seis aplicaciones móviles de uso frecuente y completa una tabla con: nombre de la aplicación, finalidad, tipo de usuario, funciones principales y elementos de interfaz que utiliza.

#v(1em)

Al investigar distintas aplicaciones móviles de uso frecuente, se seleccionaron seis que son ampliamente utilizadas debido a su relevancia en el ámbito de la ofimática y otras que forman parte del día a día.

#v(1em)

#let hc(body) = table.cell(fill: rgb("#708090"))[#text(fill: white)[#body]]

#table(
  columns: 5,
  align: left,
  table.header(
    [#hc[Aplicación]], [#hc[Finalidad]], [#hc[Tipo de usuario]], [#hc[Funciones principales]], [#hc[Elementos de interfaz]],
  ),
  [Netflix], [Entretenimiento y streaming de video], [Usuarios generales, suscriptores], [Reproducción de contenido, perfiles, recomendaciones, descarga offline], [Botón play, barra de búsqueda, perfil, carruseles],
  [Google Maps], [Navegación y localización], [Conductores, peatones, viajeros], [Rutas, tránsito en tiempo real, exploración de lugares], [Botones de dirección, capas de mapa, búsqueda, capas],
  [Discord], [Comunicación y chat de comunidad], [Gamers, comunidades, grupos], [Mensajería de voz/texto, llamadas, compartición de pantalla], [Servidores, canales, emojis, barra de voz],
  [Reddit], [Consumo y creación de contenido], [Usuarios de internet, comunidades], [Subreddits, votos, comentarios, publicación de contenido], [Subreddits, upvote/downvote, hilo de comentarios],
  [Google Docs], [Creación y colaboración de documentos], [Usuarios productivos, equipos], [Edición en tiempo real, comentarios, sugerencias], [Botón de compartir, barra de herramientas, sugerencias],
  [Zoom], [Videoconferencias y reuniones], [Profesionales, educadores, equipos], [Reuniones virtuales, compartición de pantalla, salas], [Botón de unirse, galería de participantes, barra de controles],
)

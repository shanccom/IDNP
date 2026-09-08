= Pregunta 1:  ¿Cuál es la diferencia principal entre una aplicación nativa, una aplicación web y una aplicación híbrida? Menciona en qué situación elegirías cada una.
#v(1em)

La diferencia principal radica en la tecnologia utilizada para su desarrollo y la forma en que interactuan con el dispositivo movil.

Una *aplicacion nativa* esta desarrollada especificamente para una plataforma (iOS o Android) utilizando los lenguajes propios de cada sistema (Swift/Kotlin). Ofrece el mejor rendimiento, acceso completo al hardware del dispositivo y una experiencia de usuario optimizada, pero implica un mayor costo de desarrollo ya que se necesita crear una version separada para cada plataforma.

Una *aplicacion web* se accede desde el navegador del dispositivo y esta construida con tecnologias web standard (HTML, CSS, JavaScript). Es multiplataforma por defecto, no requiere instalacion y su mantenimiento es mas sencillo, pero tiene limitaciones en cuanto a rendimiento, acceso a funcionalidades del dispositivo (camara, GPS, notificaciones) y depende de la conexion a internet.

Una *aplicacion hibrida* combina ambos enfoques: utiliza tecnologias web pero se empaqueta como una aplicacion nativa mediante frameworks como Flutter o React Native. Permite un solo codigo fuente para multiples plataformas con acceso intermedio al hardware, equilibrando costo de desarrollo y funcionalidad.

En cuanto a las situaciones en las que elegiria cada una:
- *Nativa*: cuando se requiere alto rendimiento, acceso completo al hardware (juegos, apps de realidad augmentada) o una experiencia de usuario muy pulida.
- *Web*: cuando se busca alcance inmediato sin necesidad de publicacion en tiendas, como portales informativos, herramientas internas o prototipos rapidos.
- *Hibrida*: cuando se necesita presencia en ambas plataformas con recursos limitados, como aplicaciones de servicios, redes sociales o comercio electronico.

#let hc(body) = table.cell(fill: rgb("#708090"))[#text(fill: white)[#body]]

#align(center)[
  #table(
    columns: 4,
    align: (left, left, left, left),
    table.header(
      [#hc[*Caracteristica*]], [#hc[*Nativa*]], [#hc[*Web*]], [#hc[*Hibrida*]],
    ),
    [Rendimiento], [Alto], [Dependiente del navegador], [Medio-Alto],
    [Acceso a hardware], [Completo], [Muy limitado], [Parcial],
    [Costo de desarrollo], [Alto (2 codebases)], [Bajo (1 codebase)], [Medio (1 codebase)],
    [Plataformas], [Una por version], [Todas], [Todas],
    [Instalacion], [Requerida (tienda)], [No requerida], [Requerida (tienda)],
    [Experiencia de usuario], [Optima], [Basica], [Buena],
    [Ejemplos], [Instagram, Spotify], [Gmail web, Wikipedia], [Uber, Airbnb],
  )
]

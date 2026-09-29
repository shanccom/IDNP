= Pregunta 1: ¿Lograste resolver completamente el Ejercicio/Problema Resuelto por el Docente (pantallas Home, Edificios y Mapa navegables mediante NavigationBar, donde el edificio seleccionado en Edificios se refleja en Home)? Adjunta una captura de pantalla del emulador mostrando el resultado como evidencia.

Sí, se resolvió completamente. La `NavigationBar` inferior navega entre *Home*, *Edificios* y *Mapa* marcando siempre el ítem activo, y el edificio elegido en *Edificios* se refleja en *Home*, que pasa de mostrar "Ninguno" a mostrar el nombre seleccionado. Las capturas del emulador evidencian el recorrido completo de la solución.

Ejemplo: se pulsa *Ver* en el "Pabellón A" de la pestaña *Edificios* y, al volver a *Home*, el texto ya indica "Último edificio: Pabellón A".

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  figure(
    image("../../img/resueltoDocente/evidencia-1-home-inicial.png", width: 38%),
    caption: [(a) Home inicial ("Ninguno")],
  ),
  figure(
    image("../../img/resueltoDocente/evidencia-2-edificios.png", width: 38%),
    caption: [(b) Edificios (selección)],
  ),
  figure(
    image("../../img/resueltoDocente/evidencia-3-home-seleccion.png", width: 38%),
    caption: [(c) Home ya actualizado],
  ),
  figure(
    image("../../img/resueltoDocente/evidencia-4-mapa.png", width: 38%),
    caption: [(d) Pantalla Mapa],
  ),
)

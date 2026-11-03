
#let captura(caption, ruta: none, width: 50%) = figure(
  if type(ruta) == array {
    align(center, block(width: 75%, grid(
      columns: (1fr, 1fr),
      gutter: 0.8em,
      ..ruta.map(r => image(r, width: 100%))
    )))
  } else if ruta == none {
    align(center, rect(
      width: 50%,
      height: 4cm,
      stroke: 0.5pt + gray,
      radius: 2pt,
    )[#align(center + horizon)[_Captura de pantalla pendiente_]])
  } else {
    image(ruta, width: width)
  },
  caption: caption,
)

= 1. ¿Lograste resolver completamente el Ejercicio/Problema Resuelto por el Docente (datos de edificios y ambientes almacenados con Room, que persisten al cerrar y volver a abrir la app)? Adjunta una captura de pantalla del emulador mostrando el resultado como evidencia.
#pad(1.5em)[
*Respuesta:*

Sí, logramos completar satisfactoriamente el ejercicio resuelto en conjunto. La arquitectura implementa Room sobre SQLite (`app.db`), persistiendo de forma estructurada las entidades `EdificioEntity` y `AmbienteEntity` vinculadas mediante clave foránea e integridad referencial.

Al ejecutar la aplicación por primera vez, el `EdificiosViewModel` realiza la inserción inicial de los edificios y ambientes de prueba dentro de una corrutina en `viewModelScope`. La interfaz desarrollada en Jetpack Compose observa el flujo `StateFlow` expuesto por el método relacional `obtenerConAmbientes()` para renderizar los datos organizados en una `LazyColumn`.

Para validar la persistencia:
+ Se ejecutó la aplicación y se verificó la correcta carga de los registros en la interfaz.
+ Se cerró completamente el proceso de la aplicación desde la vista multitarea del emulador (forzando su detención).
+ Al volver a abrir la aplicación desde el iniciador de Android, los datos se recuperaron íntegramente desde el almacenamiento local SQLite sin pérdida de información ni duplicación de registros.

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  [
    • *Integrante 1*
    #captura(
      ruta: "../../img/resuelto/paso-12.png",
      width: 50%,
    )[Evidencia en emulador tras reiniciar la aplicación (Integrante 1).]
  ],
  [
    • *Integrante 2*
    #captura(
      ruta: "/img/propuesta2/re-completo.png",
      width: 46%,
    )[Evidencia en emulador tras reiniciar la aplicación (Integrante 2).]
  ]
)

]
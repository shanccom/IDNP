= Pregunta 1: ¿Lograste resolver completamente el Ejercicio/Problema Resuelto por el Docente (pantalla que muestra el porcentaje de batería en tiempo real)? Adjunta una captura de pantalla del emulador mostrando el resultado como evidencia.

== Respuesta

Sí, logramos resolver el ejercicio resuelto en su totalidad. Ambos integrantes implementamos correctamente el composable reactivo para escuchar los eventos del sistema. Confirmamos que el sistema actualiza inmediatamente el porcentaje de carga ante emisiones del hardware sin reiniciar la interfaz.

#v(0.5em)
#block()[
  #text(weight: "bold", size: 8.5pt)[Evidencia de Ejecución — Integrante 1]
  #v(0.3em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 0.8em,
    figure(
      image("../../img/ejercicio1-ejecucion-100.png", width: 95%),
      caption: [Ejecución inicial al 100%.],
    ),
    figure(
      image("../../img/ejercicio1-simulacion-50.png", width: 95%),
      caption: [Simulación de respuesta al 50%.],
    ),
  )
]

#v(0.8em)
#block()[
  #text(weight: "bold", size: 8.5pt)[Evidencia de Ejecución — Integrante 2]
  #v(0.3em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 0.8em,
    figure(
      image("../../img/propuesta2/100.png", width: 95%),
      caption: [Ejecución inicial al 100%.],
    ),
    figure(
      image("../../img/propuesta2/57.png", width: 95%),
      caption: [Simulación de nivel al 57%.],
    ),
    figure(
      image("../../img/propuesta2/20.png", width: 95%),
      caption: [Simulación de nivel crítico al 20%.],
    ),
    figure(
      image("../../img/propuesta2/7.png", width: 95%),
      caption: [Simulación de nivel bajo al 7%.],
    ),
  )
]
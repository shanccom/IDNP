= Pregunta 1: ¿Lograste resolver completamente el Ejercicio/Problema Resuelto por el Docente (pantalla que muestra el porcentaje de batería en tiempo real)? Adjunta una captura de pantalla del emulador mostrando el resultado como evidencia.

== Respuesta

Sí, logré resolver el ejercicio en su totalidad implementando el composable reactivo en Jetpack Compose. El sistema actualiza inmediatamente el porcentaje de carga ante emisiones del hardware sin reiniciar la interfaz.

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  figure(
    image("../../img/ejercicio1-ejecucion-100.png", width: 95%),
    caption: [Ejecución inicial en Android Studio.],
  ),
  figure(
    image("../../img/ejercicio1-simulacion-50.png", width: 95%),
    caption: [Simulación de respuesta al 50%.],
  ),
)

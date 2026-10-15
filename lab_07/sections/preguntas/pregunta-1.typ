= Pregunta 1: ¿Lograste resolver completamente el Ejercicio/Problema Resuelto por el Docente (plano de un ambiente dibujado con Canvas, donde tocar un marcador abre un diálogo con su información)? Adjunta una captura de pantalla del emulador mostrando el resultado como evidencia.

== Respuesta

Sí, logramos resolver de forma completa y satisfactoria el ejercicio propuesto por el docente (`PlanoInteractivo_Compose`). Cada integrante del equipo implementó y verificó el funcionamiento del plano interactivo en su respectivo entorno de desarrollo:

1. *Construcción del lienzo:* Se dibujó el plano geométrico dentro de un `Canvas` de Jetpack Compose, representando los ambientes mediante primitivas `drawRect` y la pared medianera con `drawLine`.
2. *Renderizado de marcadores:* Se definieron las posiciones de los marcadores con coordenadas `Offset` y su radio de cobertura, renderizándolos con `drawCircle`.
3. *Detección de gestos táctiles:* Mediante `Modifier.pointerInput(Unit)` y `detectTapGestures`, se calculó la distancia euclidiana entre el toque del usuario y el centro del marcador para verificar el impacto.
4. *Despliegue del diálogo modal:* Al hacer clic dentro del área activa de un marcador, se actualiza el estado observable `marcadorSeleccionado`, desplegando el diálogo `AlertDialog` con el título y la descripción correspondiente.

=== Evidencia de Ejecución - Estudiante 1

#grid(
  columns: (1.2fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  figure(
    image("../../img/resuelto/paso-11.3.png", width: 90%),
    caption: [Visualización del plano base en el emulador.]
  ),
  figure(
    image("../../img/resuelto/paso-11.1.png", width: 85%),
    caption: [Diálogo informativo modal: Sala A.]
  ),
  figure(
    image("../../img/resuelto/paso-11.2.png", width: 85%),
    caption: [Diálogo informativo modal: Sala B.]
  )
)

=== Evidencia de Ejecución - Estudiante 2

#grid(
  columns: (1.2fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  figure(
    image("../../img/propuesta2/resu-2botones.png", width: 90%),
    caption: [Plano base en emulador (Estudiante 2).]
  ),
  figure(
    image("../../img/propuesta2/resu-boton1.png", width: 85%),
    caption: [Diálogo modal: Sala A (Estudiante 2).]
  ),
  figure(
    image("../../img/propuesta2/resu-boton2.png", width: 85%),
    caption: [Diálogo modal: Sala B (Estudiante 2).]
  )
)
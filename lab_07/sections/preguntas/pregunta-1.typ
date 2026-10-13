= Pregunta 1: ¿Lograste resolver completamente el Ejercicio/Problema Resuelto por el Docente (plano de un ambiente dibujado con Canvas, donde tocar un marcador abre un diálogo con su información)? Adjunta una captura de pantalla del emulador mostrando el resultado como evidencia.

== Respuesta

Sí, se resolvió de forma completa y satisfactoria el ejercicio propuesto por el docente (`PlanoInteractivo_Compose`). En la implementación:

1. Se construyó el plano geométrico dentro de un lienzo `Canvas` de Compose, dibujando los dos ambientes contiguos (*Salón 1* en color azul claro y *Salón 2* en color verde claro) mediante primitivas `drawRect`, y la pared medianera con `drawLine`.
2. Se definieron los marcadores interactivos como instancias de la clase `Marcador` (con coordenadas `Offset`, radio de `40f`, título y descripción), renderizándolos con `drawCircle` en color rojo.
3. Se integró la captura de gestos táctiles con `Modifier.pointerInput(Unit)` y `detectTapGestures`, calculando la distancia euclidiana entre la coordenada del toque y el centro de cada marcador.
4. Al hacer contacto dentro del radio de detección, se actualiza el estado observable `marcadorSeleccionado`, lo que activa la visualización del diálogo modal `AlertDialog` con el nombre y descripción del salón seleccionado.

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
#let codigo(body) = block(
    fill: rgb("#F1F3F4"),
    width: 100%,
    inset: 1em,
    radius: 8pt,
    spacing: 0.65em,
    breakable: true,
  )[
    #set text(size: 7.5pt)
    #set par(justify: false)
    #body
  ]

== Pregunta 2: Además de los argumentos de navegación, ¿qué otro mecanismo podrías usar para compartir datos entre pantallas en una app Compose (por ejemplo, un ViewModel compartido)? Explica brevemente cómo funcionaría.

#pad(1.1em)[
#v(0.5em)

  Un ViewModel compartido es el mecanismo principal. Se crea un ViewModel único y se comparte entre pantallas a través del compositor usando un scope compartido como la Activity:

  #v(0.5em)

  #codigo[
    ```kotlin
    val viewModel: MiViewModel = viewModel()
    ```
  ]

  #v(0.5em)

  Ventajas:

  - Estado centralizado: toda la información compartida se encuentra en un solo lugar, evitando inconsistencias.
  - Persistencia: el ViewModel sobrevive a cambios de configuración como rotaciones de pantalla.
  - Desacoplamiento: las pantallas no necesitan conocerse entre sí; solo acceden al ViewModel.
  - Reactividad: al usar `State` o `LiveData` dentro del ViewModel, los cambios se reflejan automáticamente en todas las pantallas que observen esos estados.

]
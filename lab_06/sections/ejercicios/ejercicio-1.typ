= Ejercicio Propuesto: Tarjetas de Campus con Jetpack Compose

Interfaz en Android que presenta lugares del campus con dos patrones de tarjetas en *Jetpack Compose*: horizontal con `Row` (`TarjetaLugar`) y apilada con imagen de fondo y scrim usando `Box` (`TarjetaCompacta`).

== Paso 1. Creación del Proyecto en Android Studio

Proyecto *Empty Activity* (Compose + Material 3) llamado `TarjetasCampus_Compose` en Kotlin.

== Paso 2. Importaciones necesarias

Importaciones necesarias para maquetación y diseño:

#align(center)[
  #image("../../img/resuelto/resuelto-paso-2.png", width: 48%)
]

== Paso 3. Recursos Gráficos en `res/drawable`

Recursos visuales del campus (`biblioteca.png` y `comedor.png`) en `res/drawable`:

#align(center)[
  #image("../../img/resuelto/resuelto-paso-3.png", width: 36%)
]

== Paso 4. Declaración de `TarjetaLugar`

Función `@Composable TarjetaLugar` con sus parámetros (`nombre`, `descripcion`, `imagen`, `colorFondo`):

#align(center)[
  #image("../../img/resuelto/resuelto-paso-4.png", width: 36%)
]

== Paso 5. Envoltorio `Surface` y estructura `Row`

Contenedor con esquinas de `24.dp` y fila centrada:

#align(center)[
  #image("../../img/resuelto/resuelto-paso-5.png", width: 40%)
]

== Paso 6. Contenido Completo de `TarjetaLugar`

Imagen circular con `Modifier.clip(CircleShape)` y textos con `FontWeight.Bold`:

#align(center)[
  #image("../../img/resuelto/resuelto-paso-6.png", width: 40%)
]

== Paso 7. Llamado en lista (`ListaTarjetasLugar`)

Lista vertical con `Column` y separación de `12.dp`:

#align(center)[
  #image("../../img/resuelto/resuelto-paso-7.png", width: 44%)
]

== Paso 8. Estructura base de `TarjetaCompacta`

Tarjeta apilada con `Box`, altura `140.dp` e imagen de fondo:

#align(center)[
  #image("../../img/resuelto/resuelto-paso-8.png", width: 40%)
]

== Paso 9. Superposición y Scrim en `TarjetaCompacta`

Capa oscura semitransparente (alfa `0.35f`) y texto blanco en `BottomStart`:

#align(center)[
  #image("../../img/resuelto/resuelto-paso-9.png", width: 45%)
]

== Paso 10 y 11. Demostración y Ejecución de la Aplicación

Ambos estilos integrados en `PantallaTarjetas` y ejecutados en el emulador:

#grid(
  columns: (1fr, 1.8fr),
  gutter: 1em,
  align: horizon + center,
  [
    #image("../../img/resuelto/evidencia-1.png", width: 75%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 1: Vista en el emulador]
  ],
  [
    #image("../../img/resuelto/evidencia-2.png", width: 85%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 2: Android Studio y ejecución en simultáneo]
  ]
)

#v(0.4em)
#table(
  columns: (1fr, 2fr, 2fr),
  align: (center + horizon, left, left),
  table.header([*Criterio*], [*Estilo 1: `TarjetaLugar` (Row)*], [*Estilo 2: `TarjetaCompacta` (Box)*]),
  [*Layout Base*], [`Surface` + `Row` + `Column`], [`Box` (superposición en eje Z)],
  [*Tratamiento de Imagen*], [Circular (`CircleShape`), fija `90.dp`], [Fondo completo (`matchParentSize`), recorte `16.dp`],
  [*Legibilidad*], [Texto sobre fondo pastel claro], [Texto blanco sobre imagen con scrim oscuro (35%)],
  [*Resultado Visual*], [Ficha informativa clara con descripción], [Banner compacto de alto impacto visual]
)

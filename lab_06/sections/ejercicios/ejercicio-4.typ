= Ejercicio 3: Reemplaza la lista simple de EdificiosScreen (nombre + botón) por una lista de TarjetaLugar o TarjetaCompacta con datos de al menos 4 edificios del campus.

== Primera propuesta

La `Row` de nombre + botón de `EdificiosScreen` se reemplazó por tarjetas reutilizables, compartiendo el lenguaje visual del Home.

=== Paso 1. Modelo de Datos de los Edificios

Estructura `Lugar` con los atributos que necesitan las tarjetas:

#text(size: 6.5pt)[
```kotlin
data class Lugar(
    val nombre: String,
    val descripcion: String,
    val imagenRes: Int,
    val colorFondo: Color
)

val edificiosCampus = listOf(
    Lugar("Pabellón A", "Aulas y salas de clase del turno mañana", R.drawable.pabellon_a, Color(0xFFBBDEFB)),
    Lugar("Biblioteca Central", "Zona de estudio y préstamo de libros", R.drawable.biblioteca, Color(0xFFC8E6C9)),
    Lugar("Auditorio", "Eventos académicos y ceremonias institucionales", R.drawable.auditorio, Color(0xFFFFE0B2)),
    Lugar("Comedor Universitario", "Servicio de alimentación para estudiantes", R.drawable.comedor, Color(0xFFF8BBD0))
)
```
]

=== Paso 2. Reemplazo del Ítem Simple por `TarjetaLugar`

Cada ítem de la lista pasó de `Text` + `Button` a `TarjetaLugar`, reutilizando la lambda `onAbrirDetalle`:

#text(size: 6.5pt)[
```kotlin
@Composable
fun EdificiosScreen(
    onAbrirDetalle: (String, String, Int) -> Unit
) {
    LazyColumn(
        contentPadding = PaddingValues(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        items(edificiosCampus) { lugar ->
            TarjetaLugar(
                nombre = lugar.nombre,
                descripcion = lugar.descripcion,
                imagen = painterResource(id = lugar.imagenRes),
                colorFondo = lugar.colorFondo,
                onClick = {
                    onAbrirDetalle(lugar.nombre, lugar.descripcion, lugar.imagenRes)
                }
            )
        }
    }
}
```
]

=== Paso 3. Versión Alternativa con `TarjetaCompacta`

La misma lista funciona con `TarjetaCompacta`, con idéntico clic y navegación:

#text(size: 6.5pt)[
```kotlin
items(edificiosCampus) { lugar ->
    TarjetaCompacta(
        nombre = lugar.nombre,
        descripcion = lugar.descripcion,
        imagenRes = lugar.imagenRes,
        onClick = {
            onAbrirDetalle(lugar.nombre, lugar.descripcion, lugar.imagenRes)
        }
    )
}
```
]

=== Evidencias de la Lista de Edificios

Resultado en el emulador con cuatro edificios como tarjetas y navegación al detalle:

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  [
    #image("../../img/propuesto/ejercicio-4-e1.png", width: 95%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 1: EdificiosScreen con lista de TarjetaLugar]
  ],
  [
    #image("../../img/propuesto/ejercicio-4-e2.png", width: 95%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 2: Edificios del campus con TarjetaCompacta]
  ],
  [
    #image("../../img/propuesto/ejercicio-4-e3.png", width: 95%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 3: Navegación al detalle desde la lista]
  ],
  [
    #image("../../img/propuesto/ejercicio-4-e4.png", width: 95%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 4: Detalle de un edificio seleccionado]
  ]
)

== Segunda propuesta

En la segunda propuesta se implementó una interfaz enriquecida para `EdificiosScreen`, incorporando tarjetas con miniaturas ilustradas, etiquetas de distancia en kilómetros e indicadores de navegación, además de una barra de navegación inferior para la navegación global. Cada tarjeta interactiva permite acceder a la pantalla `DetalleLugarScreen` correspondiente.

#align(center)[
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.2em,
    align: horizon + center,
    [
      #image("../../img/propuesto/ejercicio-4-propuesta2.png", width: 62%)
      #v(-0.4em)
      #text(size: 7.5pt, style: "italic")[Evidencia 1: Segunda propuesta — lista de edificios]
    ],
    stack(
      spacing: 0.8em,
      [
        #image("../../img/propuesto/ejrcicio-4-propuesta2.png", width: 72%)
        #v(-0.4em)
        #text(size: 7.5pt, style: "italic")[Evidencia 2: Segunda propuesta — detalle de Biblioteca Central]
      ]
    )
  )
]

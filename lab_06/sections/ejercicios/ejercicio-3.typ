= Ejercicio 2: Envuelve TarjetaLugar y TarjetaCompacta con Modifier.clickable { ... } y, usando el mismo patrón de navegación del Laboratorio 05 (navController.navigate(...) o una lambda), lleva al usuario a DetalleLugarScreen al pulsar una tarjeta.

== Primera y Segunda Propuesta

=== Paso 1. Integración de `Modifier.clickable` en `TarjetaLugar`

`TarjetaLugar` recibe `onClick: () -> Unit = {}` y lo conecta en el `Surface` raíz con `.clickable(onClick = onClick)`:

#text(size: 6.5pt)[
```kotlin
@Composable
fun TarjetaLugar(
    nombre: String,
    descripcion: String,
    imagen: Painter,
    colorFondo: Color,
    onClick: () -> Unit = {}
) {
    Surface(
        shape = RoundedCornerShape(24.dp),
        color = colorFondo,
        modifier = Modifier
            .fillMaxWidth()
            .clickable(onClick = onClick)
    ) {
        // Contenido con imagen circular, textos y espaciadores
    }
}
```
]

=== Paso 2. Integración de `Modifier.clickable` en `TarjetaCompacta`

Mismo caso en `TarjetaCompacta`: `.clickable(onClick = onClick)` justo después de `.clip(RoundedCornerShape(16.dp))` en el `Box` raíz:

#text(size: 6.5pt)[
```kotlin
@Composable
fun TarjetaCompacta(
    nombre: String,
    descripcion: String = "",
    imagenRes: Int,
    onClick: () -> Unit = {}
) {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(140.dp)
            .clip(RoundedCornerShape(16.dp))
            .clickable(onClick = onClick)
    ) {
        // Imagen de fondo, scrim oscuro y textos superpuestos
    }
}
```
]

=== Paso 3. Patrón de Navegación con Lambdas y `navController.navigate`

Las tarjetas despachan la lambda `onAbrirDetalle: (String, String, Int) -> Unit` hacia el nivel superior:

#text(size: 6.5pt)[
```kotlin
// Invocación en PantallaTarjetas (Home)
TarjetaCompacta(
    nombre = "Biblioteca Central",
    descripcion = "Zona de estudio y préstamo de libros",
    imagenRes = R.drawable.biblioteca,
    onClick = { onAbrirDetalle("Biblioteca Central", "Zona de estudio y préstamo de libros", R.drawable.biblioteca) }
)

// Invocación en EdificiosScreen
TarjetaLugar(
    nombre = lugar.nombre,
    descripcion = lugar.descripcion,
    imagen = painterResource(id = lugar.imagenRes),
    colorFondo = lugar.colorFondo,
    onClick = { onAbrirDetalle(lugar.nombre, lugar.descripcion, lugar.imagenRes) }
)
```
]

En `CampusApp`, el `NavHost` ejecuta la transición a `DetalleLugarScreen`:

#text(size: 6.5pt)[
```kotlin
PantallaTarjetas(
    onAbrirDetalle = { nombre, descripcion, imagenRes ->
        navController.navigate(Screen.Detalle.crearRuta(nombre, descripcion, imagenRes))
    }
)
```
]

=== Evidencias de Navegación

Flujo en el emulador: al pulsar una tarjeta se navega a `DetalleLugarScreen`:

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  [
    #image("../../img/propuesto/ejercicio-3-evidencia-1.png", width: 95%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 1: Lista interactiva de Edificios]
  ],
  [
    #image("../../img/propuesto/ejercicio-3-evidencia-2.png", width: 95%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 2: Navegación al detalle del Pabellón A]
  ],
  [
    #image("../../img/propuesto/ejercicio-3-evidencia-3.png", width: 95%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 3: Navegación al detalle del Auditorio]
  ],
  [
    #image("../../img/propuesto/ejercicio-3-evidencia-4.png", width: 95%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 4: Navegación al detalle del Comedor]
  ]
)

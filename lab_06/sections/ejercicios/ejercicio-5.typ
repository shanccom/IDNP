= (Reto opcional) Diseña un tercer estilo de tarjeta propio (por ejemplo con una etiqueta o ícono adicional) y documenta en el informe qué combinación de Row/Column/Box y Modifier utilizaste.

== Primera propuesta

Se implementó `TarjetaEstilo3`, tarjeta minimalista con *etiqueta de distancia* e *ícono de flecha*, con la misma firma `onClick` de los estilos anteriores.

=== Paso 1. Estructura `Surface` como Contenedor Raíz

`Surface` raíz que concentra forma, color, elevación y borde teñido con `colorIcono` (alfa `0.18f`):

#text(size: 6.5pt)[
```kotlin
@Composable
fun TarjetaEstilo3(
    nombre: String,
    descripcion: String,
    etiqueta: String,
    imagenRes: Int,
    colorFondo: Color = MaterialTheme.colorScheme.surface,
    colorIcono: Color = MaterialTheme.colorScheme.primary,
    onClick: () -> Unit = {}
) {
    Surface(
        shape = RoundedCornerShape(18.dp),
        color = colorFondo,
        tonalElevation = 1.dp,
        shadowElevation = 2.dp,
        border = BorderStroke(1.dp, colorIcono.copy(alpha = 0.18f)),
        modifier = Modifier
            .fillMaxWidth()
            .clickable(onClick = onClick)
    ) {
        // Fila interna con imagen, textos, etiqueta e ícono
    }
}
```
]

=== Paso 2. Combinación `Row` + `Column` + `weight(1f)`

`Row` centrada con imagen, textos, etiqueta y flecha; `Modifier.weight(1f)` en el `Column` central reparte el espacio sobrante:

#text(size: 6.5pt)[
```kotlin
Row(
    modifier = Modifier.padding(horizontal = 14.dp, vertical = 14.dp),
    verticalAlignment = Alignment.CenterVertically
) {
    Image(
        painter = painterResource(id = imagenRes),
        contentDescription = nombre,
        contentScale = ContentScale.Crop,
        modifier = Modifier
            .size(52.dp)
            .clip(RoundedCornerShape(14.dp))   // miniatura cuadrada redondeada
    )

    Spacer(modifier = Modifier.width(12.dp))

    Column(
        modifier = Modifier.weight(1f),        // ocupa el espacio sobrante
        verticalArrangement = Arrangement.spacedBy(2.dp)
    ) {
        Text(text = nombre, fontWeight = FontWeight.SemiBold,
             fontSize = 15.sp, maxLines = 1)
        Text(text = descripcion, fontSize = 12.sp,
             color = MaterialTheme.colorScheme.onSurfaceVariant, maxLines = 1)
    }
}
```
]

=== Paso 3. Etiqueta "Píldora" con `Surface` Anidada

Etiqueta de distancia: `Surface` secundaria de `10.dp` con fondo translúcido, más el ícono flecha:

#text(size: 6.5pt)[
```kotlin
Surface(
    shape = RoundedCornerShape(10.dp),
    color = colorIcono.copy(alpha = 0.10f)
) {
    Text(
        text = etiqueta,                       // p. ej. "0.4 km"
        fontWeight = FontWeight.Medium,
        fontSize = 11.sp,
        color = colorIcono,
        modifier = Modifier.padding(horizontal = 10.dp, vertical = 5.dp)
    )
}

Spacer(modifier = Modifier.width(4.dp))

Icon(
    imageVector = Icons.AutoMirrored.Filled.ArrowForward,
    contentDescription = null,
    tint = MaterialTheme.colorScheme.onSurfaceVariant.copy(alpha = 0.45f),
    modifier = Modifier.size(16.dp)
)
```
]

=== Paso 4. Modifiers Utilizados (Resumen)

- `fillMaxWidth()` — ocupa el ancho disponible.
- `clickable(onClick = onClick)` — clic en toda el área.
- `clip(RoundedCornerShape(14.dp))` + `size(52.dp)` — miniatura redondeada.
- `padding(...)` — aire interno de la fila.
- `weight(1f)` — espacio sobrante para los textos.
- `Arrangement.spacedBy(...)` — separación vertical.

=== Paso 5. Invocación en `PantallaTarjetas`

Sección "Estilo 3 · minimalista" en el Home:

#text(size: 6.5pt)[
```kotlin
TarjetaEstilo3(
    nombre = "Biblioteca Central",
    descripcion = "Zona de estudio y préstamo",
    etiqueta = "0.4 km",
    imagenRes = R.drawable.biblioteca,
    colorIcono = Color(0xFF1565C0),
    onClick = {
        onAbrirDetalle(
            "Biblioteca Central",
            "Zona de estudio y préstamo de libros",
            R.drawable.biblioteca
        )
    }
)

TarjetaEstilo3(
    nombre = "Comedor Universitario",
    descripcion = "Alimentación para estudiantes",
    etiqueta = "0.5 km",
    imagenRes = R.drawable.comedor,
    colorIcono = Color(0xFFEF6C00),
    onClick = { onAbrirDetalle("Comedor Universitario", "Servicio de alimentación para estudiantes", R.drawable.comedor) }
)
```
]

=== Evidencias del Tercer Estilo

Resultado en el emulador de la sección "Estilo 3 · minimalista":

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  [
    #image("../../img/propuesto/ejercicio-5-e1.png", width: 85%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 1: Sección "Estilo 3 · minimalista" en el Home]
  ],
  [
    #image("../../img/propuesto/ejercicio-5-e2.png", width: 55%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 2: Tarjetas con etiqueta de distancia e ícono de flecha]
  ]
)

== Segunda propuesta

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  [
    // Reemplazar por: #image("../../img/propuesto/ejercicio-5-p2-e1.png", width: 55%)
    #image("../../img/propuesto/propuesta-2-ejercicio5.png", width: 85%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 1: EdificiosScreen con lista de TarjetaLugar]
  ],
  [
    // Reemplazar por: #image("../../img/propuesto/ejercicio-5-p2-e2.png", width: 55%)
    #image("../../img/propuesto/propuesta-2-ejercicio5.1.png", width: 45%)
    #v(-0.4em)
    #text(size: 7.5pt, style: "italic")[Evidencia 1: EdificiosScreen con lista de TarjetaLugar]
  ],
)

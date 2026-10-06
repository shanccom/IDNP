= Ejercicio 1: Composable DetalleLugarScreen

Crea un Composable DetalleLugarScreen(nombre: String, descripcion: String, imagen: Painter) que muestre la información del lugar a tamaño completo, reutilizando el estilo de TarjetaLugar.

== Primera y Segunda Propuesta

=== Explicación y Reutilización de Estilos

Se reutiliza la línea gráfica de `TarjetaLugar`: `Surface` con esquinas de `24.dp`, imagen a tamaño completo (`fillMaxWidth()`, `240.dp`, `ContentScale.Crop`), nombre en negrita `24.sp` y descripción `16.sp`. Arriba, una `Row` con botón `ArrowBack` que invoca `onVolver`.

=== Implementación del Composable

Código de la pantalla de detalle:

#text(size: 6.5pt)[
```kotlin
@Composable
fun DetalleLugarScreen(
    nombre: String,
    descripcion: String,
    imagen: Painter,
    onVolver: () -> Unit = {}
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .statusBarsPadding()
            .padding(16.dp)
    ) {
        Row(verticalAlignment = Alignment.CenterVertically) {
            IconButton(onClick = onVolver) {
                Icon(
                    imageVector = Icons.AutoMirrored.Filled.ArrowBack,
                    contentDescription = "Volver"
                )
            }
            Text(
                text = "Detalle del lugar",
                style = MaterialTheme.typography.titleMedium
            )
        }

        Spacer(modifier = Modifier.height(16.dp))

        Surface(
            shape = RoundedCornerShape(24.dp),
            color = MaterialTheme.colorScheme.surfaceVariant,
            modifier = Modifier.fillMaxWidth()
        ) {
            Column {
                Image(
                    painter = imagen,
                    contentDescription = nombre,
                    contentScale = ContentScale.Crop,
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(240.dp)
                )

                Column(modifier = Modifier.padding(16.dp)) {
                    Text(
                        text = nombre,
                        fontWeight = FontWeight.Bold,
                        fontSize = 24.sp
                    )
                    Spacer(modifier = Modifier.height(8.dp))
                    Text(
                        text = descripcion,
                        fontSize = 16.sp
                    )
                }
            }
        }
    }
}
```
]

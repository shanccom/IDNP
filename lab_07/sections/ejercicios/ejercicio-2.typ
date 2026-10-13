= Ejercicio 2: Ampliación del Plano Arquitectónico Interactivo

== Enunciado

Amplía el plano resuelto por el docente para representar la visualización interior de al menos una edificación del campus:

1. Amplía la lista de marcadores y agrega los rectángulos/líneas necesarios para representar al menos 4 ambientes (salones y/o patios) de una edificación real del campus, cada uno con su etiqueta visible en el plano.
2. Convierte la lista de marcadores en datos cargados desde un archivo (por ejemplo un .json o .csv en assets/) en lugar de estar escritos directamente en el código, siguiendo un patrón de persistencia similar al usado en el Laboratorio 03.
3. Traslada el estado del plano y sus marcadores a un ViewModel (PlanoViewModel), siguiendo el patrón de ViewModel visto en el Laboratorio 05, en lugar de mantenerlo directamente en el Composable.
4. Integra este plano como una nueva pantalla accesible desde MapaScreen (Laboratorio 05) o desde una tarjeta del Laboratorio 06.

*Entregable:* informe con capturas del plano con al menos 4 ambientes, del diálogo de información al pulsar cada marcador, y una breve descripción de cómo se cargan los datos desde el archivo.

== Desarrollo Paso a Paso

=== Paso 1: Amplía la lista de marcadores y agrega los rectángulos/líneas necesarios para representar al menos 4 ambientes (salones y/o patios) de una edificación real del campus, cada uno con su etiqueta visible en el plano.

Se representó la distribución del *Pabellón de Ingeniería de Sistemas (UNSA)* mediante la clase `Ambiente` (`topLeft`, `size`, `color`, `etiqueta`), cubriendo 6 ambientes reales: Aula A101, Aula A102, Lab. Cómputo, Patio Central, Biblioteca y Cafetería, cada uno con un `Marcador` interactivo asociado.

```kotlin
data class Marcador(val offset: Offset, val radio: Float, val titulo: String, val descripcion: String)
data class Ambiente(val topLeft: Offset, val size: Size, val color: Color, val etiqueta: String)
```

En `PlanoAmbiente` se dibujaron el contorno, ambientes y muros con `drawRect` y `drawLine`. Las etiquetas textuales se trazaron con `drawIntoCanvas` y `nativeCanvas.drawText`, mientras que los marcadores circulares se dibujaron con `drawCircle`.

```kotlin
// Renderizado de ambientes y etiquetas
ambientes.forEach { amb ->
    drawRect(color = amb.color, topLeft = amb.topLeft, size = amb.size)
    drawRect(color = Color(0xFF90A4AE), topLeft = amb.topLeft, size = amb.size, style = Stroke(3f))
    drawIntoCanvas { canvas ->
        val paint = Paint().apply { color = android.graphics.Color.BLACK; textSize = 20f; textAlign = Paint.Align.CENTER; isFakeBoldText = true }
        canvas.nativeCanvas.drawText(amb.etiqueta, amb.topLeft.x + amb.size.width / 2f, amb.topLeft.y + amb.size.height - 12f, paint)
    }
}
// Marcadores circulares
marcadores.forEach { m ->
    drawCircle(color = Color(0xFFE53935), radius = m.radio, center = m.offset)
    drawCircle(color = Color.White, radius = m.radio, center = m.offset, style = Stroke(4f))
}
```

La detección de toques mediante `detectTapGestures` calcula la distancia euclidiana hacia cada marcador para actualizar `marcadorSeleccionado` y abrir un `AlertDialog` informativo.

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  figure(
    image("../../img/propuestos/paso-1-1.png", width: 85%),
    caption: [Visualización general del plano.]
  ),
  figure(
    image("../../img/propuestos/paso-1-2.png", width: 85%),
    caption: [Diálogo informativo: Aula A101.]
  ),
  figure(
    image("../../img/propuestos/paso-1-3.png", width: 85%),
    caption: [Diálogo informativo: Lab. Cómputo.]
  )
)

=== Paso 2: Convierte la lista de marcadores en datos cargados desde un archivo (por ejemplo un .json o .csv en assets/) en lugar de estar escritos directamente en el código, siguiendo un patrón de persistencia similar al usado en el Laboratorio 03.

Se desacopló la lista fija de marcadores creando el archivo de datos `app/src/main/assets/marcadores.csv`, estructurado en formato tabular con cabecera conceptual `x,y,radio,titulo,descripcion`:

```csv
100,115,20,Aula A101,Salón de clases del primer nivel
272,115,20,Aula A102,Salón de clases del primer nivel
100,245,20,Lab. Cómputo,Laboratorio de cómputo
272,245,20,Patio Central,Patio de recreo y descanso
100,360,20,Biblioteca,Sala de lectura y estudio
272,360,20,Cafetería,Servicio de alimentos
```

Siguiendo el patrón de lectura línea a línea del Laboratorio 03, se implementó la función `cargarMarcadores(context: Context)` que lee el archivo mediante `context.assets.open(...).bufferedReader()`. Se utiliza `lineSequence()` para omitir líneas vacías o comentarios, separando los campos por comas (`split(",")`) e instanciando cada `Marcador`. En el Composable `PlanoAmbiente` se reemplazó la lista estática por `remember { cargarMarcadores(context) }`.

```kotlin
fun cargarMarcadores(context: Context): List<Marcador> {
    return try {
        val contenido = context.assets.open("marcadores.csv").bufferedReader().use { it.readText() }
        contenido.lineSequence()
            .map { it.trim() }
            .filter { it.isNotEmpty() && !it.startsWith("#") }
            .mapNotNull { linea ->
                val partes = linea.split(",")
                if (partes.size >= 5) {
                    Marcador(
                        offset = Offset(partes[0].trim().toFloat(), partes[1].trim().toFloat()),
                        radio = partes[2].trim().toFloat(),
                        titulo = partes[3].trim(),
                        descripcion = partes.drop(4).joinToString(",").trim()
                    )
                } else null
            }.toList()
    } catch (e: Exception) { emptyList() }
}
```

#grid(
  columns: (1.2fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  figure(
    image("../../img/propuestos/paso-2-archivo.png", width: 95%),
    caption: [Archivo assets/marcadores.csv en Android Studio.]
  ),
  figure(
    image("../../img/propuestos/paso-2-1.png", width: 85%),
    caption: [Plano cargando marcadores desde el CSV.]
  ),
  figure(
    image("../../img/propuestos/paso-2-2.png", width: 85%),
    caption: [Diálogo informativo cargado dinámicamente.]
  )
)

=== Paso 3: Traslada el estado del plano y sus marcadores a un ViewModel (PlanoViewModel), siguiendo el patrón de ViewModel visto en el Laboratorio 05, en lugar de mantenerlo directamente en el Composable.

Siguiendo el patrón arquitectónico del Laboratorio 05, se incorporaron las dependencias de ciclo de vida en `libs.versions.toml` y `app/build.gradle.kts`:

```toml
lifecycleViewmodel = "2.11.0"
androidx-lifecycle-viewmodel-ktx = { group = "androidx.lifecycle", name = "lifecycle-viewmodel-ktx", version.ref = "lifecycleViewmodel" }
androidx-lifecycle-viewmodel-compose = { group = "androidx.lifecycle", name = "lifecycle-viewmodel-compose", version.ref = "lifecycleViewmodel" }
```

Se creó la clase `PlanoViewModel : AndroidViewModel(application)` dentro del paquete `viewmodel/`, centralizando el estado mutable fuera de la composición mediante propiedades observables con encapsulación (`private set`), y delegando la carga desde `assets/marcadores.csv` en su bloque `init`:

```kotlin
class PlanoViewModel(application: Application) : AndroidViewModel(application) {
    var marcadores by mutableStateOf<List<Marcador>>(emptyList())
        private set
    var marcadorSeleccionado by mutableStateOf<Marcador?>(null)
        private set

    init { marcadores = cargarMarcadores(application) }

    fun seleccionarMarcador(marcador: Marcador?) { marcadorSeleccionado = marcador }
    fun limpiarSeleccion() { marcadorSeleccionado = null }
}
```

En `MainActivity.kt`, se desacopló la UI mediante elevación de estado (_state hoisting_): `PlanoAmbiente` inyecta `PlanoViewModel = viewModel()` y delega el renderizado a un Composable puro `PlanoContenido` que recibe el estado y expone lambdas para los eventos, permitiendo previsualizaciones directas con `@Preview` sin depender de la instancia del ViewModel.

```kotlin
@Composable
fun PlanoAmbiente(viewModel: PlanoViewModel = viewModel()) {
    PlanoContenido(
        marcadores = viewModel.marcadores,
        marcadorSeleccionado = viewModel.marcadorSeleccionado,
        onMarcadorClick = { m -> viewModel.seleccionarMarcador(m) },
        onCerrar = { viewModel.limpiarSeleccion() }
    )
}
```

La compilación y validación se ejecutó exitosamente mediante `./gradlew :app:compileDebugKotlin`.

=== Paso 4: Integra este plano como una nueva pantalla accesible desde MapaScreen (Laboratorio 05) o desde una tarjeta del Laboratorio 06.

Se configuró el soporte de navegación y recursos iconográficos extendidos en `libs.versions.toml` y `app/build.gradle.kts`:

```toml
navigationCompose = "2.9.5"
androidx-navigation-compose = { group = "androidx.navigation", name = "navigation-compose", version.ref = "navigationCompose" }
androidx-compose-material-icons-extended = { group = "androidx.compose.material", name = "material-icons-extended" }
```

En `MainActivity.kt`, se definieron los destinos mediante una clase sellada `Pantalla` y se implementó el contenedor `NavHost` dentro del Composable raíz `PlanoApp`:

```kotlin
sealed class Pantalla(val route: String) {
    object Mapa : Pantalla("mapa")
    object Plano : Pantalla("plano")
}

@Composable
fun PlanoApp() {
    val navController = rememberNavController()
    NavHost(navController = navController, startDestination = Pantalla.Mapa.route) {
        composable(Pantalla.Mapa.route) {
            MapaScreen(onAbrirPlano = { navController.navigate(Pantalla.Plano.route) })
        }
        composable(Pantalla.Plano.route) {
            PlanoScreen(onVolver = { navController.popBackStack() })
        }
    }
}
```

Se diseñó la pantalla `MapaScreen` incorporando una tarjeta estilizada (`Card` con esquinas redondeadas de `20.dp`, ícono de ubicación y flecha indicadora, siguiendo el patrón de diseño de tarjetas del Laboratorio 06). Al pulsar sobre ella, se ejecuta la acción de navegación hacia `PlanoScreen`, la cual incluye una barra superior con botón de retorno (`popBackStack()`) y renderiza el plano interactivo administrado por el `PlanoViewModel`:

```kotlin
// Tarjeta interactiva en MapaScreen (estilo Laboratorio 06)
Card(
    modifier = Modifier.fillMaxWidth().clip(RoundedCornerShape(20.dp)).clickable(onClick = onAbrirPlano),
    colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.secondaryContainer)
) {
    Row(modifier = Modifier.fillMaxWidth().padding(16.dp), verticalAlignment = Alignment.CenterVertically) {
        Box(modifier = Modifier.size(48.dp).clip(CircleShape).background(MaterialTheme.colorScheme.primary), contentAlignment = Alignment.Center) {
            Icon(Icons.Default.Place, contentDescription = null, tint = MaterialTheme.colorScheme.onPrimary)
        }
        Column(modifier = Modifier.weight(1f).padding(horizontal = 16.dp)) {
            Text("Pabellón de Ingeniería", style = MaterialTheme.typography.titleMedium, fontWeight = FontWeight.Bold)
            Text("Plano interactivo con 6 ambientes del campus", style = MaterialTheme.typography.bodySmall)
        }
        Icon(Icons.AutoMirrored.Filled.ArrowForward, contentDescription = null)
    }
}
```

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: horizon + center,
  figure(
    image("../../img/propuestos/paso-4-1.png", width: 45%),
    caption: [Pantalla MapaScreen con la tarjeta del pabellón.]
  ),
  figure(
    image("../../img/propuestos/paso-4-2.png", width: 45%),
    caption: [Transición y visualización de PlanoScreen.]
  ),
  figure(
    image("../../img/propuestos/paso-4-3.png", width: 45%),
    caption: [Interacción táctil: Diálogo Aula A102.]
  ),
  figure(
    image("../../img/propuestos/paso-4-4.png", width: 45%),
    caption: [Interacción táctil: Diálogo Cafetería.]
  )
)

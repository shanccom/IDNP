
== - Propuesta 2

==== Paso 1: Cargar los edificios desde un archivo de texto plano

Se creó la carpeta `assets` en el módulo `app` y dentro el archivo `edificios.txt`. Luego se escribió la función `cargarEdificios()`, que abre el archivo, lo lee línea por línea, descarta las líneas vacías o mal formadas y convierte cada línea en un objeto `Edificio`. En `ListaEdificios` la lista ya no se escribe a mano: se obtiene con `remember { cargarEdificios(context) }`, de modo que el archivo se lee una sola vez y no en cada recomposición.

*Archivo edificios.txt:*

```text
1|Biblioteca Central|Servicios|Préstamo de libros y salas de estudio
2|Comedor Universitario|Servicios|Alimentación para estudiantes
3|Facultad de Ingeniería de Producción y Servicios|Académico|Aulas y laboratorios de ingeniería
4|Facultad de Ingeniería de Procesos|Académico|Laboratorios de química y procesos
5|Facultad de Ciencias Naturales y Formales|Académico|Aulas y laboratorios de ciencias
6|Coliseo Universitario|Deportes|Actividades deportivas y eventos
7|Auditorio Central|Eventos|Conferencias y ceremonias
8|Rectorado|Administrativo|Oficinas de gobierno universitario
9|Facultad de Derecho|Académico|Aulas y salas de práctica jurídica
```

*Código implementado:*

```kotlin
// Nuevo import
import android.content.Context
import androidx.compose.ui.platform.LocalContext

// Lee assets/edificios.txt (formato: id|nombre|categoria|descripcion)
fun cargarEdificios(context: Context): List<Edificio> =
    context.assets.open("edificios.txt").bufferedReader().useLines { lineas ->
        lineas
            .filter { it.isNotBlank() }
            .map { it.split("|") }
            .filter { it.size == 4 }
            .mapNotNull { p ->
                p[0].trim().toIntOrNull()?.let { id ->
                    Edificio(id, p[1].trim(), p[2].trim(), p[3].trim())
                }
            }
            .toList()
    }

// En ListaEdificios: se reemplaza la lista escrita en el código
val context = LocalContext.current
val edificios = remember { cargarEdificios(context) }
```

  #figure(
    image("../../../img/propuesta2/image.png", width: 65%),
    caption: [Paso 1 (b): lista completa cargada desde el archivo.]
  ),


==== Paso 2: Agregar un ícono a `FilaEdificio`

Se agregó la dependencia `material-icons-extended` para disponer de más íconos y se creó la función `iconoPorCategoria()`, que devuelve un ImageVector distinto según la categoría. En FilaEdificio la Column de textos pasó a estar dentro de un Row: a la izquierda se dibuja el ícono sobre un círculo de color y a la derecha los tres textos de siempre.

*Código agregado ( en el archivo build.gradle.kts, luego Sync Now):*

```kotlin
implementation("androidx.compose.material:material-icons-extended")
```

*Código agregado :*

```kotlin
// Función nueva: ícono según la categoría
fun iconoPorCategoria(categoria: String): ImageVector = when (categoria) {
    "Servicios" -> Icons.Default.LocalLibrary
    "Académico" -> Icons.Default.School
    "Deportes" -> Icons.Default.SportsSoccer
    "Eventos" -> Icons.Default.Event
    "Administrativo" -> Icons.Default.Business
    else -> Icons.Default.Place
}

// FilaEdificio: el ícono va a la izquierda, los textos a la derecha
Row(
    modifier = Modifier.padding(12.dp),
    verticalAlignment = Alignment.CenterVertically
) {
    Box(
        modifier = Modifier
            .size(48.dp)
            .clip(CircleShape)
            .background(MaterialTheme.colorScheme.primaryContainer),
        contentAlignment = Alignment.Center
    ) {
        Icon(
            imageVector = iconoPorCategoria(edificio.categoria),
            contentDescription = edificio.categoria,
            tint = MaterialTheme.colorScheme.primary
        )
    }
    Spacer(modifier = Modifier.width(12.dp))
    Column { /* nombre, categoría y descripción, igual que antes */ }
}
```

#figure(
    image("../../../img/propuesta2/image02.png", width: 30%),
    caption: [Paso 2 (a): cada edificio muestra el ícono de su categoría.]
  ),


==== Paso 3: Filtrar también por categoría con un menú desplegable

Se agregó un segundo criterio de filtro. La lista de categorías no se escribe a mano: se obtiene del propio archivo con `map { it.categoria }.distinct()` y se le antepone la opción «Todas». Se añadieron dos estados nuevos: `categoria` (la elegida) y `menuAbierto` (si el menú está desplegado).

*Código agregado (`MainActivity.kt`):*

```kotlin
// En ListaEdificios: estados nuevos
val categorias = remember(edificios) {
    listOf("Todas") + edificios.map { it.categoria }.distinct()
}
var categoria by remember { mutableStateOf("Todas") }
var menuAbierto by remember { mutableStateOf(false) }

// Menú desplegable, debajo del campo de búsqueda
Box {
    OutlinedButton(
        onClick = { menuAbierto = true },
        modifier = Modifier.fillMaxWidth()
    ) {
        Text("Categoría: $categoria")
    }
    DropdownMenu(
        expanded = menuAbierto,
        onDismissRequest = { menuAbierto = false }
    ) {
        categorias.forEach { c ->
            DropdownMenuItem(
                text = { Text(c) },
                onClick = {
                    categoria = c
                    menuAbierto = false
                }
            )
        }
    }
}

// Filtro combinado: nombre Y categoría
val edificiosFiltrados = edificios.filter {
    it.nombre.contains(texto, ignoreCase = true) &&
        (categoria == "Todas" || it.categoria == categoria)
}
```

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  figure(
    image("../../../img/propuesta2/image03.png", width: 75%),
    caption: [Paso 3 (a): menú desplegable con las categorías.]
  ),
  figure(
    image("../../../img/propuesta2/image04.png", width: 75%),
    caption: [Paso 3 (b): lista filtrada por la categoría «Académico».]
  ),
  figure(
    image("../../../img/propuesta2/image05.png", width: 75%),
    caption: [Paso 3 (c): filtro combinado: categoría «Académico» y texto «ingeniería».]
  )
)


==== Paso 4 (reto opcional): Integrar la lista como reemplazo de `EdificiosScreen`

La lista filtrable se integró en el proyecto del Laboratorio 05, que ya tiene la barra de navegación con cuatro pestañas y el `SeleccionViewModel` compartido. Para ello se copió `edificios.txt` a la carpeta `assets` de ese proyecto y se agregó la dependencia `material-icons-extended`. Los cambios fueron los siguientes:
- La data class `Edificio` pasó a tener cuatro campos (`id`, `nombre`, `categoria` y `descripcion`) y se añadieron `cargarEdificios()` e `iconoPorCategoria()`.
- `EdificiosScreen` ahora contiene el campo de búsqueda, el menú de categoría, un contador de resultados y la `LazyColumn` con una `key` estable.
- Cada fila usa `TarjetaCompacta`: ícono, nombre, categoría con descripción y el botón «Ver». Como se sigue usando el ViewModel, el botón llama a `viewModel.seleccionarEdificio()` y la tarjeta elegida se resalta. Como no se dispone del código del Laboratorio 06, esta tarjeta se definió en el mismo archivo.
- En `HomeScreen`, el total de edificios ya no es el número fijo «4», sino el tamaño de la lista leída del archivo.
- En `MapaScreen`, los pines se actualizaron con nombres que existen en el archivo.

El resto del código (`SeleccionViewModel`, navegación, Home, Perfil y tema) no se modificó.

*Código agregado (`MainActivity.kt`):*

```kotlin
// Data class ampliada (reemplaza a Edificio(nombre, descripcion))
data class Edificio(
    val id: Int,
    val nombre: String,
    val categoria: String,
    val descripcion: String
)

// cargarEdificios() e iconoPorCategoria(): iguales a los de los pasos 1 y 2

// HomeScreen: el total sale del archivo
val context = LocalContext.current
val totalEdificios = remember { cargarEdificios(context).size }
InfoCard(totalEdificios.toString(), "Edificios", Modifier.weight(1f))

// EdificiosScreen: lista filtrable (búsqueda + categoría) con ViewModel
@Composable
fun EdificiosScreen(viewModel: SeleccionViewModel) {
    val context = LocalContext.current
    val edificios = remember { cargarEdificios(context) }
    var texto by remember { mutableStateOf("") }
    var categoria by remember { mutableStateOf("Todas") }
    // ... campo de búsqueda y menú desplegable, igual que en el Paso 3

    val edificiosFiltrados = edificios.filter {
        it.nombre.contains(texto, ignoreCase = true) &&
            (categoria == "Todas" || it.categoria == categoria)
    }

    LazyColumn(modifier = Modifier.weight(1f)) {
        items(edificiosFiltrados, key = { it.id }) { edificio ->
            TarjetaCompacta(edificio = edificio, viewModel = viewModel)
        }
    }
}

// Cada fila: la selección se escribe directamente en el ViewModel
@Composable
fun TarjetaCompacta(edificio: Edificio, viewModel: SeleccionViewModel) {
    val seleccionado = viewModel.edificioSeleccionado == edificio.nombre
    // Card resaltada si está seleccionada: ícono + textos + botón
    Button(onClick = { viewModel.seleccionarEdificio(edificio.nombre) }) {
        Text("Ver")
    }
}

// MapaScreen: pines con nombres presentes en el archivo
PinMapa("Biblioteca Central", Modifier.align(BiasAlignment(-0.55f, -0.6f)))
PinMapa("Coliseo Universitario", Modifier.align(BiasAlignment(0.55f, -0.5f)))
PinMapa("Rectorado", Modifier.align(BiasAlignment(-0.55f, 0.55f)))
PinMapa("Auditorio Central", Modifier.align(BiasAlignment(0.6f, 0.6f)))
```

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1.5em,
  align: horizon + center,
  figure(
    image("../../../img/propuesta2/image06.png", width: 60%),
    caption: [Paso 4 (a): pestaña Home con el total de edificios leído del archivo.]
  ),
  figure(
    image("../../../img/propuesta2/image07.png", width: 60%),
    caption: [Paso 4 (b): pestaña Edificios con la lista filtrable y tarjetas compactas.]
  ),
  figure(
    image("../../../img/propuesta2/image08.png", width: 60%),
    caption: [Paso 4 (c): filtro combinado por categoría y por nombre.]
  ),
)


#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 1.5em,
  align: horizon + center,
  figure(
    image("../../../img/propuesta2/image09.png", width: 60%),
    caption: [Paso 4 (d): tras pulsar «Ver», la tarjeta queda resaltada (ViewModel compartido).]
  ),
  figure(
    image("../../../img/propuesta2/image10.png", width: 60%),
    caption: [Paso 4 (e): Home muestra el edificio elegido en «Último edificio consultado».]
  ),
  figure(
    image("../../../img/propuesta2/image11.png", width: 60%),
    caption: [Paso 4 (f): pestaña Mapa con pines de edificios del archivo.]
  )
)

= Ejercicio Propuesto: Ampliación de la Lista de Edificaciones Históricas del Campus

== Enunciado

Amplía el ejercicio resuelto para mostrar la lista completa de edificaciones históricas del campus:
+ *Persistencia:* Reemplaza la lista de muestra por al menos 8 edificios reales del campus, cargados desde un archivo de texto plano (similar al patrón del Laboratorio 03) en lugar de estar escritos directamente en el código.
+ *Identidad visual:* Agrega a `FilaEdificio` un ícono o imagen representativa (puede ser un `Icon` de Material Icons).
+ *Filtro avanzado:* Permite elegir el criterio de filtro agregando un segundo campo o menú desplegable para filtrar por categoría además de por nombre.
+ *(Reto opcional) Integración:* Integra esta lista filtrable como reemplazo de `EdificiosScreen` (Laboratorio 05/06), combinándola con las tarjetas `TarjetaLugar` o `TarjetaCompacta` del Laboratorio 06 dentro de cada fila.

== Desarrollo Paso a Paso
=== - Propuesta 1

=== Paso 1. Carga de Edificaciones Reales desde Archivo de Texto Plano (Persistencia)

Para desacoplar los datos de la interfaz gráfica y asegurar persistencia configurable, se sustituyó la lista estática en memoria por una lectura dinámica desde almacenamiento interno, replicando el patrón implementado en el Laboratorio 03. Se creó el archivo `app/src/main/assets/edificios.txt` con 12 edificaciones reales del campus de la UNSA (Rectorado, Biblioteca Central, Aula Magna, facultades, comedor universitario, coliseo, complejo deportivo y centro de cómputo), organizadas por líneas en formato `id,nombre,categoria,descripcion`, omitiendo automáticamente comentarios con `#` y líneas en blanco.

#text(size: 6.8pt)[
```text
# Formato: id,nombre,categoria,descripcion
1,Rectorado UNSA,Administrativo,Sede administrativa y despacho de las autoridades universitarias
2,Biblioteca Central UNSA,Servicios,Préstamo de libros y salas de estudio para estudiantes
3,Aula Magna UNSA,Eventos,Conferencias y ceremonias académicas de la universidad
4,Facultad de Ingeniería de Sistemas,Académico,Aulas y laboratorios de computación e informática
5,Facultad de Ingeniería de Producción y Servicios,Académico,Aulas y laboratorios de ingeniería
6,Facultad de Medicina UNSA,Académico,Aulas y laboratorios de ciencias de la salud
7,Facultad de Ciencias Económicas,Académico,Aulas y oficinas de las escuelas de economía
8,Comedor Universitario UNSA,Servicios,Alimentación para estudiantes y personal universitario
9,Coliseo Universitario UNSA,Deportes,Actividades deportivas y eventos masivos
10,Complejo Deportivo UNSA,Deportes,Canchas y espacios para la práctica del deporte
11,Centro de Cómputo UNSA,Servicios,Salas de cómputo y soporte informático
12,Facultad de Arquitectura y Urbanismo,Académico,Talleres de diseño y aulas de arquitectura
```
]

En `MainActivity.kt` se eliminó la lista cableada y se incorporó la función `parsearEdificios(contenido)`, encargada de transformar el texto plano en una colección `List<Edificio>`. La función `cargarEdificios(context)` gestiona el ciclo de vida del archivo copiándolo desde `assets` hacia el almacenamiento interno (`filesDir`) durante el primer arranque y consumiéndolo posteriormente mediante `openFileInput("edificios.txt").bufferedReader()`. Finalmente, el composable `ListaEdificios` recupera los datos mediante `LocalContext.current` y delega la renderización a `ListaEdificiosContenido(edificios)`.

#text(size: 6.8pt)[
```kotlin
fun parsearEdificios(contenido: String): List<Edificio> = contenido.lineSequence()
    .map { it.trim() }
    .filter { it.isNotEmpty() && !it.startsWith("#") }
    .mapNotNull { linea ->
        val partes = linea.split(",")
        if (partes.size >= 4) {
            Edificio(partes[0].trim().toIntOrNull() ?: 0, partes[1].trim(), partes[2].trim(), partes.drop(3).joinToString(",").trim())
        } else null
    }.toList()

fun cargarEdificios(context: Context): List<Edificio> {
    val archivo = File(context.filesDir, "edificios.txt")
    if (!archivo.exists()) {
        context.assets.open("edificios.txt").use { entrada ->
            archivo.outputStream().use { salida -> entrada.copyTo(salida) }
        }
    }
    return parsearEdificios(context.openFileInput("edificios.txt").bufferedReader().use { it.readText() })
}
```
]

#figure(
  image("../../img/propuestos/resultado-1.png", width: 85%),
  caption: [Paso 1: Archivo edificios.txt empaquetado en assets y lectura de los 12 registros en el emulador.]
)

=== Paso 2. Incorporación de Ícono Representativo en `FilaEdificio`

Con el propósito de reforzar la jerarquía visual y facilitar la rápida identificación de las edificaciones, se incorporaron íconos vectoriales temáticos de `Material Icons`. Se estructuró la clase auxiliar `EstiloCategoria` con las propiedades `icono`, `colorFondo` y `colorIcono`, junto con la función `estiloCategoria(categoria)` que evalúa el texto y asigna dinámicamente vectores alusivos: `School` para Académico, `Restaurant` para Servicios, `SportsSoccer` para Deportes, `Event` para Eventos, `Business` para Administrativo y `Place` por defecto.

A nivel de interfaz, `FilaEdificio` se rediseñó sobre una disposición horizontal (`Row`) dentro de un contenedor `Card`. En la sección izquierda se despliega una insignia circular de `48.dp` (`clip(CircleShape)`) con el fondo tonal y el ícono vectorial correspondiente, mientras que a la derecha se organizan en columna el nombre del edificio en negrita, la categoría y la descripción detallada, asignando `Modifier.weight(1f)` para aprovechar fluidamente todo el ancho disponible.

#text(size: 6.8pt)[
```kotlin
private data class EstiloCategoria(val icono: ImageVector, val colorFondo: Color, val colorIcono: Color)

private fun estiloCategoria(categoria: String): EstiloCategoria = when (categoria.lowercase()) {
    "académico", "academico" -> EstiloCategoria(Icons.Default.School, Color(0xFFE3F2FD), Color(0xFF1565C0))
    "servicios" -> EstiloCategoria(Icons.Default.Restaurant, Color(0xFFFFF3E0), Color(0xFFEF6C00))
    "deportes" -> EstiloCategoria(Icons.Default.SportsSoccer, Color(0xFFE8F5E9), Color(0xFF2E7D32))
    "eventos" -> EstiloCategoria(Icons.Default.Event, Color(0xFFF3E5F5), Color(0xFF6A1B9A))
    "administrativo" -> EstiloCategoria(Icons.Default.Business, Color(0xFFECEFF1), Color(0xFF37474F))
    else -> EstiloCategoria(Icons.Default.Place, Color(0xFFF5F5F5), Color.Gray)
}

@Composable
fun FilaEdificio(edificio: Edificio) {
    val estilo = estiloCategoria(edificio.categoria)
    Card(
        modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp),
        colors = CardDefaults.cardColors(containerColor = Color(0xFFF0F2F5))
    ) {
        Row(modifier = Modifier.fillMaxWidth().padding(12.dp), verticalAlignment = Alignment.CenterVertically) {
            Box(
                modifier = Modifier.size(48.dp).clip(CircleShape).background(estilo.colorFondo),
                contentAlignment = Alignment.Center
            ) {
                Icon(estilo.icono, contentDescription = edificio.categoria, tint = estilo.colorIcono, modifier = Modifier.size(24.dp))
            }
            Spacer(modifier = Modifier.width(12.dp))
            Column(modifier = Modifier.weight(1f)) {
                Text(edificio.nombre, fontWeight = FontWeight.Bold, fontSize = 16.sp, color = Color.Black)
                Text(edificio.categoria, fontSize = 13.sp, fontWeight = FontWeight.SemiBold, color = estilo.colorIcono)
                Spacer(modifier = Modifier.height(2.dp))
                Text(edificio.descripcion, fontSize = 12.sp, color = Color.DarkGray)
            }
        }
    }
}
```
]

#figure(
  image("../../img/propuestos/resultado-2.png", width: 85%),
  caption: [Paso 2: Insignias circulares temáticas de Material Icons integradas en FilaEdificio.]
)

=== Paso 3. Criterio de Filtro Dual (por Nombre y Menú Desplegable por Categoría)

El sistema de búsqueda se expandió mediante un filtrado reactivo simultáneo que combina la entrada de texto con la selección de categorías mediante un menú desplegable `ExposedDropdownMenuBox`. Dentro de `ListaEdificiosContenido` se definen dos estados mutables: `texto` para el término buscado y `categoriaSeleccionada`, inicializado con la constante `TODAS_LAS_CATEGORIAS = "Todas"`. Las opciones del menú se obtienen dinámicamente desde los registros mediante `remember(edificios)`, asegurando que cualquier categoría añadida a futuro en `edificios.txt` se refleje de inmediato sin modificar el código fuente.

La lógica de filtrado se centralizó en la función `filtrarEdificios`, evaluando la conjunción lógica (`&&`) de dos condiciones: `coincideNombre` valida que el nombre contenga la subcadena ingresada (o admite todos si el campo está vacío) y `coincideCategoria` verifica coincidencia exacta o valida todas ante la opción `"Todas"`. En la interfaz, ambos componentes se ubican en una misma fila horizontal con `Arrangement.spacedBy(8.dp)`, incorporando mejoras de identidad visual como un fondo cálido institucional (`#F7F4EE`), tarjetas blancas con esquinas de 14dp, acento verde en campos enfocados y scroll optimizado en `LazyColumn`.

#text(size: 6.8pt)[
```kotlin
private const val TODAS_LAS_CATEGORIAS = "Todas"

fun filtrarEdificios(edificios: List<Edificio>, nombre: String, categoria: String): List<Edificio> {
    val buscado = nombre.trim()
    return edificios.filter { ed ->
        val coincideNombre = buscado.isEmpty() || ed.nombre.contains(buscado, ignoreCase = true)
        val coincideCategoria = (categoria == TODAS_LAS_CATEGORIAS) || ed.categoria.equals(categoria, ignoreCase = true)
        coincideNombre && coincideCategoria
    }
}

// En ListaEdificiosContenido:
var texto by remember { mutableStateOf("") }
var categoriaSeleccionada by remember { mutableStateOf(TODAS_LAS_CATEGORIAS) }
val categorias = remember(edificios) { listOf(TODAS_LAS_CATEGORIAS) + edificios.map { it.categoria }.distinct().sorted() }
val listaFiltrada = remember(texto, categoriaSeleccionada, edificios) { filtrarEdificios(edificios, texto, categoriaSeleccionada) }

Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(8.dp)) {
    OutlinedTextField(value = texto, onValueChange = { texto = it }, label = { Text("Nombre") }, modifier = Modifier.weight(1f))
    FiltroCategoria(categorias = categorias, seleccionada = categoriaSeleccionada, onSeleccionar = { categoriaSeleccionada = it }, modifier = Modifier.weight(1f))
}
```
]

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: horizon + center,
  figure(
    image("../../img/propuestos/resuelto-3.1.png", width: 68%),
    caption: [Filtro inicial "Todas" sobre fondo cálido `\#F7F4EE` y tarjetas de 14dp.]
  ),
  figure(
    image("../../img/propuestos/resuelto-3.2.png", width: 68%),
    caption: [Filtrado por categoría "Académico" acotado a las facultades.]
  ),
  figure(
    image("../../img/propuestos/resuelto-3.3.png", width: 68%),
    caption: [Filtro dual interactivo: búsqueda "sistemas" dentro de "Académico".]
  ),
  figure(
    image("../../img/propuestos/resuelto-3.4.png", width: 68%),
    caption: [Filtrado dinámico específico para la categoría "Biblioteca".]
  )
)

=== Paso 4. (Reto Opcional) Integración con el Patrón de TarjetaLugar del Laboratorio 06

Para resolver el reto opcional, se integró el lenguaje visual desarrollado en el Laboratorio 06 sustituyendo el diseño base de fila por una versión adaptada de `TarjetaLugar`. La tarjeta se implementa sobre un `Surface` con esquinas redondeadas de 16dp, elevación controlada y un contenedor frontal de `52.dp` que resalta el ícono representativo de la categoría. A su lado, una columna organiza el nombre del edificio, su descripción y una etiqueta inferior en forma de chip que expone la categoría temática en lugar del dato de distancia del laboratorio anterior.

Esta pantalla adaptada preserva de forma transparente todo el motor de filtrado por texto y categoría, permitiendo que `EdificiosScreenIntegrada` actúe como un reemplazo directo y enriquecido de las pantallas de navegación previas sin perder el rendimiento del reciclaje de vistas provisto por `LazyColumn`.

#text(size: 6.8pt)[
```kotlin
@Composable
fun TarjetaLugar(edificio: Edificio, onClick: () -> Unit = {}) {
    val estilo = estiloCategoria(edificio.categoria)
    Surface(
        modifier = Modifier.fillMaxWidth().clickable(onClick = onClick),
        shape = RoundedCornerShape(16.dp),
        color = Color.White,
        border = BorderStroke(1.dp, Color(0xFFE2E8F0)),
        shadowElevation = 1.dp
    ) {
        Row(modifier = Modifier.padding(10.dp), verticalAlignment = Alignment.CenterVertically) {
            Box(
                modifier = Modifier.size(52.dp).clip(RoundedCornerShape(14.dp)).background(estilo.colorFondo),
                contentAlignment = Alignment.Center
            ) {
                Icon(estilo.icono, contentDescription = edificio.categoria, tint = estilo.colorIcono, modifier = Modifier.size(28.dp))
            }
            Spacer(modifier = Modifier.width(12.dp))
            Column(modifier = Modifier.weight(1f)) {
                Text(edificio.nombre, fontWeight = FontWeight.Bold, fontSize = 15.sp, color = Color.Black)
                Text(edificio.descripcion, fontSize = 12.sp, color = Color.DarkGray, maxLines = 2)
                Spacer(modifier = Modifier.height(4.dp))
                Surface(shape = RoundedCornerShape(6.dp), color = estilo.colorIcono.copy(alpha = 0.12f)) {
                    Text(edificio.categoria, fontSize = 11.sp, fontWeight = FontWeight.SemiBold, color = estilo.colorIcono, modifier = Modifier.padding(horizontal = 8.dp, vertical = 2.dp))
                }
            }
        }
    }
}
```
]

#grid(
  figure(
    image("../../img/propuestos/resuelto-4.1.png", width: 70%),
    caption: [Integración de TarjetaLugar con insignias de categoría.]
  ),
  figure(
    image("../../img/propuestos/resuelto-4.2.png", width: 70%),
    caption: [Filtrado combinado interactivo sobre TarjetaLugar.]
  ),
  figure(
    image("../../img/propuestos/resuelto-4.3.png", width: 70%),
    caption: [Desplazamiento fluido y consistencia gráfica en LazyColumn.]
  )
)

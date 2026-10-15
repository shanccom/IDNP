#let mostrar-imagenes = true
#set heading(numbering: none)
#show heading.where(level: 1): it => [#v(8pt) #it #v(2pt)]

// Bloque de codigo con fondo gris y letra pequena
#let codigo(body) = block(
  fill: luma(246), stroke: 0.5pt + luma(200),
  inset: 6pt, radius: 3pt, width: 100%,
  text(size: 6.5pt, body),
)

// Captura: si mostrar-imagenes es false, dibuja un recuadro de reserva
#let captura(archivo, leyenda, ancho: 70%, alto: 6cm) = figure(
  if mostrar-imagenes {
    image(archivo, width: ancho)
  } else {
    rect(width: ancho, height: alto, stroke: (dash: "dashed"))[
      #align(center + horizon)[Captura pendiente:\ #raw(archivo)]
    ]
  },
  caption: leyenda,
)

= Propuesta 2

=== Paso 1: Amplía la lista de marcadores y agrega los rectángulos/líneas necesarios para representar al menos 4 ambientes (salones y/o patios) de una edificación real del campus, cada uno con su etiqueta visible en el plano.

#pad(left: 1.1em)[

Se representa el interior de una edificación con 5 ambientes: Laboratorio 1, Laboratorio 2, Aula 301, Sala de Docentes y Patio Central.

- Se agrega la data class `Ambiente` (posición, tamaño, color y etiqueta) para dibujar los rectángulos. `Marcador` se mantiene igual.
- El `Canvas` usa `aspectRatio` en lugar de una altura fija, para conservar las proporciones del plano.
- Las etiquetas se dibujan con `drawText` y un `TextMeasurer` (`rememberTextMeasurer()`).
- Se dibuja el contorno del edificio con `Stroke` y las paredes internas con `drawLine`.


#block[
```kotlin
data class Ambiente(
    val topLeft: Offset,
    val size: Size,
    val color: Color,
    val etiqueta: String
)

@Composable
fun PlanoAmbiente() {
    val ambientes = remember {
        listOf(
            Ambiente(Offset(10f, 10f), Size(170f, 150f), Color(0xFFBBDEFB), "Laboratorio 1"),
            Ambiente(Offset(180f, 10f), Size(170f, 150f), Color(0xFFC8E6C9), "Laboratorio 2"),
            Ambiente(Offset(10f, 160f), Size(170f, 120f), Color(0xFFFFE0B2), "Aula 301"),
            Ambiente(Offset(180f, 160f), Size(170f, 120f), Color(0xFFE1BEE7), "Sala de Docentes"),
            Ambiente(Offset(10f, 280f), Size(340f, 110f), Color(0xFFFFF9C4), "Patio Central")
        )
    }
    val marcadores = remember {
        listOf(
            Marcador(Offset(95f, 85f), 16f, "Laboratorio 1", ""),
            Marcador(Offset(265f, 85f), 16f, "Laboratorio 2", ""),
            Marcador(Offset(95f, 220f), 16f, "Aula 301", ""),
            Marcador(Offset(265f, 220f), 16f, "Sala de Docentes", ""),
            Marcador(Offset(180f, 335f), 16f, "Patio Central", "")
        )
    }

    ...

        // Ambientes con su etiqueta
        ambientes.forEach { ambiente ->
            drawRect(
                color = ambiente.color,
                topLeft = ambiente.topLeft * escala,
                size = ambiente.size * escala
            )
            drawText(
                textMeasurer = medidorTexto,
                text = ambiente.etiqueta,
                topLeft = ambiente.topLeft * escala + Offset(10f, 8f),
                style = TextStyle(fontSize = 12.sp, color = Color.Black)
            )
        }
    }
```
]
=== Resultado 

Se ven los 5 ambientes con color propio, su etiqueta, el contorno y las paredes internas, y un círculo rojo en cada uno. Al tocar un círculo se abre el `AlertDialog` con el título y la descripción. Todo está todavía escrito en el código; eso se corrige en el Paso 2.

A continuación se muestran las capturas mostrando la vista general del plano interactivo y el comportamiento del diálogo flotante al seleccionar cada marcador:
#grid(
columns: (1fr, 1fr),
gutter: 10pt,
captura("../../../img/propuesta2/prop-5labs.png", [Plano general con 5 ambientes y marcadores visibles], ancho: 60%, alto: 6.5cm),
captura("../../../img/propuesta2/prop-1lab.png", [Marcador de Laboratorio 1 presionado], ancho: 60%, alto: 6.5cm),
captura("../../../img/propuesta2/prop-2lab.png", [Marcador de Laboratorio 2 presionado], ancho: 60%, alto: 6.5cm),
captura("../../../img/propuesta2/prop-aula.png", [Marcador de Aula 301 presionado], ancho: 60%, alto: 6.5cm),
captura("../../../img/propuesta2/prop-docente.png", [Marcador de Sala de Docentes presionado], ancho: 60%, alto: 6.5cm),
captura("../../../img/propuesta2/prop-patio.png", [Marcador de Patio Central presionado], ancho: 60%, alto: 6.5cm),
)

]

=== Paso 2:  Convierte la lista de marcadores en datos cargados desde un archivo (por ejemplo un .json o .csv en assets/) en lugar de estar escritos directamente en el código, siguiendo un patrón de persistencia similar al usado en el Laboratorio 03.

#pad(left: 1.1em)[

Las listas de ambientes y marcadores dejan de estar en el código y se leen de `assets/ambientes.json`. Es el mismo patrón del Laboratorio 03 (datos en un archivo, leídos al abrir la pantalla), pero con lectura de solo lectura desde `assets/` en lugar de `openFileOutput`.

+ Se creo la carpeta assets:
+ Se creo el archivo `ambientes.json` dentro de esa carpeta con el contenido de abajo.
+ Para leer el archivo se utilizaq la función `cargarPlano(context)` abre el archivo con `context.assets.open(...)`, lo convierte a texto y lo interpreta con `org.json.JSONObject`.
+ En el Composable, el `Context` se obtiene con `LocalContext.current` y se carga una sola vez con `remember`.

=== Archivo `app/src/main/assets/ambientes.json`

#captura("../../../img/propuesta2/p2_json.png", [Carpeta assets y archivo ambientes.json en el proyecto], ancho: 95%)

=== Código implementado en `MainActivity.kt` 
#block[
```kotlin
fun cargarPlano(context: Context): PlanoData {
    return try {
        val texto = context.assets.open("ambientes.json")
            .bufferedReader()
            .use { it.readText() }
        val raiz = JSONObject(texto)

        val arrayAmbientes = raiz.getJSONArray("ambientes")
        val ambientes = List(arrayAmbientes.length()) { i ->
            val o = arrayAmbientes.getJSONObject(i)
            Ambiente(
                topLeft = Offset(o.getDouble("x").toFloat(), o.getDouble("y").toFloat()),
                size = Size(o.getDouble("ancho").toFloat(), o.getDouble("alto").toFloat()),
                color = Color(android.graphics.Color.parseColor(o.getString("color"))),
                etiqueta = o.getString("etiqueta")
            )
        }

        val arrayMarcadores = raiz.getJSONArray("marcadores")
        val marcadores = List(arrayMarcadores.length()) { i ->
            val o = arrayMarcadores.getJSONObject(i)
            Marcador(
                offset = Offset(o.getDouble("x").toFloat(), o.getDouble("y").toFloat()),
                radio = o.getDouble("radio").toFloat(),
                titulo = o.getString("titulo"),
                descripcion = o.getString("descripcion")
            )
        }

        PlanoData(ambientes, marcadores)
    } catch (e: Exception) {
        // NO existe el archivo u otro error
        e.printStackTrace()
        PlanoData(emptyList(), emptyList())
    }
}

```
]

=== Resultado y Verificación de Persistencia

Para comprobar que la interfaz lee dinámicamente el archivo `ambientes.json` sin depender de datos fijos en el código Kotlin, se realizaron dos pruebas consecutivas:

1. *Lectura inicial (sin cambios):* La aplicación carga la estructura por defecto definida en el archivo de recursos y renderiza el plano correctamente.
2. *Modificación del JSON:* Se editaron los valores en `ambientes.json` (modificando etiquetas, colores de ambiente o descripciones de los marcadores). Al reiniciar la ejecución, la interfaz reflejó automáticamente los nuevos cambios en el emulador.

  
  #captura("../../../img/propuesta2/p2-sincambio.png", [Plano cargado inicialmente desde el archivo JSON], ancho: 100%, alto: 6.5cm),
  #captura("../../../img/propuesta2/p2-concambio.png", [Plano tras modificar los datos en ambientes.json], ancho: 100%, alto: 6.5cm),


]
=== Paso 3: . Traslada el estado del plano y sus marcadores a un ViewModel (PlanoViewModel), siguiendo el patrón de ViewModel visto en el Laboratorio 05, en lugar de mantenerlo directamente en el Composable.

#pad(left: 1.1em)[

La lista de ambientes, la lista de marcadores y el marcador seleccionado dejan de vivir en el Composable y pasan a un `PlanoViewModel`, siguiendo el patrón del Laboratorio 05 (`SeleccionViewModel`).

En `build.gradle.kts` dentro de `dependencies { }`, se agrego y se sincronizo:

#block[
```kotlin
implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.8.0")
```
]

- `PlanoViewModel` extiende `AndroidViewModel` porque necesita el `Application` para leer el archivo de `assets/`. Carga el plano una sola vez, en su inicialización.
- `marcadorSeleccionado` es un `mutableStateOf` con `private set`: la interfaz puede leerlo, pero solo el ViewModel puede modificarlo (mediante `onToque` y `cerrarDialogo`).
- `PlanoAmbiente` obtiene el ViewModel con `viewModel()`. Como el estado vive en el ViewModel, sobrevive a rotaciones de pantalla.
- Se retira la `@Preview` porque un `AndroidViewModel` no se puede crear en la vista previa de Android Studio.

=== Código implementado en `MainActivity.kt`
#captura("../../../img/propuesta2/p3_codigo.png", [Clase `PlanoViewModel` en Android Studio], ancho: 85%)

=== Resultado 

El comportamiento visual es el mismo de los pasos anteriores, pero ahora el Composable no guarda ningún dato: lee todo del ViewModel. 



]
=== Paso 4: Integra este plano como una nueva pantalla accesible desde MapaScreen (Laboratorio 05) o desde una tarjeta del Laboratorio 06.


#pad(left: 1.1em)[

Se reproduce la estructura del Laboratorio 05 con las pantallas Home y Mapa, y una tercera ruta `plano` a la que se llega desde un botón de `MapaScreen`.
Para realizar esto se necesita dependencias necesarias para la navegación y los íconos extendidos de Compose. Para esto en `build.gradle.kts` (Module :app), agregar y sincronizar:

#block[
```kotlin
implementation("androidx.navigation:navigation-compose:2.8.0")
implementation("androidx.compose.material:material-icons-extended")
```
]

- Screen es la sealed class del Laboratorio 05. Se agrega el objeto Plano (ruta "plano"), que no aparece en la barra inferior: solo se llega a él desde MapaScreen.
- MapaScreen recibe la lambda onVerPlano y la ejecuta al pulsar el botón; el NavHost decide qué hacer (navController.navigate("plano")), igual que el patrón por lambda del Laboratorio 05.
- PlanoScreen envuelve a PlanoAmbiente con una barra superior sencilla (IconButton con flecha) cuya lambda onVolver llama a navController.popBackStack().
- Mientras se está en el plano, la pestaña *Mapa* permanece resaltada, porque el plano es una sub-pantalla del mapa.
- MainActivity ahora muestra MainScreen() en lugar de PlanoAmbiente() directamente.

=== Código implementado de `MainActivity.kt`

#block[
```kotlin

@Composable
fun MainScreen() {
    val navController = rememberNavController()
    val items = listOf(Screen.Home, Screen.Mapa)
    val entradaActual by navController.currentBackStackEntryAsState()
    val rutaActual = entradaActual?.destination?.route

    Scaffold(
        bottomBar = {
            NavigationBar {
                items.forEach { screen ->
                    val icono = if (screen == Screen.Home) Icons.Default.Home else Icons.Default.Place
                    NavigationBarItem(
                        selected = rutaActual == screen.route ||
                                (screen == Screen.Mapa && rutaActual == Screen.Plano.route),
                        onClick = { navController.navigate(screen.route) },
                        icon = { Icon(icono, contentDescription = screen.label) },
                        label = { Text(screen.label) }
                    )
                }
            }
        }
    ) { padding ->
        NavHost(
            navController = navController,
            startDestination = Screen.Home.route,
            modifier = Modifier.padding(padding)
        ) {
            composable(Screen.Home.route) {
                HomeScreen()
            }
            composable(Screen.Mapa.route) {
                MapaScreen(onVerPlano = { navController.navigate(Screen.Plano.route) })
            }
            composable(Screen.Plano.route) {
                PlanoScreen(onVolver = { navController.popBackStack() })
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            PlanoInteractivo_ComposeTheme {
                MainScreen()
            }
        }
    }
}


```
]

=== Resultado 

Al abrir la app se ve Home. Desde la pestaña Mapa se pulsa el botón y se abre el plano; la flecha vuelve a Mapa. La barra inferior mantiene el resaltado correcto en todo momento.

#captura("../../../img/propuesta2/p4_gradle.png", [Dependencias de navegación e íconos agregadas], ancho: 85%, alto: 4cm)
#grid(
  columns: (1fr, 1fr, 1fr), gutter: 8pt,
  
  captura("../../../img/propuesta2/p4_home.png", [Pantalla Home], ancho: 100%, alto: 7cm),
  captura("../../../img/propuesta2/p4_mapa.png.png", [MapaScreen con el botón], ancho: 100%, alto: 7cm),
  captura("../../../img/propuesta2/p4_plano.png", [Plano abierto desde Mapa], ancho: 100%, alto: 7cm),
)

]
=== Paso 5: Verificación final y evidencias del entregable

Se ejecutó la versión final de la aplicación integrando el plano interactivo en el flujo de navegación principal (Pantalla de Inicio → Mapa → Plano de la Edificación). Se comprobó la aplicación de los estilos visuales y la interactividad al seleccionar cada uno de los 5 marcadores, desplegando sus respectivos diálogos modales de información.

==== Flujo de Navegación

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: horizon + center,
  figure(
    image("../../../img/propuesta2/p5_bienvenida.png", width: 90%),
    caption: [Pantalla de Inicio / Bienvenida]
  ),
  figure(
    image("../../../img/propuesta2/p5_mapa.png", width: 90%),
    caption: [Pantalla del Mapa]
  ),
  figure(
    image("../../../img/propuesta2/p5_planocompleto.png", width: 90%),
    caption: [Plano Completo con Estilo Aplicado]
  )
)

==== Interacción con Marcadores (Diálogos Modales)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 8pt,
  align: horizon + center,
  figure(
    image("../../../img/propuesta2/p5_dialogo1.png", width: 95%),
    caption: [Laboratorio 1]
  ),
  figure(
    image("../../../img/propuesta2/p5_dialogo2.png", width: 95%),
    caption: [Laboratorio 2]
  ),
  figure(
    image("../../../img/propuesta2/p5_dialogo3.png", width: 95%),
    caption: [Aula 301]
  )
)

#grid(
  columns: (1fr, 1fr),
  gutter: 8pt,
  align: horizon + center,
  figure(
    image("../../../img/propuesta2/p5_dialogo4.png", width: 65%),
    caption: [Sala de Docentes]
  ),
  figure(
    image("../../../img/propuesta2/p5_dialogo5.png", width: 65%),
    caption: [Patio Central]
  )
)
= EJERCICIOS/PROBLEMAS PROPUESTOS

// Código en tamaño reducido para esta sección
#let code-size = 6.4pt
#let code-line-size = 5.2pt
#show raw.where(block: true): it => block(
  width: 100%,
  fill: rgb("#F8F9FA"),
  stroke: 0.5pt + rgb("#D0D5DD"),
  radius: 2pt,
  inset: (x: 6pt, y: 4pt),
  breakable: true,
)[
  #show raw.line: line => {
    box(
      width: 1.5em,
      align(right)[
        #text(fill: rgb("#8C959F"), size: code-line-size)[#line.number]
        #h(0.5em)
      ]
    )
    line.body
  }
  #set text(size: code-size)
  #set par(justify: false)
  #it
]

// Bloque auxiliar: desarrollo de un punto, sangrado y en cuerpo menor
#let desarrollo(body) = block(
  above: 0.4em,
  below: 0.4em,
  width: 100%,
  inset: (left: 0.7em, top: 0.3em, bottom: 0.3em),
  breakable: true,
  text(size: 7.6pt)[#body],
)

== Pasos:
1. Crea una clase SeleccionViewModel : ViewModel() con una propiedad mutableStateOf<String> (o
StateFlow) para almacenar el edificio seleccionado.

   #desarrollo[
     Se creó el archivo `viewmodel/SeleccionViewModel.kt` con la clase `SeleccionViewModel :
     ViewModel()`, que expone el edificio seleccionado tanto con `mutableStateOf` (con `private
     set`) como con un `StateFlow` construido a partir de un `MutableStateFlow`, además de los
     métodos `seleccionarEdificio()` y `limpiarSeleccion()`:

     #figure(
       image("../../img/propuestos/Clase.png", width: auto, height: 5.4cm),
       caption: [Clase SeleccionViewModel con el estado en `mutableStateOf` y en `StateFlow`.],
     )

     En `MainActivity.kt` se eliminó el `var edificioSeleccionado by remember {
     mutableStateOf("Ninguno") }` que usaba la solución con lambda (y con él los imports
     `mutableStateOf` y `setValue`), y en `libs.versions.toml` más `app/build.gradle.kts` se
     agregaron `lifecycle-viewmodel-ktx` y `lifecycle-viewmodel-compose` en la versión 2.11.0,
     porque el proyecto todavía no tenía ninguna dependencia de ViewModel. El valor por defecto
     quedó además expuesto como la constante `SeleccionViewModel.SIN_SELECCION`, que es la que
     usa `HomeScreen` para distinguir si todavía no hay ningún edificio consultado.
   ]



2. Obtén una única instancia de SeleccionViewModel con viewModel() en el Composable raíz y pásala
a EdificiosScreen y a HomeScreen (en lugar de la lambda del ejercicio resuelto).

   #desarrollo[
     En el Composable raíz `MainScreen` se obtiene una única instancia con `viewModel()` y esa misma
     instancia se entrega a las dos pantallas dentro del `NavHost`, en lugar de la lambda del
     ejercicio resuelto. Como `viewModel()` conserva la instancia por `ViewModelStoreOwner` (el
     Activity), ambas pantallas reciben exactamente el mismo objeto aunque se abran y cierren varias
     veces:

     ```kotlin
     @Composable
     fun MainScreen() {

         val navController = rememberNavController()

         val seleccionViewModel: SeleccionViewModel = viewModel()

         val items = listOf( Screen.Home, Screen.Edificios, Screen.Mapa, Screen.Perfil )

         Scaffold(
             bottomBar = { /* NavigationBar con un NavigationBarItem por screen */ }
         ) { paddingValues ->

             NavHost(
                 navController = navController,
                 startDestination = Screen.Home.route,
                 modifier = Modifier.padding(paddingValues)
             ) {

                 composable(Screen.Home.route) {

                     HomeScreen(
                         viewModel = seleccionViewModel
                     )
                 }

                 composable(Screen.Edificios.route) {

                     EdificiosScreen(
                         viewModel = seleccionViewModel,
                         navController = navController
                     )
                 }

                 // composable(Screen.Mapa.route) { MapaScreen() }
                 // composable(Screen.Perfil.route) { PerfilScreen() }
             }
         }
     }
     ```

     El nuevo import `androidx.lifecycle.viewmodel.compose.viewModel` es el único que se requirió
     en este punto. El resto del ajuste se detalla en el punto 3, donde se escriben las nuevas
     firmas de los Composables.
   ]



3. En EdificiosScreen, al seleccionar un edificio, actualiza directamente el valor en el ViewModel
en vez de invocar una función lambda.

   #desarrollo[
     Recibida la instancia compartida del punto 2, `EdificiosScreen` cambió su firma de
     `onEdificioSeleccionado: (String) -> Unit` a `viewModel: SeleccionViewModel` más
     `navController: NavHostController`, y el botón *Ver* actualiza el ViewModel antes de navegar en
     lugar de invocar la lambda:

     ```kotlin
     @Composable
     fun EdificiosScreen(
         viewModel: SeleccionViewModel,
         navController: NavHostController
     ) {
         // ...
         items(edificios) { edificio ->
             // ...
             FilledTonalButton(
                 onClick = {

                     viewModel.seleccionarEdificio(edificio.nombre)

                     navController.navigate(Screen.Home.route) {
                         popUpTo(Screen.Home.route) {
                             inclusive = false
                         }
                         launchSingleTop = true
                     }
                 }
             ) {

                 Text("Ver")
             }
         }
     }
     ```

     La lambda ya no existe en ningún lado: la pantalla conversa directamente con el ViewModel. Se
     llamó al método `seleccionarEdificio()` en vez de asignar la propiedad porque el `private set`
     impide escribirla desde la pantalla y una asignación directa dejaría el `StateFlow`
     desincronizado. Como único import nuevo se agregó `androidx.navigation.NavHostController`,
     necesario para el tipo del parámetro.
   ]




4. En HomeScreen, lee el valor del ViewModel (con collectAsState() si usaste StateFlow) y muéstralo,
verificando que el comportamiento visual sea el mismo que con la lambda.

   #desarrollo[
     En `HomeScreen` se dejó de leer la propiedad del ViewModel directamente y se declaró una variable
     local que *observa* el `StateFlow` mediante `collectAsState()`, que es la que muestra la tarjeta
     de *"Último edificio consultado"*. Solo se agregó el import de `collectAsState` (`getValue` ya
     estaba) y el archivo `SeleccionViewModel.kt` no se modificó:

     ```kotlin
     @Composable
     fun HomeScreen(
         viewModel: SeleccionViewModel
     ) {

         val edificioSeleccionado by viewModel.edificioSeleccionadoFlow.collectAsState()
         val sinSeleccion = edificioSeleccionado == SeleccionViewModel.SIN_SELECCION
         // ...
         Card(
             // ...
         ) {

             Text(
                 text = "Último edificio consultado",
                 style = MaterialTheme.typography.labelMedium,

                 color = MaterialTheme.colorScheme.onSecondaryContainer
             )

             Text(
                 text = edificioSeleccionado,
                 style = MaterialTheme.typography.titleMedium,

                 color = MaterialTheme.colorScheme.onSecondaryContainer
             )
         }
     }
     ```

     El valor leído además permite alternar el ícono de la tarjeta entre búsqueda y ubicación
     mediante `sinSeleccion`, es decir, la suscripción al flujo también alimenta elementos de la
     interfaz distintos del texto.
   ]




5. Agrega una cuarta pestaña "Perfil" (u otra que prefieras) con un Composable simple de marcador
de posición, y su NavigationBarItem correspondiente.

   #desarrollo[
     Se creó el objeto `Screen.Perfil` en la `sealed class` con su `route` y su `label`, se registró
     su `NavigationBarItem` en la barra inferior y se añadió `composable(Screen.Perfil.route)` en el
     `NavHost` para invocar a `PerfilScreen`, un Composable simple de marcador de posición. La
     navegación inferior queda con cuatro destinos y el resaltado del ítem activo se mantiene porque
     sigue dependiendo de la ruta actual de la pila de navegación.

     #grid(
       columns: (1fr, 1fr),
       gutter: 0.8em,
       figure(
         image("../../img/propuestos/prueba1.png", width: auto, height: 6.2cm),
         caption: [(a) Pestaña Home ("Ninguno")],
       ),
       figure(
         image("../../img/propuestos/prueba2.png", width: auto, height: 6.2cm),
         caption: [(b) Pestaña Edificios],
       ),
       figure(
         image("../../img/propuestos/prueba3.png", width: auto, height: 6.2cm),
         caption: [(c) Pestaña Mapa],
       ),
       figure(
         image("../../img/propuestos/prueba4.png", width: auto, height: 6.2cm),
         caption: [(d) Cuarta pestaña Perfil],
       ),
     )
   ]

= EJERCICIO/PROBLEMA RESUELTO POR EL DOCENTE

== Enunciado: Construir una aplicación con tres pantallas (*Home*, *Edificios* y *Mapa*) navegables desde una barra inferior de navegación, comunicando la selección de un edificio mediante una función lambda.

== Desarrollo

=== Paso 1. Creación del proyecto y definición de la `sealed class Screen`

Se creó el proyecto en Android Studio y se definió la clase sellada `Screen` con sus tres
objetos, cada uno con su propiedad `route` (String) y `label` (String):

Además se agregaron las importaciones que se utilizan en los siguientes pasos:

#figure(
  image("../../img/resueltoDocente/paso1_imports.png", width: auto, height: 5.8cm),
  caption: [Paso 1. Configuración de importaciones y definición de la sealed class Screen.],
)

=== Paso 2. Dependencias necesarias en `build.gradle.kts`

Se verificó el archivo `build.gradle.kts` (Module `:app`) y se confirmaron las dependencias
requeridas dentro del bloque `dependencies { ... }`:

La librería `androidx.navigation:navigation-compose` aporta el `NavHost` y el `NavController`,
mientras que `androidx.compose.material:material-icons-extended` provee los iconos
`Icons.Default.Home`, `Icons.Default.List` e `Icons.Default.Place` de la barra de navegación.
Una vez agregadas, se ejecutó la sincronización del proyecto con el botón *Sync Now* antes de
continuar.

#figure(
  image("../../img/resueltoDocente/paso2.png", width: auto, height: 4.2cm),
  caption: [Paso 2. Dependencias añadidas en build.gradle.kts y sincronización del proyecto.],
)

=== Paso 3. Composable raíz con `NavController` y estado del edificio

En el Composable raíz se creó el `navController` y la variable de estado que almacenará el
último edificio consultado:

`rememberNavController()` crea el controlador de navegación persistente entre recomposiciones,
mientras que `mutableStateOf("Ninguno")` inicializa el estado con el valor por defecto
*"Ninguno"* y permite actualizarlo mediante la lambda.

#figure(
  image("../../img/resueltoDocente/paso3.png", width: auto, height: 2.2cm),
  caption: [Paso 3. Declaración de NavController y variable de estado edificioSeleccionado.],
)

=== Paso 4. `Scaffold` con la `NavigationBar` inferior

Se envolvió la interfaz dentro de un `Scaffold(bottomBar = { ... })` para estructurar la
pantalla. En el `bottomBar` se declaró una `NavigationBar` con un `NavigationBarItem` por cada `Screen`, marcando como seleccionado el que coincide con la ruta actual obtenida mediante `currentBackStackEntryAsState()`, y llamando a `navController.navigate(screen.route)` al pulsarlo:

De esta forma la barra inferior controla qué ítem se muestra resaltado según la ruta activa de la pila de navegación.

#figure(
  image("../../img/resueltoDocente/paso4.png", width: auto, height: 5.2cm),
  caption: [Paso 4. Scaffold con NavigationBar y NavigationBarItems.],
)

=== Paso 5. `NavHost` con las tres rutas

Dentro del `padding` entregado por el `Scaffold` se declaró el `NavHost` con
`startDestination = Screen.Home.route` y un bloque `composable(route) { ... }` para cada
pantalla:

La lambda pasada a `EdificiosScreen` es la que comunica la selección hacia el Composable raíz.

#figure(
  image("../../img/resueltoDocente/paso5.png", width: auto, height: 6.2cm),
  caption: [Paso 5. NavHost con las rutas home, edificios y mapa.],
)

=== Paso 6. Implementación de `HomeScreen`

Se implementó `HomeScreen(edificioSeleccionado: String)` mostrando un texto de bienvenida y
otro con el valor recibido:

Este Composable es completamente stateless: recibe el valor como parámetro y Compose lo
redibuja automáticamente cuando el estado del Composable raíz cambia.

#figure(
  image("../../img/resueltoDocente/paso6.png", width: auto, height: 5.2cm),
  caption: [Paso 6. Pantalla Home con el último edificio consultado.],
)

=== Paso 7. Implementación de `EdificiosScreen`

Se implementó `EdificiosScreen(onEdificioSeleccionado: (String) -> Unit)` con una `LazyColumn`
que lista al menos 4 edificaciones (nombre + botón). Al pulsar un ítem se invoca
`onEdificioSeleccionado(nombre)`:

El tipo `(String) -> Unit` define la función lambda de retorno, que desacopla la lista de
edificios del estado global de la navegación.

#figure(
  image("../../img/resueltoDocente/paso7.png", width: auto, height: 5.8cm),
  caption: [Paso 7. Lista de edificios en LazyColumn con botón Ver.],
)

=== Paso 8. Implementación de `MapaScreen`

Se implementó `MapaScreen()` con un `Text` marcador de posición, dejando el mapa real para una
posterior integración:

La lambda que actualiza `edificioSeleccionado` ya se declaró en el Paso 5, al definir
`composable(Screen.Edificios.route)` dentro del `NavHost`; por ello no se requiere ningún
parámetro adicional aquí.

#figure(
  image("../../img/resueltoDocente/paso8.png", width: auto, height: 3.6cm),
  caption: [Paso 8. Pantalla Mapa con marcador de posición.],
)

=== Paso 9. `MainActivity` invocando a `MainScreen()`

En `MainActivity`, dentro de `onCreate()`, se reemplazó el contenido de `setContent { }` (el que
trae la plantilla por defecto, con `Scaffold` y `Greeting`) para invocar a `MainScreen()`:

De esta forma, el tema de la plantilla se conserva y la navegación queda centralizada en el
Composable raíz `MainScreen()`.

#figure(
  image("../../img/resueltoDocente/paso9.png", width: auto, height: 3.4cm),
  caption: [Paso 9. MainActivity llamando a MainScreen().],
)

=== Paso 10. Ejecución y verificación en el emulador

Se ejecutó la aplicación en el emulador y se verificó que, al pulsar cada ítem de la barra
inferior, se muestra la pantalla correspondiente conservando el resaltado del ítem activo.
Luego, al seleccionar un edificio en la pestaña *Edificios* y volver a *Home*, se confirmó que
`HomeScreen` muestra el valor actualizado, lo que demuestra el correcto funcionamiento de la
comunicación mediante lambda entre pantallas.

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  figure(
    image("../../img/resueltoDocente/paso10_1_home_inicial.png", width: auto, height: 5.2cm),
    caption: [(a) Pantalla Home inicial ("Ninguno")],
  ),
  figure(
    image("../../img/resueltoDocente/paso10_2_edificios.png", width: auto, height: 5.2cm),
    caption: [(b) Pantalla Edificios (Lista)],
  ),
  figure(
    image("../../img/resueltoDocente/paso10_3_home_actualizado.png", width: auto, height: 5.2cm),
    caption: [(c) Home tras seleccionar Pabellón A],
  ),
  figure(
    image("../../img/resueltoDocente/paso10_4_mapa.png", width: auto, height: 5.2cm),
    caption: [(d) Pantalla Mapa (Marcador)],
  ),
)

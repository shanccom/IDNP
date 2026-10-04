#let img(ruta, texto) = figure(
  image(ruta, width: 35%),
  caption: texto,
)

= Propuesta 2

== Paso 1: Crear la clase `SeleccionViewModel`

*Enunciado:* Crea una clase `SeleccionViewModel : ViewModel()` con una propiedad `mutableStateOf<String>` (o `StateFlow`) para almacenar el edificio seleccionado.

*Implementación:* Se reemplazó la clase vacía `SelectViewModel` por `SeleccionViewModel`, que hereda de `ViewModel`. Se usó `mutableStateOf<String>("Ninguno")` para guardar el edificio seleccionado, con el valor inicial "Ninguno". Al ser un estado de Compose, cualquier Composable que lea esta propiedad se recompone automáticamente cuando cambia. La propiedad tiene `private set` para que solo pueda modificarse mediante el método `seleccionarEdificio()`. En este paso la app sigue funcionando con la lambda, porque el ViewModel todavía no se usa.

*Código agregado:*

```kotlin
class SeleccionViewModel : ViewModel() {
    var edificioSeleccionado by mutableStateOf<String>("Ninguno")
        private set

    fun seleccionarEdificio(nombre: String) {
        edificioSeleccionado = nombre
    }
}
```

== Paso 2: Obtener una única instancia con `viewModel()`

*Enunciado:* Obtén una única instancia de `SeleccionViewModel` con `viewModel()` en el Composable raíz y pásala a `EdificiosScreen` y a `HomeScreen` (en lugar de la lambda del ejercicio resuelto).

*Implementación:* En `MainScreen` se creó la instancia con `val seleccionViewModel: SeleccionViewModel = viewModel()`. Esta función entrega siempre la misma instancia mientras el `ViewModelStoreOwner` (la Activity) siga vivo, por lo que ambas pantallas comparten el mismo objeto. Esa instancia se pasa como parámetro a `HomeScreen` y a `EdificiosScreen`. Para poder ejecutar y comprobar este paso, se mantiene temporalmente la lambda anterior y se agrega en `HomeScreen` una línea que muestra el valor del ViewModel, que por ahora aún dice "Ninguno".

*Código agregado:*

```kotlin
// Nuevo import
import androidx.lifecycle.viewmodel.compose.viewModel

// En MainScreen: única instancia del ViewModel compartido
val seleccionViewModel: SeleccionViewModel = viewModel()

// En el NavHost: se pasa el ViewModel a ambas pantallas
composable(Screen.Home.route) {
    HomeScreen(
        edificioSeleccionado = edificioSeleccionado,
        viewModel = seleccionViewModel
    )
}
composable(Screen.Edificios.route) {
    EdificiosScreen(
        viewModel = seleccionViewModel,
        onEdificioSeleccionado = { nombre -> edificioSeleccionado = nombre }
    )
}

// HomeScreen ahora recibe el ViewModel y muestra su valor
@Composable
fun HomeScreen(edificioSeleccionado: String, viewModel: SeleccionViewModel) {
    Column(/* ... */) {
        Text(text = "Bienvenido a la app de Edificios")
        Text(text = "Último edificio consultado: $edificioSeleccionado")
        Text(text = "Valor en ViewModel: ${viewModel.edificioSeleccionado}")
    }
}

// EdificiosScreen ahora recibe el ViewModel (junto a la lambda temporal)
@Composable
fun EdificiosScreen(
    viewModel: SeleccionViewModel,
    onEdificioSeleccionado: (String) -> Unit
) { /* ... */ }
```

// Si tienes captura de este paso, descomenta y ajusta la ruta:
// #img("../../../img/propuestos/p2-2.png", [Paso 2: `HomeScreen` recibe el ViewModel compartido y muestra su valor inicial "Ninguno".])

== Paso 3: Actualizar el ViewModel desde `EdificiosScreen`

*Enunciado:* En `EdificiosScreen`, al seleccionar un edificio, actualiza directamente el valor en el ViewModel en vez de invocar una función lambda.

*Implementación:* Se eliminó el parámetro lambda `onEdificioSeleccionado` de `EdificiosScreen` y también la variable de estado local de `MainScreen`. Ahora el botón "Ver" llama a `viewModel.seleccionarEdificio(nombre)`, que modifica la propiedad del ViewModel. `HomeScreen` todavía conserva la línea "Valor en ViewModel" del paso anterior, así que al pulsar "Ver" y volver a la pestaña Home se comprueba que el valor cambió. La línea "Último edificio consultado" ya no se actualizará, porque dependía de la lambda; se corrige en el siguiente paso.

*Código modificado:*

```kotlin
// En MainScreen: se elimina la variable local y la lambda
// var edificioSeleccionado by remember { mutableStateOf("Ninguno") }  <- eliminado

composable(Screen.Home.route) {
    HomeScreen(viewModel = seleccionViewModel)
}
composable(Screen.Edificios.route) {
    EdificiosScreen(viewModel = seleccionViewModel) // sin lambda
}

// EdificiosScreen: el botón actualiza directamente el ViewModel
@Composable
fun EdificiosScreen(viewModel: SeleccionViewModel) {
    // ...
    Button(onClick = { viewModel.seleccionarEdificio(nombre) }) {
        Text("Ver")
    }
}
```

#img("../../../img/propuestos/p2-0.png", [Paso 3 (a): en Edificios se pulsa "Ver" en un edificio, por ejemplo "Pabellón A".])

#img("../../../img/propuestos/p2-1.png", [Paso 3 (b): en Home el valor del ViewModel cambió al edificio seleccionado.])

== Paso 4: Leer el valor del ViewModel en `HomeScreen`

*Enunciado:* En `HomeScreen`, lee el valor del ViewModel (con `collectAsState()` si usaste `StateFlow`) y muéstralo, verificando que el comportamiento visual sea el mismo que con la lambda.

*Implementación:* Como se usó `mutableStateOf` y no `StateFlow`, no hace falta `collectAsState()`: Compose observa directamente el estado y recompone `HomeScreen` cuando cambia. Se restauró el texto original "Último edificio consultado: ..." leyendo `viewModel.edificioSeleccionado`, y se quitó la línea de comprobación del paso anterior. El resultado visual es idéntico al de la versión con lambda: se pulsa "Ver" en Edificios, se vuelve a Home y aparece el edificio elegido.

*Código modificado:*

```kotlin
@Composable
fun HomeScreen(viewModel: SeleccionViewModel) {
    // Se lee el estado del ViewModel (mutableStateOf no requiere collectAsState)
    val edificio = viewModel.edificioSeleccionado

    Column(/* ... */) {
        Text(text = "Bienvenido a la app de Edificios")
        Text(text = "Último edificio consultado: $edificio")
    }
}
```

#img("../../../img/propuestos/p2-3.png", [Paso 4 (a): Home antes de seleccionar, con "Último edificio consultado: Ninguno".])

#img("../../../img/propuestos/p2-4.png", [Paso 4 (b): Home después de pulsar "Ver" en un edificio, mostrando el valor del ViewModel.])

== Paso 5: Agregar la pestaña "Perfil"

*Enunciado:* Agrega una cuarta pestaña "Perfil" (u otra que prefieras) con un Composable simple de marcador de posición, y su `NavigationBarItem` correspondiente.

*Implementación:* Se agregó el objeto `Screen.Perfil` con la ruta `"perfil"` en la `sealed class`. Se incluyó en la lista `items`, se asignó el ícono `Icons.Default.Person` dentro del `when` (que debe ser exhaustivo, ya que `Screen` es sealed) y se registró un nuevo `composable(Screen.Perfil.route)` en el `NavHost`. Por último, se creó `PerfilScreen`, un Composable simple con un texto de marcador de posición. Con esto la barra inferior muestra cuatro pestañas y el ViewModel compartido sigue funcionando.

*Código agregado:*

```kotlin
// Nuevo import
import androidx.compose.material.icons.filled.Person

// En la sealed class
object Perfil : Screen("perfil", "Perfil")

// En MainScreen: se agrega a la lista de pestañas
val items = listOf(Screen.Home, Screen.Edificios, Screen.Mapa, Screen.Perfil)

// En el when de los íconos
Screen.Perfil -> Icons.Default.Person

// En el NavHost
composable(Screen.Perfil.route) {
    PerfilScreen()
}

// Nuevo Composable marcador de posición
@Composable
fun PerfilScreen() {
    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        Text(text = "Perfil de usuario (pendiente de implementar)")
    }
}
```

#img("../../../img/propuestos/p2-5.png", [Paso 5 (a): barra de navegación con las cuatro pestañas.])

#img("../../../img/propuestos/p2-6.png", [Paso 5 (b): pestaña "Perfil" activa después de presionarla.])

= Entregables

El entregable solicitado es un informe con capturas de las cuatro pestañas funcionando, de la comunicación mediante el ViewModel compartido y una breve descripción de la implementación.

== Capturas de las cuatro pestañas

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  figure(
    image("../../../img/propuestos/p2-prueba1.png", width: 45%),
    caption: [Pestaña Home: muestra el último edificio consultado, leído desde el ViewModel compartido.],
  ),
  figure(
    image("../../../img/propuestos/p2-prueba2.png", width: 45%),
    caption: [Pestaña Edificios: lista de edificios con su botón "Ver".],
  ),
)

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  figure(
    image("../../../img/propuestos/p2-prueba3.png", width: 45%),
    caption: [Pestaña Mapa: mapa estilizado del campus con la ubicación de los edificios.],
  ),
  figure(
    image("../../../img/propuestos/p2-prueba4.png", width: 45%),
    caption: [Pestaña Perfil: Composable marcador de posición agregado como cuarta pestaña.],
  ),
)

== Comunicación mediante el ViewModel compartido

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  figure(
    image("../../../img/propuestos/p2-ninguno.png", width: 55%),
    caption: [Home antes de seleccionar: "Último edificio consultado" muestra "Ninguno".],
  ),
  figure(
    image("../../../img/propuestos/p2-presionando.png", width: 55%),
    caption: [Edificios: se pulsa "Ver" en "Biblioteca Central"; la tarjeta queda resaltada porque lee el mismo ViewModel.],
  ),
)

#grid(
  columns: (1fr),
  gutter: 0.8em,
  figure(
    image("../../../img/propuestos/p2-seleecionada.png", width: 30%),
    caption: [Home después de seleccionar: aparece "Biblioteca central", sin lambdas ni estado local.],
  ),
  [], // Espacio vacío para mantener el layout alineado de 2 columnas
)

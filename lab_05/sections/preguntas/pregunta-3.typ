= Pregunta 3: En forma individual, explica qué ventaja adicional ofrece un ViewModel frente a otras formas de mantener el estado al navegar entre pantallas. (Cada integrante del grupo debe incluir su propia respuesta en el informe).

== Integrante 1
Frente a remember o a un objeto object global, el ViewModel mantiene el estado vivo durante toda la navegación y ante rotaciones o cambios de configuración, sin recrearse ni filtrar memoria. Además, al usar viewModelScope, las corrutinas se cancelan solas cuando la pantalla desaparece, lo que evita operaciones innecesarias y permite inyectar dependencias para las pruebas.

Ejemplo: si el usuario elige "Pabellón A" en Edificios y luego gira el teléfono, remember perdería el valor, pero el `ViewModel` seguiría mostrando "Pabellón A" en Home.

```kotlin
class EdificioViewModel : ViewModel() {
    var edificio by mutableStateOf("Ninguno"); private set
    fun seleccionar(nombre: String) {
        viewModelScope.launch { /* simular llamada a API o BD */ }
        edificio = nombre
    }
}
```

== Integrante 2

La ventaja que noté al hacer el ejercicio es que el ViewModel separa el estado de la interfaz. 

Al utilizar  `remember`, el valor vive dentro de un Composable, y para compartirlo entre dos pantallas hay que subirlo al padre y pasarlo con lambdas. Pero al utilizar un ViewModel compartido, `EdificiosScreen` escribe y `HomeScreen` lee del mismo objeto. 

Ejemplo: el usuario elige "Auditorio" en Edificios, rota el teléfono y cambia varias veces de pestaña. Home sigue mostrando "Auditorio" porque el dato está en el ViewModel y no en un Composable que se recrea.

```kotlin
class SeleccionViewModel(
    private val savedState: SavedStateHandle
) : ViewModel() {

    // StateFlow que se guarda y se restaura automáticamente
    val edificio: StateFlow<String> =
        savedState.getStateFlow("edificio", "Ninguno")

    fun seleccionar(nombre: String) {
        savedState["edificio"] = nombre
    }
}

// En HomeScreen:
// val edificio by viewModel.edificio.collectAsState()
```
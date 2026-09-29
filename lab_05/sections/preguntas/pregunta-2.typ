= Pregunta 2: En tu propia implementación, ¿qué diferencia encontraste entre comunicar Composables mediante una función lambda y hacerlo mediante un ViewModel compartido? ¿Cuál de las dos alternativas consideras una mejor práctica? Explica brevemente los motivos.

La lambda solo notifica el evento al Composable raíz, que guarda el estado en mutableStateOf; es simple, pero ese estado se pierde al recrear la Activity. El `ViewModel` compartido conserva el estado entre pantallas, rotaciones y cambios de configuración. Para este laboratorio basta la lambda, pero en una app real el `ViewModel` es mejor práctica: desacopla la UI y es más fácil de testear.

Ejemplo: el mismo edificio notificado de dos formas.

```kotlin
// Lambda: el estado vive en la UI y se pierde al recrear la pantalla
var edificio by remember { mutableStateOf("Ninguno") }
EdificiosScreen(onEdificioSeleccionado = { edificio = it })

// ViewModel compartido: el estado sobrevive a la navegación y a la rotación
class EdificioViewModel : ViewModel() {
    var edificio by mutableStateOf("Ninguno"); private set
    fun seleccionar(nombre: String) { edificio = nombre }
}
```

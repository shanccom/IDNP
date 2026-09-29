= Pregunta 3: En forma individual, explica qué ventaja adicional ofrece un ViewModel frente a otras formas de mantener el estado al navegar entre pantallas. (Cada integrante del grupo debe incluir su propia respuesta en el informe).

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

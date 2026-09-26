= Ejercicio Resuelto: Monitoreo de batería con BroadcastReceiver en Jetpack Compose

== Enunciado

Implementar una pantalla en Jetpack Compose que muestre el nivel de batería en tiempo real mediante un `BroadcastReceiver` registrado dinámicamente con `DisposableEffect`.

== Desarrollo

=== 1. Registro y Ciclo de Vida con `DisposableEffect`
Se implementa el componente composable que escucha los cambios del sistema (`ACTION_BATTERY_CHANGED`) y calcula el porcentaje:

```kotlin
@Composable
fun BatteryScreen(modifier: Modifier = Modifier) {
    var porcentaje by remember { mutableIntStateOf(0) }
    val context = LocalContext.current

    DisposableEffect(Unit) {
        val receiver = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                val nivel = intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
                val escala = intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
                if (nivel != -1 && escala != -1) {
                    porcentaje = (nivel * 100) / escala
                }
            }
        }
        context.registerReceiver(receiver, IntentFilter(Intent.ACTION_BATTERY_CHANGED))

        onDispose {
            context.unregisterReceiver(receiver)
        }
    }

    Text(text = "Batería: $porcentaje%", modifier = modifier)
}
```

=== 2. Aspectos Clave
- *Extracción de datos:* Se obtienen `EXTRA_LEVEL` y `EXTRA_SCALE` para calcular el porcentaje de carga.
- *Gestión de recursos:* `DisposableEffect` registra el receiver al entrar en composición y lo desregistra en `onDispose` para evitar fugas de memoria.
- *Estado optimizado:* `mutableIntStateOf(0)` previene el autoboxing de tipos primitivos en recomposiciones frecuentes.

=== 3. Evidencias de Ejecución y Pruebas
Se validó el comportamiento reactivo en tiempo real modificando el nivel de batería desde el emulador en los entornos de desarrollo de ambos integrantes del equipo:

*Pruebas de Integrante 1 *

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  figure(
    image("../../img/ejercicio1-ejecucion-100.png", width: 95%),
    caption: [Ejecución inicial al 100%.],
  ),
  figure(
    image("../../img/ejercicio1-simulacion-50.png", width: 95%),
    caption: [Simulación de nivel al 50%.],
  ),
)

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  figure(
    image("../../img/ejercicio1-simulacion-17.png", width: 95%),
    caption: [Simulación de nivel crítico al 17%.],
  ),
  figure(
    image("../../img/ejercicio1-simulacion-100.png", width: 95%),
    caption: [Restablecimiento de batería al 100%.],
  ),
)

*Pruebas de Integrante 2 *

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  figure(
    image("../../img/propuesta2/100.png", width: 95%),
    caption: [Ejecución inicial al 100%.],
  ),
  figure(
    image("../../img/propuesta2/57.png", width: 95%),
    caption: [Simulación de nivel al 57%.],
  ),
)

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  figure(
    image("../../img/propuesta2/20.png", width: 95%),
    caption: [Simulación de nivel crítico al 20%.],
  ),
  figure(
    image("../../img/propuesta2/7.png", width: 95%),
    caption: [Simulacion de nivel al 7%.],
  ),
)

== Modificaciones para Warnings y Buenas Prácticas

- Manejo de `innerPadding`: Se aplicó el `innerPadding` provisto por `Scaffold` para evitar superposiciones con barras del sistema y prevenir advertencias de layout en Compose.

- Parámetro `Modifier`: Se añadió `modifier: Modifier = Modifier` a `BatteryScreen()` para garantizar su reusabilidad y cumplir con las directrices oficiales de Android.

- Optimización con `mutableIntStateOf`: Se sustituyó `mutableStateOf(0)` por `mutableIntStateOf(0)` para optimizar el rendimiento y evitar el boxing innecesario de enteros.

- Validación y Lint: Se comprobó la compilación, pruebas y análisis estático con Android Lint, asegurando un código limpio, funcional y libre de errores.

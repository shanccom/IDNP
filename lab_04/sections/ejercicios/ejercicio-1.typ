= Ejercicio 1: Monitoreo de batería con BroadcastReceiver en Jetpack Compose

== Enunciado

Implementar una pantalla en Jetpack Compose que muestre el nivel de batería en tiempo real mediante un `BroadcastReceiver` registrado dinámicamente con `DisposableEffect`.

*Video de referencia:* #link("https://www.youtube.com/watch?v=AeNnc8yhNTo")[Broadcast Receivers en Android con Jetpack Compose (YouTube)].

== Desarrollo

=== 1. Implementación del Composable `BatteryScreen`
Se define el componente composable encargado de escuchar los cambios en el estado de la batería mediante un `BroadcastReceiver` acoplado al ciclo de vida de Compose:

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
        Log.d("BatteryScreen", "Receiver registrado")

        onDispose {
            context.unregisterReceiver(receiver)
            Log.d("BatteryScreen", "Receiver desregistrado")
        }
    }

    Text(
        text = "Batería: $porcentaje%",
        modifier = modifier
    )
}
```

*Análisis:* El composable gestiona el estado reactivo con `mutableIntStateOf(0)` y emplea `DisposableEffect` para registrar dinámicamente el `BroadcastReceiver` con `ACTION_BATTERY_CHANGED`, calculando el porcentaje a partir de `EXTRA_LEVEL` y `EXTRA_SCALE`, y garantizando la liberación del recurso en `onDispose` para evitar fugas de memoria.

=== 2. Configuración en `MainActivity.kt`
Se establece la pantalla principal dentro de la actividad mediante el contenedor `Scaffold`:

```kotlin
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            BatteryMonitor_ComposeTheme {
                Scaffold(modifier = Modifier.fillMaxSize()) { innerPadding ->
                    BatteryScreen(modifier = Modifier.padding(innerPadding))
                }
            }
        }
    }
}
```

*Análisis:* Se define la actividad principal estructurando la vista con `Scaffold`, propagando los márgenes de `innerPadding` hacia `BatteryScreen` mediante `Modifier.padding` para respetar las áreas seguras de la pantalla y asegurar una correcta integración con Material Design.

=== 3. Pruebas y Verificación
- Simulación: Desde Extended Controls > Battery en el emulador, se modificó el nivel de batería, verificando la reactividad inmediata del `Text` en pantalla.
- Logcat: Se filtró por la etiqueta `BatteryScreen`, corroborando los logs de registro al iniciar y de desregistro al desmontar la vista.

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  figure(
    image("../../img/ejercicio1-ejecucion-100.png", width: 100%),
    caption: [Ejecución inicial en Android Studio.],
  ),
  figure(
    image("../../img/ejercicio1-simulacion-100.png", width: 100%),
    caption: [Simulación de batería al 100%.],
  ),
)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  figure(
    image("../../img/ejercicio1-simulacion-50.png", width: 100%),
    caption: [Simulación de batería al 50%.],
  ),
  figure(
    image("../../img/ejercicio1-simulacion-17.png", width: 100%),
    caption: [Simulación de batería al 17%.],
  ),
)

== Modificaciones para Warnings y Buenas Prácticas

- Manejo de `innerPadding`: Se aplicó el `innerPadding` provisto por `Scaffold` para evitar superposiciones con barras del sistema y prevenir advertencias de layout en Compose.

- Parámetro `Modifier`: Se añadió `modifier: Modifier = Modifier` a `BatteryScreen()` para garantizar su reusabilidad y cumplir con las directrices oficiales de Android.

- Optimización con `mutableIntStateOf`: Se sustituyó `mutableStateOf(0)` por `mutableIntStateOf(0)` para optimizar el rendimiento y evitar el boxing innecesario de enteros.

- Validación y Lint: Se comprobó la compilación, pruebas y análisis estático con Android Lint, asegurando un código limpio, funcional y libre de errores.
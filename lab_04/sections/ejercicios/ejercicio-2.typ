= Ejercicio 2: Actualización manual del porcentaje de batería con broadcast personalizado

== Enunciado

Tomando como referencia el ejercicio resuelto por el docente, agregar una segunda forma de actualizar el porcentaje de batería, disparada manualmente en lugar de por el evento automático del sistema:

1. Agregar un botón "Actualizar manualmente" a `BatteryScreen` que cree un `Intent` con una acción propia (`com.tuapp.ACTUALIZAR_BATERIA`), lo envuelva en un `PendingIntent.getBroadcast(...)` y lo active con `PendingIntent.send()`.
2. Implementar un segundo `BroadcastReceiver` que escuche esa acción personalizada y, al recibirla, vuelva a leer el estado de la batería y actualice el mismo estado en pantalla.
3. Registrar y desregistrar este segundo receiver siguiendo el mismo patrón de `DisposableEffect` usado en el ejercicio resuelto.
4. *(Reto opcional)* Mostrar en pantalla, además del porcentaje, si la batería se está cargando o no, usando `EXTRA_STATUS` del `Intent` original.

== Desarrollo y Solución Paso a Paso

=== Paso 1: Botón "Actualizar manualmente" y emisión con `PendingIntent`
Se define la acción propia y la función para encapsular el intent en un `PendingIntent` inmutable que dispara el broadcast bajo demanda al presionar el botón:

```kotlin
const val ACCION_ACTUALIZAR_BATERIA = "com.tuapp.ACTUALIZAR_BATERIA"

fun enviarActualizacionManual(context: Context) {
    val intent = Intent(ACCION_ACTUALIZAR_BATERIA).apply {
        setPackage(context.packageName) // Seguridad interna
    }
    val pendingIntent = PendingIntent.getBroadcast(
        context,
        0,
        intent,
        PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
    )
    pendingIntent.send()
}
```

*Análisis:* `PendingIntent` delega la ejecución al sistema; la bandera `FLAG_IMMUTABLE` impide que aplicaciones externas alteren el contenido del intent, mientras que `setPackage()` asegura que la transmisión ocurra exclusivamente dentro del paquete de la app.

=== Paso 2: Implementación del segundo `BroadcastReceiver` personalizado
Se implementa el segundo receptor encargado de capturar la acción manual y consultar síncronamente el estado del hardware:

```kotlin
val receiverManual = object : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        // Consulta instantánea del último broadcast sticky del sistema
        val stickyIntent = context?.registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        val nivel = stickyIntent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val escala = stickyIntent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        if (nivel != -1 && escala != -1) {
            porcentaje = (nivel * 100) / escala
        }
    }
}
```

*Análisis:* Al pasar `null` como receptor en `registerReceiver()`, Android retorna de inmediato el último intent pegajoso (*sticky broadcast*) sin crear una suscripción activa, permitiendo una lectura puntual y eficiente bajo demanda.

=== Paso 3: Registro y desregistro del segundo receptor con `DisposableEffect`
Se integra el segundo receiver en la jerarquía de Compose respetando su ciclo de vida:

```kotlin
DisposableEffect(Unit) {
    val filtroManual = IntentFilter(ACCION_ACTUALIZAR_BATERIA)
    ContextCompat.registerReceiver(
        context,
        receiverManual,
        filtroManual,
        ContextCompat.RECEIVER_NOT_EXPORTED
    )

    onDispose {
        context.unregisterReceiver(receiverManual)
    }
}
```

*Análisis:* Acoplar la suscripción a `DisposableEffect` garantiza que el receptor se desregistre automáticamente al desmontarse la vista (`onDispose`), evitando fugas de memoria (*memory leaks*) en la aplicación.

=== Paso 4: (Reto opcional) Detección y visualización del estado de carga (`EXTRA_STATUS`)
Se extrae `EXTRA_STATUS` para evaluar si el dispositivo recibe energía eléctrica y reflejarlo en un indicador visual:

```kotlin
val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
val estaCargando = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                   status == BatteryManager.BATTERY_STATUS_FULL
```

*Análisis:* Es indispensable validar tanto `BATTERY_STATUS_CHARGING` como `BATTERY_STATUS_FULL`, ya que un dispositivo al 100% continúa enchufado a la corriente aunque el proceso de carga activa haya finalizado.

=== 5. Evidencias de Ejecución y Pruebas

#figure(
  image("../../img/Captura de pantalla 2026-09-25 a la(s) 12.08.28 p. m..png", width: 90%),
  caption: [Simulación en Extended Controls al 51% en estado "Charging" reflejado con píldora verde "Cargando".],
)

#v(0.6em)
#figure(
  image("../../img/Captura de pantalla 2026-09-25 a la(s) 12.08.48 p. m..png", width: 90%),
  caption: [Actualización manual al 70% ("Sin carga") y verificación del broadcast en Logcat ("Actualización manual recibida").],
)

= 3. Registra un segundo BroadcastReceiver que escuche una acción distinta (por ejemplo "com.tuapp.ACCION_SYNC_ERROR") y simula un caso de error en el Service (por ejemplo, con una probabilidad aleatoria), mostrando un mensaje distinto en la UI.

Se introdujo la acción de difusión `ACCION_SYNC_ERROR` para simular y canalizar fallos de sincronización. Antes de consultar Room, el servicio evalúa una probabilidad del 30 % (`Random.nextInt(100) < 30`); de cumplirse, emite el broadcast con el extra `mensaje_error`, escribe en Logcat y ejecuta `stopSelf()` sin modificar la base de datos. En la UI, un segundo `BroadcastReceiver` captura la señal, apaga el indicador de carga y muestra el mensaje de error.

=== Cambios Realizados

- *Archivo modificado:* `app/.../MainActivity.kt`
1. *Acción adicional:* Definición de `ACCION_SYNC_ERROR` junto a `ACCION_SYNC_LISTA`.
2. *Fallo en segundo plano (30 %):* Al dispararse, envía el broadcast con `mensaje_error` y sale con `stopSelf()`.
3. *Segundo receptor reactivo:* `receiverError` (`RECEIVER_NOT_EXPORTED`) actualiza `resultado` y apaga `enCurso`.
4. *Ciclo de vida y consistencia:* Ambos receptores se desregistran en `onDispose` y los 4 edificios siguen *Pendiente*.

=== Código Implementado

```kotlin
// 1. Acciones de difusión
private const val ACCION_SYNC_LISTA = "com.example.sincronizacionservicio_compose.ACCION_SYNC_LISTA"
private const val ACCION_SYNC_ERROR = "com.example.sincronizacionservicio_compose.ACCION_SYNC_ERROR"
// 2. Simulación de fallo aleatorio (30%) en el Service
delay(800)
if (Random.nextInt(100) < 30) {
    val error = Intent(ACCION_SYNC_ERROR).apply {
        setPackage(packageName)
        putExtra("mensaje_error", "No se pudo conectar con el servidor de sincronización")
    }
    sendBroadcast(error)
    Log.d("SYNC", "2b. Error de sincronización notificado")
    stopSelf()
    return@launch
}
// 3. Segundo BroadcastReceiver en PantallaSincronizacion
val receiverError = object : BroadcastReceiver() {
    override fun onReceive(ctx: Context?, intent: Intent?) {
        Log.d("SYNC", "3b. Error recibido en la pantalla")
        val mensaje = intent?.getStringExtra("mensaje_error") ?: "Error desconocido"
        resultado = "Error de sincronización: $mensaje"
        enCurso = false
    }
}
ContextCompat.registerReceiver(
    context, receiverError, IntentFilter(ACCION_SYNC_ERROR),
    ContextCompat.RECEIVER_NOT_EXPORTED
)
// 4. Desregistro de ambos receptores en onDispose
onDispose {
    context.unregisterReceiver(receiver)
    context.unregisterReceiver(receiverError)
}
```

#colbreak()

=== Evidencias de Ejecución

#figure(
  image("../../img/propuestos/ejercicio-3.1.png", width: 100%),
  caption: [Registro en Logcat mostrando la secuencia de fallo: servicio iniciado (`1`), notificación de error desde el servicio (`2b`) y recepción en la pantalla (`3b`).],
)

#figure(
  image("../../img/propuestos/ejercicio-3.png", width: 45%),
  caption: [Emulador reflejando el mensaje de error capturado por el segundo receptor; nótese que los edificios permanecen en estado "Pendiente".],
)

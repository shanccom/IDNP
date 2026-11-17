== 4. Haz que la audio-guía suene de verdad: agrega un archivo de audio corto (.mp3, por ejemplo una narración de 30 segundos sobre un edificio) en la carpeta res/raw y reprodúcelo con MediaPlayer dentro de AudioGuiaService. "Reproducir" inicia el audio, "Pausar" lo pausa y "Detener" lo detiene. Con esto reemplazas el avance simulado (la coroutine) por un audio real. Pista: usa MediaPlayer.create(this, R.raw.nombre_del_audio).

== Desarrollo

#pad(1.1em)[

Para que la audio-guía suene de verdad se reemplazó el avance simulado con corrutinas (`Job`, `delay`) por la API `MediaPlayer` de Android, incorporando la narración `narracion_edificio.mp3` en la carpeta `app/src/main/res/raw/`. Al estar dentro del paquete de la aplicación, el recurso se abre directamente como flujo de audio sin pasos adicionales.

En `AudioGuiaService` se eliminó la función `iniciarAvance()` y el reproductor se creó una sola vez con `MediaPlayer.create(...)`. *"Reproducir"* llama a `start()` y reanuda desde la posición donde quedó el audio, *"Pausar"* usa `pause()` sin perder esa posición y *"Detener"* ejecuta `stop()` y `release()` para liberar los recursos nativos antes de cerrar el servicio.

Con `setOnCompletionListener` se atiende el final natural de la narración: se libera el reproductor, se retira la notificación con `stopForeground(STOP_FOREGROUND_REMOVE)` y se invoca `stopSelf()`, evitando que el servicio quede activo sin motivo. Las acciones *"Pausar"* y *"Detener"* de la notificación siguen funcionando igual, ya que envían los mismos identificadores de acción al servicio. La compilación se verificó con `./gradlew :app:compileDebugKotlin`, obteniendo `BUILD SUCCESSFUL`.

=== Implementación de Código

*1. Gestión del ciclo de vida de `MediaPlayer` (`AudioGuiaService.kt`):*

```kotlin
private var reproductor: MediaPlayer? = null

private fun iniciarAudio() {
    if (reproductor == null) {
        reproductor = MediaPlayer.create(
            this,
            R.raw.narracion_edificio
        )?.apply {
            setOnCompletionListener { finalizarAudio() }
        }
    }
    reproductor?.start()
}

private fun pausarAudio() {
    reproductor?.let {
        if (it.isPlaying) it.pause()
    }
}

private fun detenerAudio() {
    reproductor?.let {
        if (it.isPlaying) it.stop()
        it.release()
    }
    reproductor = null
}

private fun finalizarAudio() {
    detenerAudio()
    stopForeground(STOP_FOREGROUND_REMOVE)
    stopSelf()
}
```

*2. Despacho y manejo de acciones en el Foreground Service (`AudioGuiaService.kt`):*

```kotlin
ACCION_REPRODUCIR -> {
    pausado = false
    iniciarAudio()
}

ACCION_PAUSAR -> {
    pausarAudio()
    pausado = true
    actualizarNotificacion()
}

ACCION_DETENER -> {
    detenerAudio()
    stopForeground(STOP_FOREGROUND_REMOVE)
    stopSelf()
}
```

=== Evidencias de Ejecución

A continuación se presentan las capturas obtenidas en el emulador ejecutando la reproducción con audio real:

#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  align: horizon + center,
  figure(
    image("../../img/propuesto/ejercicio-4.png", width: 90%),
    caption: [Reproducción activa del audio real con servicio en primer plano.]
  ),
  figure(
    image("../../img/propuesto/ejercicio-4.1.png", width: 90%),
    caption: [Detención del audio, liberación del reproductor y cierre de notificación.]
  )
)
]

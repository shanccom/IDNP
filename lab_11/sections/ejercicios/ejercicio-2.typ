== 2. Agrega los botones "Pausar" y "Detener" dentro de la notificación, para controlar la reproducción sin abrir la app (pista: usa addAction en el NotificationCompat.Builder).

== Desarrollo

#pad(1.1em)[

Para controlar la reproducción sin traer la aplicación a primer plano se agregaron acciones interactivas a la notificación persistente de `AudioGuiaService`. Tanto *"Pausar"* como *"Detener"* se declararon con `.addAction(...)` en el `NotificationCompat.Builder`, y cada una apunta a un `PendingIntent` construido con `PendingIntent.getService(...)` hacia el propio servicio.

Al pulsar *"Pausar"* se cancela la corrutina de avance y el cuerpo de la notificación cambia a *"Audio-guía en pausa"*; al pulsar *"Detener"* se interrumpe la reproducción, se retira la notificación con `stopForeground(STOP_FOREGROUND_REMOVE)` y se finaliza el servicio con `stopSelf()`. Todas las actualizaciones reutilizan `ID_NOTIFICACION`, de modo que la notificación se refresca en el sitio y nunca se duplica.

Los `requestCode` 1 y 2 evitan colisiones en la tabla interna de intenciones pendientes de Android, mientras que `FLAG_IMMUTABLE` protege los extras conforme a lo exigido desde Android 12. Así, el servicio responde a los botones del panel del sistema igual que a los controles de la interfaz. La compilación se comprobó con `./gradlew :app:compileDebugKotlin`, obteniendo `BUILD SUCCESSFUL`.

=== Implementación de Código

*1. Fábrica auxiliar de `PendingIntent` para el servicio (`AudioGuiaService.kt`):*

```kotlin
private fun accionNotificacion(accion: String, requestCode: Int): PendingIntent {
    val intent = Intent(this, AudioGuiaService::class.java).setAction(accion)
    return PendingIntent.getService(
        this,
        requestCode,
        intent,
        PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
    )
}
```

*2. Vinculación de acciones en `NotificationCompat.Builder`:*

```kotlin
.addAction(
    R.drawable.ic_media_pause,
    "Pausar",
    accionNotificacion(ACCION_PAUSAR, 1)
)
.addAction(
    R.drawable.ic_menu_close_clear_cancel,
    "Detener",
    accionNotificacion(ACCION_DETENER, 2)
)
```

=== Evidencias de Ejecución

A continuación se presentan las capturas registradas en el emulador que demuestran el control de la audio-guía desde el panel del sistema operativo:

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: horizon + center,
  figure(
    image("../../img/propuesto/paso-2.1.png", width: 85%),
    caption: [Reproducción activa en la interfaz de la aplicación.]
  ),
  figure(
    image("../../img/propuesto/paso-2.2.png", width: 80%),
    caption: [Ejecución en segundo plano con ícono en la barra de estado.]
  )
)

#v(0.6em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  align: horizon + center,
  figure(
    image("../../img/propuesto/paso-2.3.png", width: 75%),
    caption: [Notificación persistente con botones interactivos "Pausar" y "Detener".]
  ),
  figure(
    image("../../img/propuesto/paso-2.4.png", width: 75%),
    caption: [Transición inmediata a "Audio-guía en pausa" sin abrir la app.]
  )
)
]

== 1. Agrega un botón "Siguiente edificio" que cambie al siguiente edificio de la lista (los del Laboratorio 08) y muestre su nombre en el título de la notificación.

== Desarrollo

#pad(1.1em)[

Para este ejercicio se incorporó la colección `EDIFICIOS_LAB08` con los doce edificios del Laboratorio 08, respetando el orden del archivo `edificios.txt`. La lista se conectó con `PantallaAudioGuia`, que muestra de forma reactiva el nombre del edificio activo en cada momento.

El botón *"Siguiente edificio"* avanza el índice mediante aritmética modular, de modo que después del último edificio se vuelve al primero. Al pulsarlo se envía un `Intent` explícito con la acción `ACCION_SIGUIENTE` y el nombre del nuevo edificio en el extra `EXTRA_EDIFICIO`, manteniendo sincronizadas la interfaz y el servicio en segundo plano.

En `AudioGuiaService`, esa acción actualiza el índice interno y vuelve a llamar a `NotificationManager.notify()` con el mismo `ID_NOTIFICACION`, por lo que Android reemplaza el contenido de la notificación existente en lugar de crear una nueva. El botón *"Reproducir"* también envía el edificio actual, garantizando que el título inicial sea el correcto. La compilación se verificó con `./gradlew :app:compileDebugKotlin`, obteniendo `BUILD SUCCESSFUL`.

=== Implementación de Código

*1. Botón "Siguiente edificio" en Compose (`MainActivity.kt`):*

```kotlin
Button(onClick = {
    indiceEdificio = (indiceEdificio + 1) % EDIFICIOS_LAB08.size
    context.startService(
        Intent(context, AudioGuiaService::class.java)
            .setAction(AudioGuiaService.ACCION_SIGUIENTE)
            .putExtra(AudioGuiaService.EXTRA_EDIFICIO, EDIFICIOS_LAB08[indiceEdificio])
    )
}) {
    Text("Siguiente edificio")
}
```

*2. Manejo de la acción en el Foreground Service (`AudioGuiaService.kt`):*

```kotlin
ACCION_SIGUIENTE -> {
    actualizarIndice(intent.getStringExtra(EXTRA_EDIFICIO))
    if (enPrimerPlano) {
        getSystemService(NotificationManager::class.java).notify(
            ID_NOTIFICACION,
            construirNotificacion(EDIFICIOS_LAB08[indiceEdificio])
        )
    }
}
```

=== Evidencias de Ejecución

A continuación se presentan las capturas obtenidas en el emulador, donde se observa la transición secuencial y circular al presionar el botón *"Siguiente edificio"*:

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  figure(
    image("../../img/propuesto/ejercicio-1.1.png", width: 85%),
    caption: [Edificio: Aula Magna UNSA.]
  ),
  figure(
    image("../../img/propuesto/ejercicio-1.2.png", width: 85%),
    caption: [Avance a Fac. de Ing. de Sistemas.]
  ),
  figure(
    image("../../img/propuesto/ejercicio-1.3.png", width: 85%),
    caption: [Avance a FIPS.]
  )
)
]

= Ejercicio Resuelto por el Docente: Audio-Guía con Foreground Service

A continuación se detallan, paso a paso, las instrucciones para implementar un reproductor de audio-guía (narración sobre un edificio del campus) que se ejecuta como *Foreground Service*. También puede apoyarse en el siguiente video tutorial:

- *Video de referencia:* "ANDROID - FOREGROUND SERVICE ~ WITH NOTIFICATION AND BACKGROUND TASK || KOTLIN" \
  #link("https://www.youtube.com/watch?v=-45jGLtbhPQ")

#v(0.4em)

== Paso 1. Crear un nuevo proyecto

Nombre sugerido para el proyecto: `AudioGuiaForeground_Compose`, Package name: `com.example.audioguiaforeground_compose`, Language: `Kotlin`, Minimum SDK: el que venga por defecto en la plantilla (recuerden usar un emulador o dispositivo con API 34 o superior, según la sección de Recursos a utilizar).

#figure(
  image("../../img/resuelto/paso-1.png", width: 42%),
  caption: [Paso 1: Creación y configuración inicial del proyecto en Android Studio.],
)

#v(0.4em)

== Paso 2. Configurar AndroidManifest.xml y dependencias en build.gradle.kts

Abrir el archivo `AndroidManifest.xml`: agregar los permisos `FOREGROUND_SERVICE`, `FOREGROUND_SERVICE_MEDIA_PLAYBACK` (obligatorio desde Android 14 para servicios de tipo `mediaPlayback`) y `POST_NOTIFICATIONS` (obligatorio desde Android 13), y declarar el nuevo `Service` dentro de la etiqueta `<application>` con `android:foregroundServiceType="mediaPlayback"`.

#figure(
  image("../../img/resuelto/paso-2.1.png", width: 60%),
  caption: [Paso 2.1: Permisos y declaración del servicio con mediaPlayback en AndroidManifest.xml.],
)

Luego, abrir el archivo `build.gradle.kts` (Module :app) y agregar, dentro de `dependencies`, la librería `lifecycle-process` (necesaria para usar `ProcessLifecycleOwner` en el Paso 10). Después presionar *Sync Now*.

#figure(
  image("../../img/resuelto/paso-2.2.png", width: 60%),
  caption: [Paso 2.2: Incorporación de lifecycle-process en build.gradle.kts y sincronización.],
)

#v(0.4em)

== Paso 3. Agregar importaciones necesarias

Agregar, debajo del `package` y antes de la clase `MainActivity`, todas las importaciones que se usarán en este ejercicio.

#figure(
  image("../../img/resuelto/paso-3.png", width: 42%),
  caption: [Paso 3: Importaciones requeridas para el servicio, ciclo de vida y Jetpack Compose.],
)

#v(0.4em)

== Paso 4. Crear la clase AudioGuiaService y acciones del Intent

Crear la clase `AudioGuiaService`, heredando de `Service`, con un `companion object` que defina las acciones del `Intent` (reproducir, pausar, detener) y los identificadores del canal y de la notificación. Sobrescribir `onBind()` devolviendo `null`. Por ahora dejamos pendiente la creación del canal de notificaciones.

#figure(
  image("../../img/resuelto/paso-4.png", width: 60%),
  caption: [Paso 4: Estructura inicial de AudioGuiaService, companion object y onBind().],
)

#v(0.4em)

== Paso 5. Sobrescribir onCreate() y crear NotificationChannel

Sobrescribir `onCreate()`, creando el `NotificationChannel` requerido desde Android 8 (API 26) en adelante.

#figure(
  image("../../img/resuelto/paso-5.png", width: 60%),
  caption: [Paso 5: Creación del canal de notificaciones con NotificationManager en onCreate().],
)

#v(0.4em)

== Paso 6. Definir la función construirNotificacion()

Definir la función `construirNotificacion(titulo)`, que arma la notificación persistente que exige un *Foreground Service*.

#figure(
  image("../../img/resuelto/paso-6.png", width: 58%),
  caption: [Paso 6: Función construirNotificacion con NotificationCompat.Builder y setOngoing(true).],
)

#v(0.4em)

== Paso 7. Sobrescribir onStartCommand()

Sobrescribir `onStartCommand()`, leyendo la acción del `Intent` recibido: al reproducir, llamar a `startForeground()` con la notificación; al pausar, cancelar el avance; al detener, cancelar el avance y finalizar el `Service`.

#figure(
  image("../../img/resuelto/paso-7.png", width: 60%),
  caption: [Paso 7: Manejo de acciones en onStartCommand() y llamada a startForeground().],
)

#v(0.4em)

== Paso 8. Implementar iniciarAvance() y completar AudioGuiaService

Definir la función `iniciarAvance()`, que simula con una coroutine el avance de la reproducción (en un caso real, aquí se controlaría un `MediaPlayer`). Con esto, `AudioGuiaService` queda completo.

#figure(
  image("../../img/resuelto/paso-8.png", width: 35%),
  caption: [Paso 8: Implementación de iniciarAvance() con coroutines en Dispatchers.IO.],
)

#v(0.4em)

== Paso 9. Crear el Composable PantallaAudioGuia

Crear el Composable `PantallaAudioGuia`, obteniendo el contexto actual y dos variables de estado: si se está reproduciendo y si la app está en segundo plano. Por ahora dejamos el resto del cuerpo vacío.

#figure(
  image("../../img/resuelto/paso-9.png", width: 58%),
  caption: [Paso 9: Creación de PantallaAudioGuia y variables de estado reactivo.],
)

#v(0.4em)

== Paso 10. Registrar el observador con ProcessLifecycleOwner

Dentro de un `DisposableEffect(Unit)`, registrar un observador sobre `ProcessLifecycleOwner` que, cuando la app pasa a segundo plano (`ON_STOP`), marque `enSegundoPlano` en `true`, y cuando vuelve a primer plano (`ON_START`), lo marque en `false`, siguiendo el flujo del ciclo de vida de la aplicación.

#figure(
  image("../../img/resuelto/paso-10.png", width: 55%),
  caption: [Paso 10: Vinculación con ProcessLifecycleOwner dentro de DisposableEffect.],
)

#v(0.4em)

== Paso 11. Implementar controles de interfaz y diseño visual

Agregar los botones *Reproducir*, *Pausar* y *Detener*, cada uno llamando a `context.startService()` con la acción correspondiente, y un texto que refleje el estado actual. Con esto, `PantallaAudioGuia` queda completo. Se agrega `statusBarsPadding()` al `Column` para que el texto y los botones no queden debajo de la barra de estado ni de la cámara del dispositivo.

#figure(
  image("../../img/resuelto/paso-11.png", width: 30%),
  caption: [Paso 11: Interfaz UI de PantallaAudioGuia con botones y startService().],
)

#v(0.4em)

== Paso 12. Configurar setContent en MainActivity

Dentro de `MainActivity`, en el bloque `setContent`, mostrar `PantallaAudioGuia`.

#figure(
  image("../../img/resuelto/paso-12.png", width: 32%),
  caption: [Paso 12: Inclusión de PantallaAudioGuia dentro del bloque setContent en MainActivity.],
)

#v(0.4em)

== Paso 13. Ejecución, pruebas y verificación en emulador

Ejecutar la aplicación en un emulador, presionar "Reproducir" y, sin cerrar la app, presionar el botón Home para pasarla a segundo plano; verificar que aparece la notificación persistente con el título del edificio. Si la notificación no aparece, activar los permisos de notificaciones de la aplicación en el emulador: *Ajustes (Settings) → Apps → AudioGuiaForeground_Compose → Notificaciones*, y activar todas las notificaciones de la app; luego volver a presionar "Reproducir".

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: bottom + center,
  figure(
    image("../../img/resuelto/paso-13.1.png", width: 80%),
    caption: [13.1: Reproduciendo audio-guía.],
  ),
  figure(
    image("../../img/resuelto/paso-13.2.png", width: 80%),
    caption: [13.2: Detección en 2do plano.],
  ),
  figure(
    image("../../img/resuelto/paso-13.3.png", width: 60%),
    caption: [13.3: Notificación persistente.],
  ),
)

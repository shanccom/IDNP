#let captura(caption, ruta: none, width: 50%) = figure(
  if type(ruta) == array {
    align(center, block(width: 75%, grid(
      columns: (1fr, 1fr),
      gutter: 0.8em,
      ..ruta.map(r => image(r, width: 100%))
    )))
  } else if ruta == none {
    align(center, rect(
      width: 50%,
      height: 4cm,
      stroke: 0.5pt + gray,
      radius: 2pt,
    )[#align(center + horizon)[_Captura de pantalla pendiente_]])
  } else {
    image(ruta, width: width)
  },
  caption: caption,
)

== 1. Agrega un botón "Siguiente edificio" que cambie al siguiente edificio de la lista (los del Laboratorio 08) y muestre su nombre en el título de la notificación.
== Desarrollo

#pad(1.1em)[

Se crea el objeto `EstadoAudioGuia`, que guarda la lista de edificios, cuál es el actual (`indice`) y si se está reproduciendo. Lo usan tanto la pantalla como el Service, así los dos ven siempre el mismo estado. El título de la notificación ahora sale del edificio actual.

El botón «Siguiente edificio» avanza el índice (al llegar al último vuelve al primero). Si se está reproduciendo, además le envía al Service la acción `ACCION_ACTUALIZAR`, que vuelve a publicar la notificación con el nuevo título.

*Código agregado (`MainActivity.kt`):*

```kotlin
object EstadoAudioGuia {
    val edificios = listOf(
        "Biblioteca Central", "Comedor Universitario", "Facultad de Ingeniería",
        "Facultad de Ciencias", "Coliseo Universitario", "Auditorio Central"
    )
    var indice by mutableStateOf(0)
    var reproduciendo by mutableStateOf(false)

    val edificioActual: String get() = edificios[indice]

    fun siguiente() {
        indice = (indice + 1) % edificios.size
    }
}

// En AudioGuiaService
const val ACCION_ACTUALIZAR = "com.example.audioguiaforeground_compose.ACTUALIZAR"

ACCION_ACTUALIZAR -> actualizarNotificacion()

private fun actualizarNotificacion() {
    val manager = getSystemService(NotificationManager::class.java)
    manager.notify(ID_NOTIFICACION, construirNotificacion())
}

// el título de la notificación sale del edificio actual
.setContentTitle(EstadoAudioGuia.edificioActual)

// En PantallaAudioGuia
Button(onClick = {
    EstadoAudioGuia.siguiente()
    if (EstadoAudioGuia.reproduciendo) {
        enviar(AudioGuiaService.ACCION_ACTUALIZAR)
    }
}) { Text("Siguiente edificio") }
```

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  captura(
    ruta: "/assets/image-1.png",
    width: 85%,
  )[Paso 1 (a): pantalla con el edificio actual y el botón «Siguiente edificio».],
  captura(
    ruta: "/assets/image.png",
    width: 85%,
  )[Paso 1 (b): notificación en segundo plano con el título del primer edificio.],
  captura(
    ruta: "/assets/image-2.png",
    width: 85%,
  )[Paso 1 (c): después de pulsar «Siguiente edificio», el título de la notificación cambia a Comedor Universitario],
)

]
== 2. Agrega los botones "Pausar" y "Detener" dentro de la notificación, para controlar la reproducción sin abrir la app (pista: usa addAction en el NotificationCompat.Builder).

== Desarrollo

#pad(1.1em)[

Cada botón de la notificación se crea con `addAction` y necesita un `PendingIntent`, que es el "aviso pendiente" que Android envía al Service cuando se toca el botón. Hice la función `accionNotificacion()` para crearlos, con la misma acción (`ACCION_PAUSAR`, `ACCION_DETENER`) que ya usan los botones de la pantalla.

La notificación ahora depende del estado: mientras suena muestra «Pausar», y cuando está en pausa cambia el texto a «Audio-guía en pausa» y el botón pasa a «Reanudar». «Detener» está siempre. Como la pantalla lee el mismo `EstadoAudioGuia`, si se pausa desde la notificación, la pantalla también lo refleja.

*Código agregado (`MainActivity.kt`):*

```kotlin
// Nuevo import
import android.app.PendingIntent

// PendingIntent que envía una acción al Service
private fun accionNotificacion(accion: String, codigo: Int): PendingIntent {
    return PendingIntent.getService(
        this, codigo,
        Intent(this, AudioGuiaService::class.java).setAction(accion),
        PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
    )
}

private fun construirNotificacion(): Notification {
    val reproduciendo = EstadoAudioGuia.reproduciendo
    val builder = NotificationCompat.Builder(this, ID_CANAL)
        .setContentTitle(EstadoAudioGuia.edificioActual)
        .setContentText(if (reproduciendo) "Reproduciendo audio-guía" else "Audio-guía en pausa")
        .setSmallIcon(android.R.drawable.ic_media_play)
        .setOngoing(true)

    // botones dentro de la notificación
    if (reproduciendo) {
        builder.addAction(android.R.drawable.ic_media_pause, "Pausar",
            accionNotificacion(ACCION_PAUSAR, 1))
    } else {
        builder.addAction(android.R.drawable.ic_media_play, "Reanudar",
            accionNotificacion(ACCION_REPRODUCIR, 2))
    }
    builder.addAction(android.R.drawable.ic_menu_close_clear_cancel, "Detener",
        accionNotificacion(ACCION_DETENER, 3))
    return builder.build()
}

// En onStartCommand: al pausar también se actualiza la notificación
ACCION_PAUSAR -> {
    job?.cancel()
    EstadoAudioGuia.reproduciendo = false
    actualizarNotificacion()
}
```

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  captura(
    ruta: "/assets/image-3.png",
    width: 85%,
  )[Paso 2 (a): notificación expandida con los botones «Pausar» y «Detener».],
  captura(
    ruta: "/assets/image-4.png",
    width: 85%,
  )[Paso 2 (b): después de pausar desde la notificación; ahora aparece «Reanudar».],
  captura(
    ruta: "/assets/image-5.png",
    width: 85%,
  )[Paso 2 (c): al pulsar «Detener» la notificación desaparece.],
)

]
== 3. Usando Room (Laboratorio 09), guarda cuál fue el último edificio reproducido. Cuando se abra la app de nuevo, muestra un botón "Continuar" que retome ese edificio.

== Desarrollo
#pad(1.1em)[

Para guardar el último edificio usé Room con una tabla de una sola fila (`UltimoEdificioEntity`, con `id = 1`) que guarda el índice del edificio. Con `OnConflictStrategy.REPLACE`, cada vez que se guarda se reemplaza la fila anterior. El Service guarda el edificio al reproducir y cuando se cambia de edificio con «Siguiente», y para eso le agregué su propio `scope`.

En la pantalla, un `LaunchedEffect` lee el último edificio guardado al abrir la app y cuando cambia el estado de reproducción. Si hay uno guardado y no se está reproduciendo, aparece el botón «Continuar: nombre del edificio», que lo selecciona y empieza a reproducirlo. Antes de esto repetí la configuración de Room y KSP de los laboratorios anteriores.

*Código agregado (`MainActivity.kt`):*

```kotlin
@Entity
data class UltimoEdificioEntity(
    @PrimaryKey val id: Int = 1,   // siempre una sola fila
    val indice: Int
)

@Dao
interface UltimoEdificioDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun guardar(ultimo: UltimoEdificioEntity)

    @Query("SELECT * FROM UltimoEdificioEntity WHERE id = 1")
    suspend fun obtener(): UltimoEdificioEntity?
}
// AppDatabase con una única instancia: AppDatabase.obtener(context)

// En AudioGuiaService
private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

private fun guardarUltimo() {
    val indice = EstadoAudioGuia.indice
    scope.launch {
        AppDatabase.obtener(applicationContext).ultimoDao()
            .guardar(UltimoEdificioEntity(indice = indice))
    }
}
// guardarUltimo() se llama en ACCION_REPRODUCIR y en ACCION_ACTUALIZAR

// En PantallaAudioGuia
val dao = remember { AppDatabase.obtener(context).ultimoDao() }
var ultimo by remember { mutableStateOf<Int?>(null) }

LaunchedEffect(EstadoAudioGuia.reproduciendo) {
    ultimo = dao.obtener()?.indice
}

val nombreGuardado = ultimo?.let { EstadoAudioGuia.edificios.getOrNull(it) }
if (nombreGuardado != null && !EstadoAudioGuia.reproduciendo) {
    Button(onClick = {
        EstadoAudioGuia.indice = ultimo ?: 0
        enviar(AudioGuiaService.ACCION_REPRODUCIR)
    }) { Text("Continuar: $nombreGuardado") }
}
```

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: horizon + center,
  captura(
    ruta: "/assets/image-6.png",
    width: 70%,
  )[Paso 3 (a): se reproduce un edificio distinto al primero (después de «Siguiente edificio») y se detiene.],
  captura(
    ruta: "/assets/image-7.png",
    width: 70%,
  )[Paso 3 (b): al abrir la app de nuevo aparece el botón «Continuar» con ese edificio.],
  
  
)

#captura(
    ruta: "/assets/image-8.png",
    width: 40%,
  )[Paso 3 (c): después de pulsar «Continuar», se retoma el edificio guardado.],

#captura(
    ruta: "/assets/image-9.png",
    width: 80%,
  )[Paso 3 (d): Database Inspector con la fila guardada en `UltimoEdificioEntity`.],
]
== 4. Haz que la audio-guía suene de verdad: agrega un archivo de audio corto (.mp3) en la carpeta res/raw y reprodúcelo con MediaPlayer dentro de AudioGuiaService. "Reproducir" inicia el audio, "Pausar" lo pausa y "Detener" lo detiene.

== Desarrollo
#pad(1.1em)[

Agregué un audio corto en `app/src/main/res/raw/audioguia.mp3` (el nombre va en minúsculas y sin espacios, porque Android lo convierte en `R.raw.audioguia`). En el Service quité la coroutine que simulaba el avance y puse un `MediaPlayer`: «Reproducir» lo crea con `MediaPlayer.create(this, R.raw.audioguia)` y llama a `start()`, «Pausar» llama a `pause()` y «Detener» lo libera con `release()`. Al reanudar, el audio continúa por donde se quedó.

Dos detalles que agregué: al cambiar de edificio con «Siguiente edificio» el audio vuelve al inicio (`seekTo(0)`), y cuando el audio termina, el estado pasa a «en pausa». Como el audio se reproduce desde el Foreground Service, sigue sonando con la app en segundo plano. No hizo falta cambiar nada en la pantalla.

*Código agregado (`MainActivity.kt`):*

```kotlin
// Nuevo import
import android.media.MediaPlayer

// En AudioGuiaService: el MediaPlayer reemplaza a job y a iniciarAvance()
private var reproductor: MediaPlayer? = null

private fun iniciarAudio() {
    if (reproductor == null) {
        reproductor = MediaPlayer.create(this, R.raw.audioguia)
        reproductor?.setOnCompletionListener {
            EstadoAudioGuia.reproduciendo = false
            actualizarNotificacion()
        }
    }
    reproductor?.start()
}

private fun liberarAudio() {
    reproductor?.release()
    reproductor = null
}

// En onStartCommand
ACCION_REPRODUCIR -> { /* ... */ iniciarAudio() }
ACCION_PAUSAR -> { reproductor?.pause(); /* ... */ }
ACCION_ACTUALIZAR -> { reproductor?.seekTo(0); /* ... */ }
ACCION_DETENER -> { liberarAudio(); /* ... */ }

// Al destruirse el Service
override fun onDestroy() {
    liberarAudio()
    scope.cancel()
    super.onDestroy()
}
```
#captura(
    ruta: "/assets/image-10.png",
    width: 85%,
  )[Paso 4 (a): archivo `audioguia.ogg` dentro de la carpeta `res/raw`.],

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  
  captura(
    ruta: "/assets/image-11.png",
    width: 85%,
  )[Paso 4 (b): la app reproduciendo el audio.],
  captura(
    ruta: "/assets/image-12.png",
    width: 85%,
  )[Paso 4 (c): notificación con los botones mientras suena el audio en segundo plano.],
)

*Video de la prueba (con audio):* #link("https://drive.google.com/file/d/1Ib3TD8Fv9qX22WnoP2r6H5BkT1g_HzJy/view?usp=sharing")[ENLACE-DEL-VIDEO-PROPUESTA2]

]

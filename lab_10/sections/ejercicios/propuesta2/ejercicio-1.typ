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

= Propuesta 2
= 1. Agrega un botón "Detener sincronización" que llame a context.stopService(Intent(context, SincronizacionService::class.java)) mientras la tarea está en curso.

#pad(1.1em)[

Agregué el botón «Detener sincronización», que llama a `context.stopService(...)`. Al probarlo vi que solo eso no basta: la tarea seguía corriendo y a los 3 segundos igual se enviaba el aviso. Por eso le di al Service su propio `scope` y lo cancelo en `onDestroy()`, que es lo que Android ejecuta cuando el Service se detiene.

En la pantalla añadí el estado `sincronizando`: mientras la tarea corre, «Sincronizar» se desactiva y «Detener sincronización» se activa. Así no se pueden lanzar dos tareas a la vez, y el indicador de progreso solo se ve cuando realmente se está sincronizando. La acción del broadcast quedó como constante (`ACCION_SYNC_LISTA`) para no repetirla.

*Código agregado (`MainActivity.kt`):*

```kotlin
const val ACCION_SYNC_LISTA = "com.example.sincronizacionservicio_compose.ACCION_SYNC_LISTA"

class SincronizacionService : Service() {

    // scope propio del servicio, para poder cancelar la tarea si lo detienen
    private val scope = CoroutineScope(SupervisorJob() + Dispatchers.IO)

    // onStartCommand ahora usa scope.launch { ... } en lugar de CoroutineScope(...).launch

    // se ejecuta al detener el servicio (con stopService o con stopSelf)
    override fun onDestroy() {
        scope.cancel()
        Log.d("SYNC", "4. Servicio destruido (onDestroy)")
        super.onDestroy()
    }
}

// En PantallaSincronizacion
var sincronizando by remember { mutableStateOf(false) }

Button(
    onClick = {
        resultado = null
        sincronizando = true
        context.startService(Intent(context, SincronizacionService::class.java))
    },
    enabled = !sincronizando
) { Text("Sincronizar") }

Button(
    onClick = {
        Log.d("SYNC", "Detención manual solicitada")
        context.stopService(Intent(context, SincronizacionService::class.java))
        sincronizando = false
        resultado = "Sincronización detenida por el usuario"
    },
    enabled = sincronizando
) { Text("Detener sincronización") }

if (sincronizando) CircularProgressIndicator()
else Text(resultado ?: "Pulsa «Sincronizar» para comenzar")
```

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  captura(
    ruta: "/assets/image-1.png",
    width: 85%,
  )[Paso 1 (a): pantalla inicial con el botón «Detener» deshabilitado.],
  captura(
    ruta: "/assets/image-2.png",
    width: 85%,
  )[Paso 1 (b): sincronizando; ahora el botón «Detener» está habilitado.],
  captura(
    ruta: "/assets/image-3.png",
    width: 85%,
  )[Paso 1 (c): mensaje después de detener manualmente la sincronización.],
)

#captura(
  ruta: "/assets/image-4.png",
  width: 80%,
)[Paso 1 (d): Logcat con «Detención manual solicitada» y «4. Servicio destruido»; no aparece «2. Aviso enviado» porque la tarea se canceló.]

]
= 2. Modifica el Service para que, en lugar de un resultado simulado, recorra la lista de edificios persistida en Room (Laboratorio 09) y "sincronice" (por ejemplo, marque como actualizados) los que cumplan una condición, enviando el conteo real por el broadcast.
#pad(1.1em)[
Repetí la configuración de Gradle del Laboratorio 09. Creé la entidad `EdificioEntity` con un campo nuevo, `sincronizado`, que empieza en `false`, y un Dao para insertar, actualizar y leer. La lectura tiene dos versiones: una que devuelve la lista (para el Service) y otra que devuelve un `Flow` (para que la pantalla se actualice sola).

Al abrir la app se insertan 7 edificios de muestra y se muestran en una lista como «Pendiente» o «Sincronizado»; al inicio todos están pendientes.

*Código agregado (`gradle/libs.versions.toml`):*

```toml
[versions]
ksp = "2.3.6"

[plugins]
ksp = { id = "com.google.devtools.ksp", version.ref = "ksp" }
```

*Código agregado (`build.gradle.kts` del proyecto y del módulo `app`):*

```kotlin
// build.gradle.kts del proyecto, dentro de plugins { }
alias(libs.plugins.ksp) apply false

// build.gradle.kts del módulo app, dentro de plugins { }
alias(libs.plugins.ksp)

// build.gradle.kts del módulo app, dentro de dependencies { }
implementation("androidx.room:room-runtime:2.7.2")
implementation("androidx.room:room-ktx:2.7.2")
ksp("androidx.room:room-compiler:2.7.2")
```

*Código agregado (`MainActivity.kt`):*

```kotlin
@Entity
data class EdificioEntity(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val nombre: String,
    val categoria: String,
    val sincronizado: Boolean = false
)

@Dao
interface EdificioDao {
    @Insert suspend fun insertar(edificio: EdificioEntity)
    @Update suspend fun actualizar(edificio: EdificioEntity)

    @Query("SELECT * FROM EdificioEntity")
    suspend fun obtenerTodos(): List<EdificioEntity>

    @Query("SELECT * FROM EdificioEntity")
    fun observarTodos(): Flow<List<EdificioEntity>>
}

@Database(entities = [EdificioEntity::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun edificioDao(): EdificioDao

    companion object {
        @Volatile private var instancia: AppDatabase? = null

        // una sola instancia, compartida por la pantalla y por el Service
        fun obtener(context: Context): AppDatabase =
            instancia ?: synchronized(this) {
                instancia ?: Room.databaseBuilder(
                    context.applicationContext, AppDatabase::class.java, "sincronizacion.db"
                ).build().also { instancia = it }
            }
    }
}
```

#grid(
  columns: (1fr, 2fr),
  gutter: 1.5em,
  align: horizon + center,
  captura(
    ruta: "/assets/image-5.png",
    width: 75%,
  )[Paso 2 (a): lista de edificios guardados en Room, todos «Pendiente».],
  captura(
    ruta: "/assets/image-6.png",
    width: 85%,
  )[Paso 2 (b): Database Inspector con la tabla `EdificioEntity` y su columna `sincronizado`.],
)

Después cambié el Service para que sincronice de verdad. Tras la espera de 3 segundos, recorre los edificios y marca como sincronizados los de categoría «Académico», contando cuántos son. Ese conteo real es el que se envía en el broadcast, en lugar del número al azar.

*Código agregado (`SincronizacionService` en `MainActivity.kt`):*

```kotlin
scope.launch {
    delay(3000)

    // se recorre la lista guardada en Room
    val dao = AppDatabase.obtener(applicationContext).edificioDao()
    var actualizados = 0
    dao.obtenerTodos().forEach { edificio ->
        if (edificio.categoria == "Académico") {
            dao.actualizar(edificio.copy(sincronizado = true))
            actualizados++
        }
    }

    val resultado = Intent(ACCION_SYNC_LISTA)
    resultado.setPackage(packageName)
    resultado.putExtra("edificios_actualizados", actualizados) // conteo real
    sendBroadcast(resultado)
    Log.d("SYNC", "2. Aviso enviado: $actualizados edificios")

    stopSelf()
}
```

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  captura(
    ruta: "/assets/image-7.png",
    width: 55%,
  )[Paso 2 (c): sincronización en curso con el indicador de progreso.],
  captura(
    ruta: "/assets/image-8.png",
    width: 55%,
  )[Paso 2 (d): resultado con el conteo real; los edificios «Académico» pasan a «Sincronizado».],
  
)

#captura(
  ruta: "/assets/image-9.png",
  width: 80%,
)[Paso 2 (f): Logcat con los mensajes 1, 2 y 3; el aviso informa el conteo real.]

]
= 3. Registra un segundo BroadcastReceiver que escuche una acción distinta (por ejemplo "com.tuapp.ACCION_SYNC_ERROR") y simula un caso de error en el Service (por ejemplo, con una probabilidad aleatoria), mostrando un mensaje distinto en la UI.

#pad(1.1em)[
Definí una segunda acción, `ACCION_SYNC_ERROR`. En la pantalla registré un segundo receiver, con su propia acción, y lo desregistro junto con el primero. Al recibir el aviso de error, muestra el mensaje con el color de error del tema, para distinguirlo del mensaje de éxito. Para tomar la captura del error cambié temporalmente `(1..3)` por `(1..1)` y luego lo devolví a como estaba.

*Código agregado (`MainActivity.kt`):*

```kotlin
const val ACCION_SYNC_ERROR = "com.example.sincronizacionservicio_compose.ACCION_SYNC_ERROR"

// En el Service, después del delay(3000)
if ((1..3).random() == 1) {
    val error = Intent(ACCION_SYNC_ERROR)
    error.setPackage(packageName)
    error.putExtra("motivo", "No se pudo conectar con el servidor (simulado)")
    sendBroadcast(error)
    Log.d("SYNC", "2. Error simulado: aviso de error enviado")
    stopSelf()
    return@launch
}

// En PantallaSincronizacion
var esError by remember { mutableStateOf(false) }

// dentro del DisposableEffect: segundo receiver
val receiverError = object : BroadcastReceiver() {
    override fun onReceive(ctx: Context?, intent: Intent?) {
        Log.d("SYNC", "3. Aviso de error recibido en la pantalla")
        val motivo = intent?.getStringExtra("motivo") ?: "Error desconocido"
        resultado = "Error de sincronización: $motivo"
        esError = true
        sincronizando = false
    }
}
ContextCompat.registerReceiver(
    context, receiverError, IntentFilter(ACCION_SYNC_ERROR),
    ContextCompat.RECEIVER_NOT_EXPORTED
)
onDispose {
    context.unregisterReceiver(receiverOk)
    context.unregisterReceiver(receiverError)
}

// El mensaje de error se muestra con otro color
Text(
    text = resultado ?: "Pulsa «Sincronizar» para comenzar",
    color = if (esError) MaterialTheme.colorScheme.error else Color.Unspecified
)
```

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: horizon + center,
  captura(
    ruta: "/assets/image-11.png",
    width: 70%,
  )[Paso 3 (a): sincronización exitosa con su mensaje normal.],
  captura(
    ruta: "/assets/image-12.png",
    width: 70%,
  )[Paso 3 (b): caso de error; la UI muestra otro mensaje y con otro color.],
)

#captura(
  ruta: "/assets/image-13.png",
  width: 80%,
)[Paso 3 (c): Logcat con «Error simulado» y «Aviso de error recibido en la pantalla».]

]
= 4: Investiga qué son los WorkManager de Android y explica en el informe en qué casos convendría usar WorkManager en lugar de un Service iniciado manualmente para esta misma tarea de sincronización.

*¿Qué es?* Según la documentación de Android, WorkManager es la solución recomendada para el trabajo persistente, es decir, sigue programado aunque la app se cierre o el teléfono se reinicie. Se define la tarea y sus condiciones (por ejemplo, tener internet) y se ejecuta cuando esas condiciones se cumplen.

*¿Cuándo usarlo en lugar de un Service?* 
- Cuando debe terminar aunque el usuario cierre la app: Android indica que, cuando una app pasa a segundo plano, el sistema detiene sus Services en segundo plano pasados unos minutos;
- Cuando debe repetirse sola, por ejemplo cada hora: WorkManager permite trabajo periódico ;
- Cuando solo debe correr con ciertas condiciones, como tener conexión: se declaran como restricciones ;
- Cuando hay que reintentar si falla: ofrece políticas de reintento, con espera exponencial configurable.

*¿Cuando usar un Service?* Sigue siendo mejor cuando la tarea es inmediata y el usuario la espera, como el botón «Sincronizar» de este laboratorio. Si la tarea es larga y el usuario la nota, la documentación recomienda un Service en primer plano, con notificación.

Como referencia, así se programaría la sincronización periódica con WorkManager, según la documentación de Android:

```kotlin
class SincronizacionWorker(ctx: Context, params: WorkerParameters) :
    CoroutineWorker(ctx, params) {
    override suspend fun doWork(): Result {
        // aquí iría la lógica de sincronizar los edificios
        return Result.success()
    }
}

val pedido = PeriodicWorkRequestBuilder<SincronizacionWorker>(1, TimeUnit.HOURS)
    .setConstraints(
        Constraints.Builder()
            .setRequiredNetworkType(NetworkType.CONNECTED)
            .build()
    )
    .build()

WorkManager.getInstance(context).enqueue(pedido)
```

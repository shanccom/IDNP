= 2. Modifica el Service para que, en lugar de un resultado simulado, recorra la lista de edificios persistida en Room (Laboratorio 09) y "sincronice" (por ejemplo, marque como actualizados) los que cumplan una condición, enviando el conteo real por el broadcast.
#pad(1.1em)[

Se sustituyó la sincronización simulada por una persistencia real con Room (reutilizando el esquema del Laboratorio 09), sincronizando únicamente aquellos edificios con `sincronizado == false` y reportando métricas reales a la UI.

=== Archivos Configurados y Modificados

#table(
  columns: (1.3fr, 2.7fr),
  align: (left, left),
  table.header([*Archivo*], [*Cambio Realizado*]),
  [`EdificiosRoom.kt`], [Nueva entidad `EdificioEntity` (con flags `sincronizado` y `actualizadoEn`), `EdificioDao`, `AppDatabase`, `DatabaseProvider` y función de sembrado inicial.],
  [`MainActivity.kt`], [El servicio consulta Room, actualiza pendientes en bucle con delay, cancela su `Job` en `onDestroy()` y emite el conteo real; la UI muestra "N de M".],
  [`build.gradle.kts` / `app`], [Configuración de KSP (`2.3.6`) y dependencias de Room (`2.7.2`: runtime, ktx y compiler).],
  [`libs.versions.toml`], [Declaración de dependencias y versiones de Room y KSP en el catálogo de versiones.],
)

=== 1. Estructura de Room (`EdificiosRoom.kt`)

Se definió la entidad y el DAO para gestionar la condición de sincronización:

```kotlin
@Entity
data class EdificioEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val nombre: String,
    val categoria: String,
    val sincronizado: Boolean = false,   // <-- estado de sincronización
    val actualizadoEn: Long? = null
)

@Dao
interface EdificioDao {
    @Insert
    suspend fun insertarEdificio(edificio: EdificioEntity): Long

    @Query("SELECT * FROM EdificioEntity")
    suspend fun obtenerTodos(): List<EdificioEntity>

    // Condición: edificios pendientes de sincronizar
    @Query("SELECT * FROM EdificioEntity WHERE sincronizado = 0")
    suspend fun obtenerPendientes(): List<EdificioEntity>

    @Query("UPDATE EdificioEntity SET sincronizado = 1, actualizadoEn = :momento WHERE id = :id")
    suspend fun marcarSincronizado(id: Int, momento: Long)
}
```

Incluye además `AppDatabase`, `DatabaseProvider` (siguiendo el patrón del Lab 09) y la función `sembrarEdificiosIniciales(dao)`, la cual inserta 4 edificios de ejemplo (los 2 del Lab 09 más Pabellón de Aulas y Comedor) únicamente si la base está vacía, asegurando datos de prueba reproducibles.

=== 2. Consulta Real y Cancelación en `SincronizacionService`

El servicio consulta Room en un hilo IO, actualiza cada registro pendiente y vincula la corrutina a un `Job` para corte inmediato al detenerse:

```kotlin
private var trabajo: Job? = null

override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
    trabajo = CoroutineScope(Dispatchers.IO).launch {
        val dao = DatabaseProvider.obtener(applicationContext).edificioDao()
        sembrarEdificiosIniciales(dao)

        val pendientes = dao.obtenerPendientes()   // Condición real
        var actualizados = 0

        for (edificio in pendientes) {
            delay(500) // Simula la sincronización remota
            dao.marcarSincronizado(edificio.id, System.currentTimeMillis())
            actualizados++
        }

        val resultado = Intent("com.example.lab_10_sincronizacionservicio_compose.ACCION_SYNC_LISTA").apply {
            setPackage(packageName)
            putExtra("edificios_actualizados", actualizados) // Conteo real
            putExtra("edificios_revisados", pendientes.size)
        }
        sendBroadcast(resultado)
        stopSelf()
    }
    return START_NOT_STICKY
}

override fun onDestroy() {
    trabajo?.cancel()   // "Detener sincronización" cancela la corrutina activamente
    super.onDestroy()
}
```

=== 3. Actualización de la UI con Conteo Real

En el `BroadcastReceiver` de `PantallaSincronizacion`, se procesan los datos reales reportados por el servicio:

```kotlin
val revisados = intent?.getIntExtra("edificios_revisados", 0) ?: 0
val cantidad = intent?.getIntExtra("edificios_actualizados", 0) ?: 0

resultado = if (revisados == 0) {
    "Sin edificios pendientes de sincronizar"
} else {
    "Sincronización completa: $cantidad de $revisados edificios actualizados"
}
```

=== Evidencias

#figure(
  grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 0.6em,
    align: horizon + center,
    image("../../img/propuestos/01-antes.png", width: 100%),
    image("../../img/propuestos/02-en-curso.png", width: 100%),
    image("../../img/propuestos/03-despues.png", width: 100%),
    image("../../img/propuestos/04-sin-pendientes.png", width: 100%),
  ),
  caption: [Ciclo de vida y sincronización real con Room: (a) 4 edificios pendientes, (b) sincronización en curso con indicador y botón de detención, (c) primera sincronización (4 de 4 actualizados), y (d) segunda sincronización sin registros pendientes.],
)


]
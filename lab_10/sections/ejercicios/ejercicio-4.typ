= 4. Investiga qué son los WorkManager de Android y explica en el informe en qué casos convendría usar WorkManager en lugar de un Service iniciado manualmente para esta misma tarea de sincronización.

#pad(1.1em)[

*WorkManager* (`androidx.work`) es la biblioteca de Android Jetpack para ejecutar *trabajo en segundo plano diferible y garantizado*. A diferencia de un `Service` manual (que corre en la memoria RAM y muere al cerrarse la app), WorkManager persiste las tareas en SQLite interno, reprogramándolas incluso tras reiniciar el dispositivo o bajo políticas de ahorro energético (*Doze Mode*).

#table(
  columns: (1fr, 1.4fr, 1.5fr),
  align: (left, left, left),
  table.header([*Criterio*], [*Service Manual (`startService`)*], [*WorkManager (`androidx.work`)*]),
  [Disparo y Momento], [Manual e inmediato desde la UI (tiempo real)], [Diferible; programado según condiciones del sistema],
  [Persistencia / Reinicio], [Efímero; se pierde al cerrar la app o reiniciar], [Garantizado; persiste en SQLite interno tras reinicios],
  [Restricciones], [Verificación manual imperativa en código], [Declarativas (`Constraints`: red Wi-Fi, batería, carga)],
  [Gestión de Fallos], [Manual; requiere lógica de reintento propia], [Reintentos automáticos con política de *backoff*],
  [Propósito Idóneo], [Interacción en pantalla con respuesta inmediata], [Sincronización periódica o diferida desatendida],
)

*Criterio de decisión para la sincronización de edificios (Lab 10):*
- *¿Cuándo convendría WorkManager?* Si Room debe actualizarse de forma periódica (p. ej., cada 12 h sin abrir la app), con red Wi-Fi obligatoria (`NetworkType.UNMETERED`), reintentos automáticos con *backoff* y garantía de ejecución tras reinicios.
- *¿Por qué se mantiene el Service en el laboratorio?* Porque la tarea es interactiva: el usuario pulsa *"Sincronizar"* esperando feedback visual instantáneo (spinner, progreso y botón *"Detener"*). WorkManager es diferible y no garantiza ejecución inmediata en la UI.

#figure(
  image("../../img/propuestos/ejercicio-4-workmanager.svg", width: 62%),
  caption: [Service manual (ejecución efímera en RAM) vs. WorkManager (persistencia en SQLite con ejecución condicionada).],
)

*Implementación de referencia con Room:*

```kotlin
// Worker con Room, reintentos con backoff y programación periódica con restricciones
class SyncWorker(ctx: Context, p: WorkerParameters) : CoroutineWorker(ctx, p) {
    override suspend fun doWork(): Result = try {
        val dao = DatabaseProvider.obtener(applicationContext).edificioDao()
        dao.obtenerPendientes().forEach { dao.marcarSincronizado(it.id, System.currentTimeMillis()) }
        Result.success()
    } catch (e: Exception) { Result.retry() }
}
val req = PeriodicWorkRequestBuilder<SyncWorker>(6, TimeUnit.HOURS)
    .setConstraints(Constraints.Builder().setRequiredNetworkType(NetworkType.CONNECTED).build()).build()
WorkManager.getInstance(context).enqueueUniquePeriodicWork("sync_edificios", ExistingPeriodicWorkPolicy.KEEP, req)
```

]
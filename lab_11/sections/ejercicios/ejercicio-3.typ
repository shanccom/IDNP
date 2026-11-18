== 3. Usando Room (Laboratorio 09), guarda cuál fue el último edificio reproducido. Cuando se abra la app de nuevo, muestra un botón "Continuar" que retome ese edificio.

== Desarrollo

#pad(1.1em)[

Para conservar el último edificio reproducido se reutilizó Room, con una entidad `UltimoEdificioEntity` de clave fija, un `@Dao` de funciones `suspend` y una base de datos expuesta por el singleton `AudioGuiaDatabaseProvider`. La configuración incluyó el plugin KSP y las dependencias `room-runtime`, `room-ktx` y `room-compiler` en Gradle.

El servicio guarda el nombre cada vez que se inicia la reproducción o se cambia de edificio, y `MainActivity` lo consulta al abrir la app o al volver a primer plano. Si existe un registro, la pantalla muestra el texto *"Último edificio reproducido: ..."* y habilita el botón *"Continuar"*, que ubica el índice en `EDIFICIOS_LAB08` y relanza el audio con `ACCION_REPRODUCIR`.

El flujo se validó en el emulador reproduciendo un edificio, cerrando la app desde la multitarea y comprobando que el botón reaparece con el elemento correcto. La tabla se limita al registro `id = 1` y usa `OnConflictStrategy.REPLACE`, por lo que cada guardado sobrescribe el anterior. Las consultas se ejecutan en `Dispatchers.IO` para no bloquear el hilo principal, y el nombre se valida contra el catálogo antes de mostrar el botón.

=== Implementación de Código

*1. Entidad y DAO con Room (`UltimoEdificioRoom.kt`):*

```kotlin
@Entity(tableName = "ultimo_edificio")
data class UltimoEdificioEntity(
    @PrimaryKey val id: Int = 1,
    val nombre: String
)

@Dao
interface UltimoEdificioDao {

    @Query("SELECT nombre FROM ultimo_edificio WHERE id = 1 LIMIT 1")
    suspend fun obtenerNombre(): String?
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun guardar(ultimo: UltimoEdificioEntity)
}
```

*2. Persistencia en hilo secundario desde el servicio (`AudioGuiaService.kt`):*

```kotlin
private fun guardarUltimoEdificio() {
    val nombre = EDIFICIOS_LAB08[indiceEdificio]
    CoroutineScope(Dispatchers.IO).launch {
        AudioGuiaDatabaseProvider.obtener(applicationContext)
            .ultimoEdificioDao()
            .guardar(UltimoEdificioEntity(nombre = nombre))
    }
}
```

*3. Botón "Continuar" en Jetpack Compose (`MainActivity.kt`):*

```kotlin
Button(onClick = {
    indiceEdificio = EDIFICIOS_LAB08.indexOf(edificioParaContinuar)
    context.startService(
        Intent(context, AudioGuiaService::class.java)
            .setAction(AudioGuiaService.ACCION_REPRODUCIR)
            .putExtra(AudioGuiaService.EXTRA_EDIFICIO, edificioParaContinuar)
    )
}) {
    Text("Continuar")
}
```

=== Evidencias de Ejecución

A continuación se ilustra la prueba de persistencia realizada en el emulador, evidenciando el guardado, la persistencia tras el cierre y la reanudación:

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  figure(
    image("../../img/propuesto/ejercicio-3.1.png", width: 85%),
    caption: [1. Reproducción activa y guardado en Room.]
  ),
  figure(
    image("../../img/propuesto/ejercicio-3.2.png", width: 85%),
    caption: [2. Reapertura: visualización de "Continuar".]
  ),
  figure(
    image("../../img/propuesto/ejercicio-3.3.png", width: 85%),
    caption: [3. Reanudación exitosa del edificio guardado.]
  )
)
]

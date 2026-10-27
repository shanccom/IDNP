= 2. Implementa el modelo completo con Room: las 3 entidades, sus claves foráneas, y el Dao correspondiente con \@Insert, \@Update y \@Delete para las 3 tablas.

== 1. Definición de la entidad `NotaEntity`

Se implementa la tercera entidad vinculada a `AmbienteEntity` mediante una clave foránea (`ForeignKey`):

```kotlin
@Entity(
    foreignKeys = [
        ForeignKey(
            entity = AmbienteEntity::class,
            parentColumns = ["id"],
            childColumns = ["ambienteId"]
        )
    ]
)
data class NotaEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,
    val ambienteId: Int,
    val texto: String
)
```

== 2. Operaciones CRUD en `EdificioDao`

Se incorporan los métodos de inserción, actualización y eliminación para las tres tablas:

```kotlin
@Dao
interface EdificioDao {
    // --- INSERT (3 tablas) ---
    @Insert suspend fun insertarEdificio(edificio: EdificioEntity): Long
    @Insert suspend fun insertarAmbiente(ambiente: AmbienteEntity)
    @Insert suspend fun insertarNota(nota: NotaEntity): Long

    // --- UPDATE (3 tablas) ---
    @Update suspend fun actualizarEdificio(edificio: EdificioEntity)
    @Update suspend fun actualizarAmbiente(ambiente: AmbienteEntity)
    @Update suspend fun actualizarNota(nota: NotaEntity)

    // --- DELETE (3 tablas) ---
    @Delete suspend fun eliminarEdificio(edificio: EdificioEntity)
    @Delete suspend fun eliminarAmbiente(ambiente: AmbienteEntity)
    @Delete suspend fun eliminarNota(nota: NotaEntity)
}
```

== 3. Registro en `AppDatabase`

Se incorpora `NotaEntity` al arreglo de entidades de Room:

```kotlin
@Database(
    entities = [
        EdificioEntity::class,
        AmbienteEntity::class,
        NotaEntity::class // <-- Agregada aquí
    ],
    version = 1,
    exportSchema = false
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun edificioDao(): EdificioDao
}
```

== Resumen de aspectos clave

- *Entidad `NotaEntity`:* Incorpora clave primaria autogenerada (`id`) y clave foránea (`ambienteId` $arrow.r$ `AmbienteEntity.id`).
- *DAO unificado:* Expone operaciones CRUD completas (`@Insert`, `@Update`, `@Delete`) para `EdificioEntity`, `AmbienteEntity` y `NotaEntity`.
- *Esquema Room:* Inclusión de `NotaEntity::class` dentro del arreglo `entities` de `AppDatabase`.

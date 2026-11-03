= 3. Realiza una segunda consulta relacional (por ejemplo, obtener un AmbienteEntity junto con su List\<NotaEntity> mediante \@Embedded/\@Relation), distinta a la implementada en el ejercicio resuelto

#pad(1.5em)[
== 3.1. Clase de relación POJO: `AmbienteConNotas`

Se define la clase intermedia para modelar el vínculo 1 a muchos entre `AmbienteEntity` y `NotaEntity`:

```kotlin
data class AmbienteConNotas(
    @Embedded
    val ambiente: AmbienteEntity,

    @Relation(
        parentColumn = "id",
        entityColumn = "ambienteId"
    )
    val notas: List<NotaEntity>
)
```

- *`@Embedded`:* Incrusta la entidad padre `AmbienteEntity`.
- *`@Relation`:* Establece el enlace 1 a muchos conectando la columna primaria `id` de `AmbienteEntity` con la clave foránea `ambienteId` de `NotaEntity`.

== 3.2. Método de consulta en el DAO: `EdificioDao`

Se agrega el método relacional con transacción atómica garantizada:

```kotlin
@Transaction
@Query("SELECT * FROM AmbienteEntity")
suspend fun obtenerAmbientesConNotas(): List<AmbienteConNotas>
```

- *`@Transaction`:* Garantiza la consistencia atómica de la lectura para que Room ejecute la consulta del padre y las consultas de relación hijas en una sola transacción.
- *`@Query`:* Consulta la tabla `AmbienteEntity` y Room rellena automáticamente la lista `notas` asociada a cada ambiente.

]
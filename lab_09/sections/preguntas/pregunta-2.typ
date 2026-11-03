= 2. ¿Qué otra alternativa de almacenamiento (además de Room) se podría emplear en una aplicación con necesidades similares? Justifica tu respuesta comparando ventajas y desventajas frente a Room.
#pad(1.5em)[
*Respuesta:*

Para una aplicación con necesidades relacionales (persistencia de entidades vinculadas 1:N, operaciones CRUD e integración reactiva con Jetpack Compose), las principales alternativas serian:

== 1. SQLDelight

Es la alternativa relacional más destacada frente a Room en Kotlin:
- *Enfoque:* A diferencia de Room, donde las anotaciones Kotlin generan el esquema SQL @room, en SQLDelight se escribe SQL estándar y el plugin genera código Kotlin con verificación en tiempo de compilación @sqldelight.
- *Ventajas frente a Room:* Soporte nativo para Kotlin Multiplatform (KMP), permitiendo reutilizar la capa de datos en Android, iOS, Desktop y Backend @sqldelight; permitiendonos control absoluto y transparente sobre las sentencias SQL ejecutadas.
- *Desventajas frente a Room:* Carece de abstracciones automáticas de conveniencia como las anotaciones relacionales `\@Embedded` y `\@Relation` de Room; menor ecosistema de extensiones directas dentro de Google Jetpack.

== 2. Realm / Atlas Device SDK (Base de datos NoSQL orientada a objetos)

- *Enfoque:* Es un motor de persistencia orientado a objetos que almacena instancias directamente sin necesidad de mapeo objeto-relacional (ORM).
- *Ventajas frente a Room:* Alto rendimiento en transacciones y consultas sobre grafos de objetos complejos; sincronización reactiva integrada con la UI sin pasar por SQLite.
- *Desventajas frente a Room:* MongoDB declaró obsoletos los Atlas Device SDK desde septiembre de 2024 y terminó su soporte el 30 de septiembre de 2025 @mongodb, lo que lo vuelve una opción riesgosa para proyectos nuevos; además incrementa el tamaño final del APK debido a sus bibliotecas nativas C++ y es menos flexible si se requieren consultas analíticas complejas o migraciones estándar SQL.

== 3. Tabla comparativa frente a Room

#table(
  columns: (1.2fr, 2fr, 2fr),
  align: (left + horizon, left, left),
  table.header([*Mecanismo*], [*Ventajas frente a Room*], [*Desventajas frente a Room*]),
  [*SQLDelight*], [Multiplataforma nativo (KMP), tipado estricto a partir de SQL puro @sqldelight, sin overhead de KSP.], [Requiere escribir todo el SQL a mano @sqldelight; sin anotaciones automáticas 1:N.],
  [*Realm (Atlas)*], [Elimina el mapeo relacional (ORM); consultas orientadas a objetos muy veloces.], [Binarios C++ pesados en el APK; SDK obsoleto y sin soporte desde el 30/09/2025 @mongodb.],
  [*DataStore (Proto)*], [Transaccional, liviano, sin overhead de SQLite para configuraciones @datastore.], [No soporta integridad referencial (claves foráneas) ni actualizaciones parciales @datastore.]
)

En conclusion para desarrollo exclusivo en Android con Jetpack Compose, *Room* sigue siendo la opción óptima por su soporte oficial en AndroidX, estabilidad de migraciones y verificación estática de consultas @room. En cambio si el proyecto requiriera evolucionar hacia Kotlin Multiplatform para compartir lógica con iOS, *SQLDelight* sería el reemplazo idóneo @sqldelight.


]
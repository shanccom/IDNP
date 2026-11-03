= EJERCICIOS PROPUESTOS

Amplía el modelo del ejercicio resuelto a al menos 3 tablas para almacenar la información de las edificaciones en una base de datos:

= 1. Diseña el diagrama del modelo de datos agregando una tercera entidad NotaEntity(id, ambienteId, texto) relacionada uno-a-muchos con AmbienteEntity (un ambiente puede tener varias notas).

#figure(
  image("../../img/ejercicio-1.png", width: 35%),
  caption: [Diagrama del modelo de datos con la incorporación de la entidad `NotaEntity`.],
)

== ¿Qué cambios se hicieron en el modelo?

- *Incorporación de la entidad `NotaEntity`:*
  - `id`: Clave primaria (PK) autogenerada para identificar de forma unívoca cada nota.
  - `ambienteId`: Clave foránea (FK) vinculada a la clave primaria `id` de `AmbienteEntity`.
  - `texto`: Campo de tipo texto para el contenido de la nota.

-  *Definición de la relación uno a muchos (1:N):*
  - `AmbienteEntity` $arrow.r$ `NotaEntity`: Un ambiente puede tener asociadas cero o múltiples notas (`||--o{`), mientras que cada registro en `NotaEntity` pertenece obligatoriamente a un único ambiente mediante su clave foránea `ambienteId`.

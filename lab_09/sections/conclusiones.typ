== Conclusiones

- Con las clases intermedias y  \@Relation pudimos pedir un edificio con sus ambientes, y un ambiente con sus notas, en una sola consulta. Así la interfaz recibe los datos ya ordenados y no hay que juntarlos a mano.

- Con las claves foráneas y CASCADE, al borrar un edificio se borran solos sus ambientes y sus notas. Nos ahorramos programar esa limpieza en el código y no quedan registros huérfanos.

- Guardar los resultados en un StateFlow y llamar a cargar() después de cada cambio hace que la lista se actualice sola al editar o eliminar. La interfaz solo muestra el estado, y la lógica queda en el ViewModel.

- Como Room revisa las consultas al compilar, errores como un nombre de columna mal escrito o un tipo incorrecto aparecen antes de abrir la app. Eso ahorra tiempo y da confianza al agregar tablas nuevas.

- Al cerrar y volver a abrir la app, los cambios seguían ahí, y el Database Inspector lo confirmó. Además, la base queda en el almacenamiento interno de la app, así que otras aplicaciones no pueden acceder a ella.

== Recomendaciones

- Si las consultas devolvieran Flow en lugar de List, Room avisaría solo cuando algo cambie. Así ya no haría falta llamar a cargar() después de cada operación y habría menos código repetido.

- fallbackToDestructiveMigration() sirve en un laboratorio, pero en una app real borraría los datos del usuario. Lo mejor es escribir una Migration cada vez que se suba la versión.

- Como el CASCADE borra ambientes y notas sin avisar, conviene mostrar un diálogo del tipo «¿Seguro que quieres eliminar?». Así se evitan borrados accidentales con un simple toque.

- Después de modificar entidades o subir la versión, es buena idea abrir el Database Inspector y ver que las tablas y los datos son los esperados. Es una forma rápida de detectar problemas antes de seguir.

- Tener todo en MainActivity.kt funciona para el laboratorio, pero crece rápido. Lo ideal es dividirlo en entidades, Dao, ViewModel y pantallas, para que sea más fácil de leer y mantener.
= 1. ¿Lograste resolver completamente el Ejercicio/Problema Resuelto por el Docente (datos de edificios y ambientes almacenados con Room, que persisten al cerrar y volver a abrir la app)? Adjunta una captura de pantalla del emulador mostrando el resultado como evidencia.

*Respuesta:*

Sí, se completó satisfactoriamente el ejercicio resuelto propuesto por el docente. La arquitectura implementa Room sobre SQLite (`app.db`), persistiendo de forma estructurada las entidades `EdificioEntity` y `AmbienteEntity` vinculadas mediante clave foránea con integridad referencial.

Al ejecutar la aplicación por primera vez, el `EdificiosViewModel` realiza la inserción inicial de los edificios y ambientes de prueba dentro de una corrutina en `viewModelScope`. La interfaz desarrollada en Jetpack Compose observa el flujo `StateFlow` expuesto por el método relacional `obtenerConAmbientes()` para renderizar los datos organizados en una `LazyColumn`.

Para validar la persistencia:
+ Se ejecutó la aplicación y se verificó la correcta carga de los registros en la interfaz.
+ Se cerró completamente el proceso de la aplicación desde la vista multitarea del emulador (forzando su detención).
+ Al volver a abrir la aplicación desde el iniciador de Android, los datos se recuperaron íntegramente desde el almacenamiento local SQLite sin pérdida de información ni duplicación de registros.

#figure(
  image("../../img/resuelto/paso-12.png", width: 28%),
  caption: [Evidencia de ejecución en el emulador Android tras cerrar y reiniciar la aplicación, confirmando la persistencia de los registros en Room.],
)

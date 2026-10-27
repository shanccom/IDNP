= 4. Agrega a la interfaz botones para eliminar y actualizar un edificio o ambiente existente,verificando que los cambios persistan.

Se implementó la funcionalidad completa de actualización y eliminación para edificios y ambientes con un diseño minimalista en Jetpack Compose, asegurando la persistencia y consistencia en SQLite mediante Room.

== 1. Configuración de persistencia e integridad referencial

- *Eliminación en cascada (`ForeignKey.CASCADE`):* Se configuró `onDelete = ForeignKey.CASCADE` en las anotaciones `@ForeignKey` de `AmbienteEntity` y `NotaEntity`. Al eliminar un edificio, SQLite remueve automáticamente sus ambientes asociados, preservando la integridad referencial.
- *Dependencias de UI:* Se agregó `androidx.compose.material:material-icons-core` para disponer de los iconos vectoriales `Icons.Default.Edit` e `Icons.Default.Delete`.

== 2. Métodos CRUD en `EdificiosViewModel`

Se implementaron funciones asíncronas en el ViewModel que ejecutan las operaciones en segundo plano mediante corrutinas y recargan inmediatamente el flujo observable `StateFlow`:

```kotlin
fun actualizarEdificio(edificio: EdificioEntity) {
    viewModelScope.launch { dao.actualizarEdificio(edificio); cargarEdificios() }
}

fun eliminarEdificio(edificio: EdificioEntity) {
    viewModelScope.launch { dao.eliminarEdificio(edificio); cargarEdificios() }
}

fun actualizarAmbiente(ambiente: AmbienteEntity) {
    viewModelScope.launch { dao.actualizarAmbiente(ambiente); cargarEdificios() }
}

fun eliminarAmbiente(ambiente: AmbienteEntity) {
    viewModelScope.launch { dao.eliminarAmbiente(ambiente); cargarEdificios() }
}
```

== 3. Botones de acción en la interfaz (Compose)

Dentro de cada tarjeta `OutlinedCard` de edificio y fila de ambiente se integraron botones interactivos (`IconButton`):

```kotlin
// Acciones para el Edificio
IconButton(onClick = { edificioAEditar = item.edificio }) {
    Icon(Icons.Default.Edit, contentDescription = "Editar", tint = MaterialTheme.colorScheme.primary)
}
IconButton(onClick = { edificioAEliminar = item.edificio }) {
    Icon(Icons.Default.Delete, contentDescription = "Eliminar", tint = MaterialTheme.colorScheme.error)
}

// Acciones para cada Ambiente
IconButton(onClick = { ambienteAEditar = ambiente }) {
    Icon(Icons.Default.Edit, contentDescription = "Editar")
}
IconButton(onClick = { ambienteAEliminar = ambiente }) {
    Icon(Icons.Default.Delete, contentDescription = "Eliminar", tint = MaterialTheme.colorScheme.error)
}
```

== 4. Diálogos modales de edición y confirmación (`AlertDialog`)

La interacción con el usuario se gestiona mediante diálogos de Material 3:

- *Diálogo de edición:* Despliega campos de texto (`OutlinedTextField`) para modificar nombres o categorías, invocando `viewModel.actualizarEdificio(...)` o `viewModel.actualizarAmbiente(...)` al confirmar.
- *Diálogo de eliminación:* Solicita confirmación explícita (advirtiendo sobre la cascada en edificios) y ejecuta `viewModel.eliminarEdificio(...)` o `viewModel.eliminarAmbiente(...)`.

Al confirmar cualquier modificación, Room ejecuta las sentencias SQL (`@Update` o `@Delete`), actualizando de forma reactiva la interfaz sin necesidad de recargar la aplicación manualmente.

== 5. Verificación y pruebas de persistencia en ejecución

A continuación se evidencia la secuencia de validación en el emulador Android, comprobando la interacción con los controles de edición, la confirmación de cambios y la persistencia en Room tras cerrar la aplicación:

#figure(
  grid(
    columns: (1fr, 1fr, 1fr, 1fr),
    gutter: 0.6em,
    align: center,
    [
      #image("../../img/PROPUESTO/1-interfaz-botones.png", width: 100%)
      *(a)* Botones de acción
    ],
    [
      #image("../../img/PROPUESTO/2-dialogo-actualizar.png", width: 100%)
      *(b)* Diálogo de edición
    ],
    [
      #image("../../img/PROPUESTO/3-cierre-app.png", width: 100%)
      *(c)* Cierre de la app
    ],
    [
      #image("../../img/PROPUESTO/4-persistencia-reapertura.png", width: 100%)
      *(d)* Persistencia validada
    ],
  ),
  caption: [Secuencia de verificación de actualización y persistencia en Room: (a) Interfaz con botones de editar y eliminar; (b) Diálogo para renombrar a "Sala de lectura V1"; (c) Salida al launcher para forzar el cierre; (d) Reapertura de la aplicación con los cambios persistidos.],
)

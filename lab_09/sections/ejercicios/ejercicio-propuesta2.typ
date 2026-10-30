
#let captura(caption, ruta: none, width: 50%) = figure(
  if type(ruta) == array {
    align(center, block(width: 75%, grid(
      columns: (1fr, 1fr),
      gutter: 0.8em,
      ..ruta.map(r => image(r, width: 100%))
    )))
  } else if ruta == none {
    align(center, rect(
      width: 50%,
      height: 4cm,
      stroke: 0.5pt + gray,
      radius: 2pt,
    )[#align(center + horizon)[_Captura de pantalla pendiente_]])
  } else {
    image(ruta, width: width)
  },
  caption: caption,
)


=== 2. Implementa el modelo completo con Room: las 3 entidades, sus claves foráneas, y el Dao correspondiente con \@Insert, \@Update y \@Delete para las 3 tablas
#pad(1.5em)[

Creé NotaEntity con una clave foránea hacia AmbienteEntity. Me di cuenta que si quiero borrar un edificio, la base no me dejaria mientras tenga ambientes, así que agregué onDelete = ForeignKey.CASCADE en las dos claves foráneas. Esto hace que al borrar un edificio se borran sus ambientes y sus notas. 

En el Dao se coloco \@Insert, \@Update y \@Delete para las tres tablas. Además, insertarAmbiente ahora devuelve el Long del id, igual que insertarEdificio, para poder usarlo al insertar las notas.

Por último, actualicé el ViewModel para que los datos de muestra incluyan 4 notas. La pantalla sigue igual que en el ejercicio resuelto; lo que cambia es lo que hay en la base, y eso lo comprobé con el Database Inspector.

*Código agregado (`MainActivity.kt`):*

```kotlin
// Nuevo import
import androidx.room.Index

@Entity(
    foreignKeys = [
        ForeignKey(
            entity = AmbienteEntity::class,
            parentColumns = ["id"],
            childColumns = ["ambienteId"],
            onDelete = ForeignKey.CASCADE
        )
    ],
    indices = [Index("ambienteId")]
)
data class NotaEntity(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val ambienteId: Int,
    val texto: String
)

// En AmbienteEntity: se agregó onDelete = CASCADE e indices = [Index("edificioId")]

// Dao: operaciones para las 3 tablas
@Insert suspend fun insertarAmbiente(ambiente: AmbienteEntity): Long
@Insert suspend fun insertarNota(nota: NotaEntity)

@Update suspend fun actualizarAmbiente(ambiente: AmbienteEntity)
@Update suspend fun actualizarNota(nota: NotaEntity)

@Delete suspend fun eliminarAmbiente(ambiente: AmbienteEntity)
@Delete suspend fun eliminarNota(nota: NotaEntity)

// AppDatabase: tres entidades y versión 2
@Database(
    entities = [EdificioEntity::class, AmbienteEntity::class, NotaEntity::class],
    version = 2
)

// crearBaseDeDatos(): se recrean las tablas si cambia el esquema
Room.databaseBuilder(context, AppDatabase::class.java, "app.db")
    .fallbackToDestructiveMigration()
    .build()

// EdificiosViewModel: datos de muestra con notas
dao.insertarNota(NotaEntity(ambienteId = sala, texto = "Se reserva los martes"))
dao.insertarNota(NotaEntity(ambienteId = sala, texto = "Faltan sillas"))
dao.insertarNota(NotaEntity(ambienteId = hemeroteca, texto = "Abierta solo en la mañana"))
dao.insertarNota(NotaEntity(ambienteId = laboratorio, texto = "El proyector no funciona"))
```


  #captura(
    ruta: "/assets/image.png",
    width: 85%,
  )[Database Inspector con las tres tablas de `app.db`.]
]
== 3. Realiza una segunda consulta relacional (por ejemplo, obtener un AmbienteEntity junto con su List\<NotaEntity> mediante \@Embedded/\@Relation), distinta a la implementada en el ejercicio resuelto.
#pad(1.5em)[
Para la segunda consulta se realizo de la manera que se desarrollo el ejercicio resuelto. Creé la clase AmbienteConNotas, que tiene un \@Embedded con el ambiente y un \@Relation con la lista de notas que tienen su id como ambienteId. Luego agregué al Dao obtenerAmbientesConNotas() con \@Transaction y `@Query("SELECT * FROM AmbienteEntity")`. 

En el ViewModel añadí un segundo StateFlow y una función cargar() para las dos consultas, para que se pueda reutilizar. 

*Código agregado (`MainActivity.kt`):*

```kotlin
// Clase intermedia de la segunda consulta
data class AmbienteConNotas(
    @Embedded val ambiente: AmbienteEntity,
    @Relation(
        parentColumn = "id",
        entityColumn = "ambienteId"
    )
    val notas: List<NotaEntity>
)

// Dao
@Transaction
@Query("SELECT * FROM AmbienteEntity")
suspend fun obtenerAmbientesConNotas(): List<AmbienteConNotas>

// EdificiosViewModel
private val _ambientes = MutableStateFlow<List<AmbienteConNotas>>(emptyList())
val ambientes: StateFlow<List<AmbienteConNotas>> = _ambientes

private suspend fun cargar() {
    _edificios.value = dao.obtenerConAmbientes()
    _ambientes.value = dao.obtenerAmbientesConNotas()
}

// ListaEdificiosConAmbientes: segunda sección de la lista
val ambientes by viewModel.ambientes.collectAsState()

items(ambientes, key = { "a-${it.ambiente.id}" }) { conNotas ->
    Column(modifier = Modifier.padding(vertical = 8.dp)) {
        Text(
            text = conNotas.ambiente.nombre,
            fontWeight = FontWeight.Bold,
            fontSize = 18.sp
        )
        conNotas.notas.forEach { nota ->
            Text(text = "• ${nota.texto}", fontSize = 14.sp)
        }
    }
}
```

#captura(
    ruta: "/assets/image-1.png",
    width: 40%,
  )[Consulta 1 con edificios con sus ambientes. Consulta 2, ambientes con sus notas ]

]
== 4.  Agrega a la interfaz botones para eliminar y actualizar un edificio o ambiente existente, verificando que los cambios persistan.
#pad(1.5em)[
Para el último punto agregué los botones de «Editar» y «Eliminar» en cada edificio y en cada ambiente. 
- «Eliminar» llama directo a una función del ViewModel. 
- «Editar» abre un cuadro de diálogo (`AlertDialog`) con un campo de texto donde se escribe el nuevo nombre.

Se realizo un solo composable DialogoEditar y lo reutilicé para edificios y ambientes. Para saber qué elemento se está editando se guarda dos estados (edificioEditando y ambienteEditando)

En el ViewModel agregué cuatro funciones: renombrarEdificio, eliminarEdificio, renombrarAmbiente y eliminarAmbiente. Todas siguen el mismo patron: modifican la base con el Dao dentro de una coroutine y después llaman a cargar() para que las dos listas se actualicen en pantalla. Gracias al `CASCADE` del paso 2, al eliminar un edificio también desaparecen sus ambientes y sus notas, y se nota en la consulta 2. Para comprobar la persistencia cerré la aplicación y la volví a abrir, y también revisé el Database Inspector.

*Código agregado (`MainActivity.kt`):*

```kotlin
// Nuevos imports
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.TextButton

// EdificiosViewModel: operaciones que modifican la base y recargan las consultas
fun renombrarEdificio(edificio: EdificioEntity, nuevoNombre: String) {
    viewModelScope.launch {
        dao.actualizarEdificio(edificio.copy(nombre = nuevoNombre))
        cargar()
    }
}

fun eliminarEdificio(edificio: EdificioEntity) {
    viewModelScope.launch {
        dao.eliminarEdificio(edificio)
        cargar()
    }
}
// renombrarAmbiente() y eliminarAmbiente() son iguales, con el Dao de ambientes

// Cuadro de diálogo reutilizable
@Composable
fun DialogoEditar(
    titulo: String,
    valorInicial: String,
    onGuardar: (String) -> Unit,
    onCancelar: () -> Unit
) {
    var texto by remember { mutableStateOf(valorInicial) }
    AlertDialog(
        onDismissRequest = onCancelar,
        title = { Text(titulo) },
        text = { OutlinedTextField(value = texto, onValueChange = { texto = it }, singleLine = true) },
        confirmButton = {
            TextButton(onClick = { if (texto.isNotBlank()) onGuardar(texto.trim()) }) { Text("Guardar") }
        },
        dismissButton = { TextButton(onClick = onCancelar) { Text("Cancelar") } }
    )
}

// ListaEdificiosConAmbientes: qué se está editando y los botones de cada fila
var edificioEditando by remember { mutableStateOf<EdificioEntity?>(null) }
var ambienteEditando by remember { mutableStateOf<AmbienteEntity?>(null) }

edificioEditando?.let { edificio ->
    DialogoEditar(
        titulo = "Editar edificio",
        valorInicial = edificio.nombre,
        onGuardar = { nuevo ->
            viewModel.renombrarEdificio(edificio, nuevo)
            edificioEditando = null
        },
        onCancelar = { edificioEditando = null }
    )
}

// En la fila de cada edificio (y de forma similar en cada ambiente)
TextButton(onClick = { edificioEditando = conAmbientes.edificio }) { Text("Editar") }
TextButton(onClick = { viewModel.eliminarEdificio(conAmbientes.edificio) }) { Text("Eliminar") }
```

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  captura(
    ruta: "/assets/image-2.png",
    width: 80%,
  )[Lista con los botones «Editar» y «Eliminar».],
  captura(
    ruta: "/assets/image-3.png",
    width: 80%,
  )[Cuadro de diálogo para escribir el nuevo nombre.],
  captura(
    ruta: "/assets/image-4.png",
    width: 80%,
  )[El nombre ya aparece actualizado en la lista.],
)

#grid(
  columns: (1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  captura(
    ruta: "/assets/image-5.png",
    width: 60%,
  )[Después de eliminar un ambiente  desaparecen también sus notas.],
  captura(
    ruta: "/assets/image-6.png",
    width: 60%,
  )[Al cerrar y volver a abrir la aplicación, los cambios se mantienen.],
  
)

#captura(
    ruta: "/assets/image-7.png",
    width: 85%,
  )[ Database Inspector confirma los cambios en las tablas.]

]
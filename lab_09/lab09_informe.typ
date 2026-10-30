
// =====================================================================
// PARTE B: ejercicios propuestos (pegar después del ejercicio resuelto)
// =====================================================================

= Ejercicio propuesto: modelo de tres tablas para las edificaciones

== Enunciado

Amplía el modelo del ejercicio resuelto a al menos 3 tablas para almacenar la información de las edificaciones en una base de datos:
+ Diseña el diagrama del modelo de datos agregando una tercera entidad `NotaEntity(id, ambienteId, texto)` relacionada uno-a-muchos con `AmbienteEntity` (un ambiente puede tener varias notas).
+ Implementa el modelo completo con Room: las 3 entidades, sus claves foráneas, y el Dao correspondiente con `@Insert`, `@Update` y `@Delete` para las 3 tablas.
+ Realiza una segunda consulta relacional (por ejemplo, obtener un `AmbienteEntity` junto con su `List<NotaEntity>` mediante `@Embedded`/`@Relation`), distinta a la implementada en el ejercicio resuelto.
+ Agrega a la interfaz botones para eliminar y actualizar un edificio o ambiente existente, verificando que los cambios persistan.

*Entregable:* informe con el diagrama de las 3 tablas, y capturas de las dos consultas relacionales funcionando.

== Desarrollo paso a paso

=== Propuesta 1

// >>> Aquí va el desarrollo del Integrante 1 <<<

=== Propuesta 2

==== Paso 1: Diagrama del modelo de datos

Antes de escribir código dibujé el modelo para tenerlo claro. Ya existían `EdificioEntity` y `AmbienteEntity` (un edificio tiene varios ambientes), y la tercera tabla, `NotaEntity`, cuelga de `AmbienteEntity` de la misma forma: cada nota guarda el `ambienteId` del ambiente al que pertenece. Así quedan dos relaciones uno-a-muchos en cadena: edificio → ambientes → notas.

#let tabla(nombre, campos) = rect(
  width: 100%,
  inset: 8pt,
  radius: 4pt,
  stroke: 0.8pt,
)[
  #align(center)[*#nombre*]
  #line(length: 100%, stroke: 0.5pt)
  #align(left)[#for c in campos [#c \ ]]
]

#figure(
  grid(
    columns: (1fr, auto, 1fr, auto, 1fr),
    column-gutter: 0.6em,
    align: horizon + center,
    tabla("EdificioEntity", ("id (PK)", "nombre", "categoria")),
    [1 : N \ #sym.arrow.r],
    tabla("AmbienteEntity", ("id (PK)", "edificioId (FK)", "nombre")),
    [1 : N \ #sym.arrow.r],
    tabla("NotaEntity", ("id (PK)", "ambienteId (FK)", "texto")),
  ),
  caption: [Paso 1: diagrama del modelo de datos con las tres tablas y sus relaciones uno-a-muchos.]
)

==== Paso 2: Crear `NotaEntity` y completar el Dao

Creé `NotaEntity` con una clave foránea hacia `AmbienteEntity`. Al hacerlo noté dos cosas que no estaban en el ejercicio resuelto. La primera es que, si luego quiero borrar un edificio, la base no me deja mientras tenga ambientes (da error de `FOREIGN KEY constraint failed`), así que agregué `onDelete = ForeignKey.CASCADE` en las dos claves foráneas: al borrar un edificio se borran sus ambientes y sus notas. La segunda es que Room avisa si la clave foránea no tiene índice, por eso añadí `indices = [Index(...)]`.

En el Dao puse `@Insert`, `@Update` y `@Delete` para las tres tablas. Además, `insertarAmbiente` ahora devuelve el `Long` del id, igual que `insertarEdificio`, para poder usarlo al insertar las notas.

Como el esquema cambió, subí `version` de la base de datos a 2 y agregué `fallbackToDestructiveMigration()`, que recrea las tablas en lugar de fallar (para un laboratorio no importa perder los datos de prueba). Por último, actualicé el ViewModel para que los datos de muestra incluyan 4 notas. La pantalla sigue igual que en el ejercicio resuelto; lo que cambia es lo que hay en la base, y eso lo comprobé con el Database Inspector.

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

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  captura(
    ruta: "../../img/propuestos/p2-2-1.png",
    width: 85%,
  )[Paso 2 (a): la aplicación sigue mostrando los edificios y sus ambientes.],
  captura(
    ruta: "../../img/propuestos/p2-2-2.png",
    width: 85%,
  )[Paso 2 (b): Database Inspector con las tres tablas de `app.db`.],
  captura(
    ruta: "../../img/propuestos/p2-2-3.png",
    width: 85%,
  )[Paso 2 (c): contenido de `NotaEntity` con las 4 notas insertadas.],
)

==== Paso 3: Segunda consulta relacional (ambiente con sus notas)

Para la segunda consulta seguí el mismo patrón que la del ejercicio resuelto, pero un nivel más abajo. Creé la clase `AmbienteConNotas`, que tiene un `@Embedded` con el ambiente y un `@Relation` con la lista de notas que tienen su `id` como `ambienteId`. Luego agregué al Dao `obtenerAmbientesConNotas()` con `@Transaction` y `@Query("SELECT * FROM AmbienteEntity")`. Se le pone `@Transaction` porque Room hace dos consultas por detrás (ambientes y notas) y así se aseguran de leerse juntas.

En el ViewModel añadí un segundo `StateFlow` (`ambientes`) y una función `cargar()` que pide las dos consultas, de modo que después la pueda reutilizar. En la pantalla dividí la `LazyColumn` en dos secciones: la consulta 1 (edificios con ambientes) y la consulta 2 (ambientes con notas). Una cosa que me dio problema: las `key` de las dos listas se repetían (ambas tienen ids 1, 2, 3...) y `LazyColumn` no permite claves duplicadas, así que les puse un prefijo (`"e-"` y `"a-"`).

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

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5em,
  align: horizon + center,
  captura(
    ruta: "../../img/propuestos/p2-3-1.png",
    width: 70%,
  )[Paso 3 (a): consulta 1, edificios con sus ambientes.],
  captura(
    ruta: "../../img/propuestos/p2-3-2.png",
    width: 70%,
  )[Paso 3 (b): consulta 2, ambientes con sus notas (al hacer scroll).],
)

==== Paso 4: Botones para editar y eliminar

Para el último punto agregué un botón «Editar» y otro «Eliminar» en cada edificio y en cada ambiente. «Eliminar» llama directo a una función del ViewModel. «Editar» abre un cuadro de diálogo (`AlertDialog`) con un campo de texto donde se escribe el nuevo nombre; hice un solo composable `DialogoEditar` y lo reutilicé para edificios y ambientes. Para saber qué elemento se está editando guardo dos estados (`edificioEditando` y `ambienteEditando`): si valen `null` no se muestra ningún diálogo.

En el ViewModel agregué cuatro funciones (`renombrarEdificio`, `eliminarEdificio`, `renombrarAmbiente` y `eliminarAmbiente`). Todas siguen el mismo esquema: modifican la base con el Dao dentro de una coroutine y después llaman a `cargar()` para que las dos listas se actualicen en pantalla. Gracias al `CASCADE` del paso 2, al eliminar un edificio también desaparecen sus ambientes y sus notas, y se nota en la consulta 2. Para comprobar la persistencia cerré la aplicación y la volví a abrir, y también revisé el Database Inspector. Una aclaración: los datos de muestra solo se insertan cuando la tabla está vacía, así que para la prueba eliminé un solo edificio (si borro todos, al reabrir la app se vuelven a insertar los de muestra).

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
    ruta: "../../img/propuestos/p2-4-1.png",
    width: 85%,
  )[Paso 4 (a): lista con los botones «Editar» y «Eliminar».],
  captura(
    ruta: "../../img/propuestos/p2-4-2.png",
    width: 85%,
  )[Paso 4 (b): cuadro de diálogo para escribir el nuevo nombre.],
  captura(
    ruta: "../../img/propuestos/p2-4-3.png",
    width: 85%,
  )[Paso 4 (c): el nombre ya aparece actualizado en la lista.],
)

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  captura(
    ruta: "../../img/propuestos/p2-4-4.png",
    width: 85%,
  )[Paso 4 (d): después de eliminar un edificio desaparecen también sus ambientes y notas.],
  captura(
    ruta: "../../img/propuestos/p2-4-5.png",
    width: 85%,
  )[Paso 4 (e): al cerrar y volver a abrir la aplicación, los cambios se mantienen.],
  captura(
    ruta: "../../img/propuestos/p2-4-6.png",
    width: 85%,
  )[Paso 4 (f): Database Inspector confirma los cambios en las tablas.],
)

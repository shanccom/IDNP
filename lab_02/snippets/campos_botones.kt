val context = LocalContext.current

var titulo by remember { mutableStateOf("") }
var autor by remember { mutableStateOf("") }
var paginas by remember { mutableStateOf("") }

OutlinedTextField(
    value = titulo,
    onValueChange = { titulo = it },
    label = { Text("Título del libro") }
)

OutlinedTextField(
    value = autor,
    onValueChange = { autor = it },
    label = { Text("Autor") }
)

OutlinedTextField(
    value = paginas,
    onValueChange = { paginas = it },
    label = { Text("Páginas leídas") }
)

Button(onClick = { GuardarDatos(context, titulo, autor, paginas) }) {
    Text("GUARDAR", fontWeight = FontWeight.Bold)
}

Button(onClick = { registro = LeerDatos(context) }) {
    Text("VER REGISTRO", fontWeight = FontWeight.Bold)
}
Card(
    modifier = Modifier.fillMaxWidth(),
    shape = RoundedCornerShape(12.dp),
    elevation = CardDefaults.cardElevation(defaultElevation = 2.dp)
) {
    Column(
        modifier = Modifier
            .padding(16.dp)
            .fillMaxWidth(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        Icon(
            imageVector = Icons.Default.Book,
            contentDescription = "Libro",
            modifier = Modifier.size(48.dp)
        )
        OutlinedTextField(
            value = titulo,
            onValueChange = { titulo = it },
            label = { Text("Título del Libro") },
            modifier = Modifier.fillMaxWidth()
        )
        OutlinedTextField(
            value = autor,
            onValueChange = { autor = it },
            label = { Text("Autor") },
            modifier = Modifier.fillMaxWidth()
        )
    }
}
OutlinedTextField(
    value = paginas,
    onValueChange = { paginas = it },
    label = { Text("Páginas leídas") },
    modifier = Modifier.fillMaxWidth()
)

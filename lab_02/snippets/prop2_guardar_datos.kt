val context = LocalContext.current

// Lógica de guardado al presionar el botón "GUARDAR"
Button(onClick = {
    if (titulo.isNotBlank() && autor.isNotBlank() && paginas.isNotBlank()) {
        val datosAGuardar = "Título: $titulo\nAutor: $autor\nPáginas: $paginas\n"
        try {
            // Escritura en el almacenamiento interno con openFileOutput en modo privado
            context.openFileOutput("registro_libro.txt", Context.MODE_PRIVATE).use { output ->
                output.write(datosAGuardar.toByteArray())
            }
            Toast.makeText(context, "¡Datos guardados con éxito!", Toast.LENGTH_SHORT).show()
        } catch (e: Exception) {
            e.printStackTrace()
            Toast.makeText(context, "Error al guardar el archivo", Toast.LENGTH_SHORT).show()
        }
    } else {
        Toast.makeText(context, "Por favor complete todos los campos", Toast.LENGTH_SHORT).show()
    }
}) {
    Text("GUARDAR")
}

// Validación de los campos y estructuración de los datos a guardar
if (titulo.isNotBlank() && autor.isNotBlank() && paginas.isNotBlank()) {
    val datosAGuardar = "Título: $titulo\nAutor: $autor\nPáginas: $paginas\n"
    // Escritura en el archivo...
} else {
    Toast.makeText(context, "Por favor complete todos los campos", Toast.LENGTH_SHORT).show()
}

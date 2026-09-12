// Escritura en almacenamiento interno usando openFileOutput en modo MODE_PRIVATE
try {
    context.openFileOutput("registro_libro.txt", Context.MODE_PRIVATE).use { output ->
        output.write(datosAGuardar.toByteArray())
    }
    Toast.makeText(context, "¡Datos guardados con éxito!", Toast.LENGTH_SHORT).show()
} catch (e: Exception) {
    e.printStackTrace()
    Toast.makeText(context, "Error al guardar el archivo", Toast.LENGTH_SHORT).show()
}

// Lógica del botón VER REGISTRO con control de excepciones
OutlinedButton(onClick = {
    try {
        val contenido = context.openFileInput("registro_libro.txt")
            .bufferedReader()
            .use { it.readText() }

        Log.d("RegistroLibro", "Contenido recuperado del archivo:\n$contenido")
        Toast.makeText(context, "Registro enviado a la consola Logcat", Toast.LENGTH_SHORT).show()
    } catch (e: Exception) {
        Log.e("RegistroLibro", "Error al leer el archivo guardado", e)
        Toast.makeText(context, "No se encontró ningún archivo registrado", Toast.LENGTH_SHORT).show()
    }
}) {
    Text("VER REGISTRO")
}

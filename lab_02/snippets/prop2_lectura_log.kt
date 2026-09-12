// Lectura del archivo desde el almacenamiento interno
val contenido = context.openFileInput("registro_libro.txt")
    .bufferedReader()
    .use { it.readText() }

// Imprimir en consola Logcat usando la clase Log (Log.d)
Log.d("RegistroLibro", "Contenido recuperado del archivo:\n$contenido")

// Lectura del archivo y actualización de la variable de estado
val contenido = context.openFileInput("registro_libro.txt")
    .bufferedReader()
    .use { it.readText() }
// Envío a la consola Logcat
Log.d("RegistroLibro", "Contenido recuperado del archivo:\n$contenido")
// Actualización del estado para reflejar los datos en pantalla
contenidoGuardado = contenido

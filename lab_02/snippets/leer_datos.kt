fun LeerDatos(context: Context) {
    val datos = context.openFileInput("datos.txt")
        .bufferedReader()
        .use { it.readText() }

    Log.d(
        tag = "REGISTRO-LIBRO",
        msg = datos
    )
}
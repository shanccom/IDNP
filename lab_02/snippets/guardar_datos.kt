fun GuardarDatos(
    context: Context,
    titulo: String,
    autor: String,
    paginas: String,
) {
    val datos = "Titulo: $titulo Autor: $autor paginas: $paginas".trimIndent()

    context.openFileOutput(
        "datos.txt",
        Context.MODE_PRIVATE
    ).use { archivo ->
        archivo.write(datos.toByteArray())
    }
}
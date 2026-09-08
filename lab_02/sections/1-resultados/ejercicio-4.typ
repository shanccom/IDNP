#import "../../components/code-block.typ": code-block

== Ejercicio 4: Al presionar "Ver registro", leer el archivo guardado y mostrar su contenido por consola empleando la clase Log (Log.d).

#pad(1.1em)[
  Al presionar el botón "Ver registro" se ejecuta `LeerDatos(context)`, que abre el archivo `datos.txt` con `context.openFileInput("datos.txt")`, lee su contenido mediante `bufferedReader()` y `use { it.readText() }`. El texto leído se muestra por consola empleando la clase `Log` con `Log.d(tag = "REGISTRO-LIBRO", msg = datos)`.

  #v(0.5em)

  #code-block(
    file: "snippets/leer_datos.kt",
    lang: "kotlin",
    fill: rgb("#EFF3FA"),
    radius: 12pt,
    inset: 1.2em,
    text-size: 8pt,
  )
  #v(0.5em)

  Al ejecutar el proyecto y presionar "Ver registro", el contenido del archivo aparece en el Logcat con la etiqueta `REGISTRO-LIBRO`:

  #figure(
    image("../../img/VerRegistro en consola.png", width: 80%),
    caption: [Ver Registro en consola],
  ) <ver-registro-consola>
]

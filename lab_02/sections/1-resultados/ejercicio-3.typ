#import "../../components/code-block.typ": code-block

== Ejercicio 3: Al presionar "Guardar", escribir los tres datos ingresados en un archivo de texto plano guardado en el almacenamiento interno de la aplicación (openFileOutput, modo MODE_PRIVATE).

#pad(1.1em)[
  Al presionar el botón "Guardar" se ejecuta `GuardarDatos(context, titulo, autor, paginas)`, que recibe los tres datos capturados en los campos de texto. Dentro de la función se construye la cadena del registro y se usa `context.openFileOutput("datos.txt", Context.MODE_PRIVATE)` para crear (o abrir) el archivo en el almacenamiento interno en modo privado, escribiendo el contenido con `archivo.write(datos.toByteArray())`.

  #v(0.5em)
  #code-block(
    file: "snippets/guardar_datos.kt",
    lang: "kotlin",
    fill: rgb("#EFF3FA"),
    radius: 12pt,
    inset: 1.2em,
    text-size: 8pt,
  )

  #v(0.5em)
  Al ejecutar el proyecto e ingresar los datos, al presionar "Guardar" se crea el archivo `datos.txt` en el almacenamiento interno de la aplicación:

  #figure(
    image("../../img/Func_Guardar_Datos.png", width: 80%),
    caption: [Función Guardar Datos],
  ) <func-guardar-datos>
]

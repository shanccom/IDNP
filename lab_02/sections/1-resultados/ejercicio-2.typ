#import "../../components/code-block.typ": code-block

== Ejercicio 2: Una pantalla (Composable) con tres campos de texto (TextField): título del libro, autor y número de páginas leídas, y dos botones: "Guardar" y "Ver registro".

#pad(1.1em)[
  - Abrir el archivo `MainActivity.kt` y dentro de la función `setContent { }` crear un Composable encargado de mostrar el formulario de registro de lectura.

  - Definir tres variables de estado con `remember` para almacenar el contenido de cada campo: una para el título del libro, una para el autor y otra para el número de páginas leídas.

  - Agregar un `OutlinedTextField` para cada dato ("Título del libro", "Autor" y "Páginas leídas"), enlazando cada uno con su variable de estado mediante los parámetros `value` y `onValueChange`.

  - Debajo de los campos, agregar dos botones: uno con el texto "Guardar" y otro con el texto "Ver registro".

    El siguiente fragmento muestra las variables de estado, los tres `OutlinedTextField` y los dos botones:

    #v(1em)

#code-block(
    file: "snippets/campos_botones.kt",
    lang: "kotlin",
    fill: rgb("#EFF3FA"),
    radius: 12pt,
    inset: 1.2em,
    text-size: 8pt,
  )

    #figure(
      image("../../img/Pantalla con Campos de texto.png", width: 80%),
      caption: [Pantalla con Campos de texto],
    ) <pantalla-campos>

  - Ejecutar el proyecto Run con un emulador o un dispositivo físico conectado y verificar que la pantalla muestra los tres campos de texto y los dos botones, como se observa en la Figura.
]

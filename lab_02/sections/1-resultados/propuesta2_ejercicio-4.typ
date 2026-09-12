#import "../../components/code-block.typ": code-block

== Ejercicio 4: Al presionar "Ver registro", leer el archivo guardado y mostrar su contenido por consola empleando la clase Log (Log.d).

#pad(1.1em)[
  Para este ejercicio se implementó la funcionalidad asociada al botón *"VER REGISTRO"*. Donde se pueda abrir el archivo guardado en el almacenamiento interno privado, leerlo y enviarlo a la consola Logcat utilizando el método `Log.d`, además de gestionar posibles excepciones en caso de que el archivo aún no exista:

  #pad(1.1em)[

  === 1. Lectura del archivo en almacenamiento interno (`openFileInput`) y salida por consola (`Log.d`)

  #pad(1.1em)[
    Se utiliza el método `openFileInput` para abrir el archivo. Se realizo la lectura completa del contenido e imprimir el resultado en la consola mediante `Log.d` usando la etiqueta `"RegistroLibro"`:

    #code-block(
      file: "snippets/prop2_lectura_log.kt",
      lang: "kotlin",
      fill: rgb("#EFF3FA"),
      radius: 12pt,
      inset: 1.2em,
      text-size: 8pt,
    )
  ]

  === 2. Resultado de la consola 

  #pad(1.1em)[
    Se observa la consola despues de presionar ver registro en nuestra interfaz:

    #figure(
      image("../../img/prop2-4terminal.png", width: 100%),
      caption: [Terminal con el registro del libro],
    ) <pantalla-registro-prop2>
  ]

  ]
]

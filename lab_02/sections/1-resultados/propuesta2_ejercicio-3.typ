#import "../../components/code-block.typ": code-block

== Ejercicio 3: Al presionar "Guardar", escribir los tres datos ingresados en un archivo de texto plano guardado en el almacenamiento interno de la aplicación (openFileOutput, modo MODE_PRIVATE).

#pad(1.1em)[
  Para este ejercicio se implementó en la lógica asociada al botón "GUARDAR". La solución se enfoca en validar los tres campos requeridos y persistirlos en un archivo de texto plano en el almacenamiento interno privado:

  #pad(1.1em)[

  === 1. Validación y estructuración de los datos ingresados

  #pad(1.1em)[
    Al presionar "GUARDAR", se verifica los campos, si estan bien se formatean los valores en una cadena de texto plano. Si alguno de los campos está vacío, se muestra un mensaje `Toast` solicitando completar todos los campos:

    #code-block(
      file: "snippets/prop2_validacion_datos.kt",
      lang: "kotlin",
      fill: rgb("#EFF3FA"),
      radius: 12pt,
      inset: 1.2em,
      text-size: 8pt,
    )
  ]

  === 2. Escritura en almacenamiento interno (`openFileOutput` en modo `MODE_PRIVATE`)

  #pad(1.1em)[
     El método abre o crea el archivo en el directorio interno de la aplicación. Mediante la función `.use`, se realiza la escritura de los bytes (`toByteArray()`) y se asegura el cierre del stream. La operación se protege dentro de un bloque `try-catch`, notificando el resultado al usuario mediante un `Toast`:

    #code-block(
      file: "snippets/prop2_escritura_archivo.kt",
      lang: "kotlin",
      fill: rgb("#EFF3FA"),
      radius: 12pt,
      inset: 1.2em,
      text-size: 8pt,
    )
  ]

  ]
]

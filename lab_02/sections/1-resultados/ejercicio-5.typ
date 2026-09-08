#import "../../components/code-block.typ": code-block

== Ejercicio 5: (Reto opcional) Además de mostrarlo por consola, mostrar el registro leído en pantalla empleando un Text.

#pad(1.1em)[
  Al presionar el botón "Ver registro", el resultado de `LeerDatos(context)` se guarda en la variable de estado `registro`. Con la condicional `if (registro.isNotEmpty())` se muestra en pantalla el título "LIBRO REGISTRADO" y una tabla con los encabezados TÍTULO, AUTOR y PÁGINAS. Debajo, una segunda `Row` muestra los datos leídos (`titulo`, `autor` y `paginas`), dándoles el mismo peso con `Modifier.weight(...)`.
  #v(0.5em)

  #code-block(
    file: "snippets/tabla_registro.kt",
    lang: "kotlin",
    fill: rgb("#EFF3FA"),
    radius: 12pt,
    inset: 1.2em,
    text-size: 8pt,
  )
  #v(0.5em)

  Al ejecutar el proyecto y presionar "Ver registro", el registro leído también se muestra en pantalla:

  #figure(
    image("../../img/Reto Final.png", width: 80%),
    caption: [Reto Final: registro en pantalla],
  ) <reto-final>
]

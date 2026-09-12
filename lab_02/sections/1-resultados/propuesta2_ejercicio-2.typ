#import "../../components/code-block.typ": code-block

== Ejercicio 2: Una pantalla (Composable) con tres campos de texto (TextField): título del libro, autor y número de páginas leídas, y dos botones: "Guardar" y "Ver registro".

#pad(1.1em)[
  En este ejercicio, se implementó el composable `RegistroLibroScreen` en Jetpack Compose, donde se realizo una interfaz limpia y organizada para asi capturar los datos requeridos (título, autor y páginas leídas) y los botones de acción ("Guardar" y "Ver registro").

  #pad(1.1em)[

  === 1. Se declararon 3 variables de estado

  #pad(1.1em)[
    Se empleó la función `remember` junto con `mutableStateOf("")` para definir tres variables de estado (`titulo`, `autor` y `paginas`).

    #code-block(
      file: "snippets/prop2_estados.kt",
      lang: "kotlin",
      fill: rgb("#EFF3FA"),
      radius: 12pt,
      inset: 1.2em,
      text-size: 8pt,
    )
  ]

  === 2. Implementación de los campos de texto (`OutlinedTextField`)

  #pad(1.1em)[
    Se utilizaron tres componentes `OutlinedTextField` organizados verticalmente dentro de un `Column`. Se agrego un ícono superior representativo (`Icons.Default.Book`). 

    #code-block(
      file: "snippets/prop2_campos.kt",
      lang: "kotlin",
      fill: rgb("#EFF3FA"),
      radius: 12pt,
      inset: 1.2em,
      text-size: 8pt,
    )
  ]

  === 3. Agregamos los botones de acción

  #pad(1.1em)[
    Para las acciones requeridas se implementó una fila horizontal (`Row`) con `Arrangement.SpaceEvenly`, distribuyendo dos botones:
    - *GUARDAR:* Implementado mediante un `Button` que se encargará de persistir la información ingresada.
    - *VER REGISTRO:* Implementado con un `OutlinedButton` para la consulta y visualización de los datos guardados.

    #code-block(
      file: "snippets/prop2_botones.kt",
      lang: "kotlin",
      fill: rgb("#EFF3FA"),
      radius: 12pt,
      inset: 1.2em,
      text-size: 8pt,
    )
  ]

  === 4. Resultado de la interfaz en el emulador

  #pad(1.1em)[
    Al ejecutar la aplicación en el emulador de Android, se observa la interfaz completa con los tres campos de texto, el icono temático y los dos botones solicitados:

    #figure(
      image("../../img/prop2-pantalla-campos.png", width: 50%),
      caption: [Pantalla con los tres campos de texto y botones de acción en Jetpack Compose],
    ) <pantalla-registro-prop2>
  ]

  ]
]

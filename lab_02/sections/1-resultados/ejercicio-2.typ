#import "../../components/code-block.typ": code-block

== Ejercicio 2: Una pantalla (Composable) con tres campos de texto (TextField): título del libro, autor y número de páginas leídas, y dos botones: "Guardar" y "Ver registro".

  #pad(1.1em)[
  El objetivo de este ejercicio es construir la interfaz de registro de lectura de la aplicación: una pantalla creada con Jetpack Compose que contiene tres campos de texto para capturar los datos de un libro y dos botones para guardarlos y consultarlos más adelante.

  #pad(1.1em)[

  === 1. Crear el Composable `RegistroLibro`

  #pad(1.1em)[
    Dentro de `MainActivity.kt`, se define un Composable llamado `RegistroLibro()` que se carga en `setContent { }` al iniciar la actividad. Es el encargado de dibujar toda la pantalla del formulario:

    #code-block(
        file: "src/MainActivity.kt",
        snippet: "main_activity",
        lang: "kotlin",
        prefix: "//",
        fill: rgb("#EFF3FA"),
        radius: 12pt,
        inset: 1.2em,
        text-size: 8pt,
      )
  ]
  === 2. Declarar las variables de estado

  #pad(1.1em)[
    Para que cada campo recuerde lo que el usuario escribe, se usan variables de estado con `remember { mutableStateOf("") }`. Se necesita una variable por dato: `titulo`, `autor` y `paginas`. Además, `registro` almacenará el texto leído del archivo cuando se pulse "Ver registro":

    #code-block(
        file: "snippets/estado_libro.kt",
        lang: "kotlin",
        fill: rgb("#EFF3FA"),
        radius: 12pt,
        inset: 1.2em,
        text-size: 8pt,
      )
  ]

  === 3. Agregar los tres campos de texto

  #pad(1.1em)[
    Cada dato se captura con un `OutlinedTextField`. Este componente recibe el valor actual en `value` y actualiza la variable de estado en `onValueChange`, es decir, cada vez que el usuario escribe se vuelve a renderizar el campo con el texto nuevo:

    - `Título del libro` vinculado a `titulo`.
    - `Autor` vinculado a `autor`.
    - `Páginas leídas` vinculado a `paginas`.
  ]

  === 4. Agregar los dos botones
  #pad(1.1em)[
    Debajo de los campos se colocan dos `Button` que ocupan todo el ancho de la pantalla:

    - `GUARDAR`: en esta etapa solo invoca a la función que almacena los datos (se detalla en el siguiente ejercicio).
    - `VER REGISTRO`: llamará a la función que lee el archivo guardado.

    El siguiente fragmento muestra las variables de estado, los tres `OutlinedTextField` y los dos botones:

    #code-block(
        file: "snippets/campos_botones.kt",
        lang: "kotlin",
        fill: rgb("#EFF3FA"),
        radius: 12pt,
        inset: 1.2em,
        text-size: 8pt,
      )
  ]
  === 5. Ejecutar y verificar
  #pad(1.1em)[
    Al ejecutar el proyecto con un emulador o un dispositivo físico conectado se muestra la pantalla con el formulario completo: tres campos de texto y los dos botones "Guardar" y "Ver registro".

    #figure(
      image("../../img/Pantalla con Campos de texto.png", width: 80%),
      caption: [Pantalla con Campos de texto],
    ) <pantalla-campos>

    ]
  ]
]

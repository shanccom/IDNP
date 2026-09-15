#let codigo(body) = block(
    fill: rgb("#F1F3F4"),
    width: 100%,
    inset: 1em,
    radius: 8pt,
    spacing: 0.65em,
    breakable: true,
  )[
    #set text(size: 7.5pt)
    #set par(justify: false)
    #body
  ]

== Ejercicio 4: (Reto opcional) Agrega validación de campos vacíos en ambos formularios, mostrando un mensaje de error si el usuario intenta enviar el formulario incompleto.

#v(0.5em)
En este ejercicio se agrega validación de campos vacíos antes de guardar o buscar la cuenta: si falta algún dato, se muestra un mensaje y no se continúa con la operación.

#pad(1.1em)[

  === 1. Validación en `RegistroScreen`

  #v(0.5em)
  #pad(left: 1.1em)[
    Se agregó el estado `mensajeError` junto con su bloque de visualización (antes del botón "Aceptar"):

    #v(0.5em)

    #codigo[
      ```kotlin
      var mensajeError by remember {
          mutableStateOf("")
      }

      if (mensajeError.isNotEmpty()) {

          Text(
              text = mensajeError,
              color = MaterialTheme.colorScheme.error
          )

          Spacer(
              modifier = Modifier.height(8.dp)
          )
      }
      ```
    ]

    #v(0.5em)

    El botón "Aceptar" aplica la misma validación: solo guarda y navega atrás cuando ambos campos tienen contenido, y limpia `mensajeError` al registrar la cuenta correctamente:

    #v(0.5em)

    #figure(
      image("../../img/Codigo_Validacion.png", width: 60%),
      caption: [Código de validación de campos vacíos],
    ) <codigo-validacion>
  ]

  #v(0.5em)

  === 2. Verificación

  #v(0.5em)
  #pad(left: 1.1em)[
    Con la validación implementada, al dejar campos vacíos se muestra el mensaje correspondiente y no se realiza la búsqueda ni el guardado:

    #v(0.5em)

    #figure(
      image("../../img/Validacion_Funcionamiento.png", width: 80%),
      caption: [Mensaje de validación mostrado al enviar el formulario incompleto],
    ) <validacion-funcionamiento>
  ]
]

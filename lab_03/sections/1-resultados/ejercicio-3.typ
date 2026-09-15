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

== Ejercicio 3: En LoginScreen, al presionar "Ingresar", busca una coincidencia en el archivo cuentas.txt (en lugar de la lista en memoria usada en el ejercicio resuelto). Si existe, navega a HomeScreen; si no, muestra el mensaje "Cuenta no encontrada".

#v(0.5em)
En este ejercicio la validación del ingreso ya no usa la lista en memoria `cuentasRegistradas`, sino que lee el archivo `cuentas.txt` para verificar si existe la cuenta `usuario,password`.

#pad(1.1em)[

  === 1. Función `buscarCuenta`

  #v(0.5em)
  #pad(left: 1.1em)[
    La función lee `cuentas.txt` con `openFileInput` y verifica si existe una línea que coincida exactamente con `usuario,password`. Si el archivo todavía no existe, devuelve `false` sin generar un error:

    #v(0.5em)

    #figure(
      image("../../img/Buscar_Cuenta.png", width: 80%),
      caption: [Función `buscarCuenta(context, usuario, password)`],
    ) <buscar-cuenta>
  ]

  === 2. Cambios en `LoginScreen`

  #v(0.5em)
  #pad(left: 1.1em)[
    Dentro del Composable se obtiene el contexto con `LocalContext.current`:

    #v(0.5em)

    #codigo[
      ```kotlin
      val context = LocalContext.current
      ```
    ]
  ]

  #v(0.5em)

  === 3. Botón "INGRESAR"

  #v(0.5em)
  #pad(left: 1.1em)[
    En lugar de buscar en `cuentasRegistradas`, el botón ahora llama a `buscarCuenta(context, usuario, password)`. Si coincide, navega a `home/$usuario`; si no, muestra "Cuenta no encontrada":

    #v(0.5em)

    #codigo[
      ```kotlin
      val coincide = buscarCuenta(context, usuario, password)

      if (coincide) {

          mensajeError = ""

          onLoginExitoso(usuario)

      } else {

          mensajeError = "Cuenta no encontrada"
      }
      ```
    ]
  ]

  #v(0.5em)

  === 4. Verificación

  #v(0.5em)
  #pad(left: 1.1em)[
    Si la cuenta no existe en `cuentas.txt`, la pantalla de login muestra el mensaje de error:

    #v(0.5em)

    #figure(
      image("../../img/Cuenta_No_Encuentrada.png", width: 80%),
      caption: [Mensaje "Cuenta no encontrada" al intentar ingresar con una cuenta inexistente],
    ) <cuenta-no-encontrada>
  ]
]

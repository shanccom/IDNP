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

== Ejercicio 2: En RegistroScreen, al presionar "Aceptar", guarda los datos ingresados (usuario y contraseña) en un archivo de texto plano cuentas.txt en el almacenamiento interno de la aplicación (openFileOutput, modo MODE_APPEND), y regresa a LoginScreen mostrando un mensaje de confirmación.

#v(0.5em)
En este ejercicio se persiste cada cuenta nueva en el archivo `cuentas.txt` del almacenamiento interno y se confirma la creación con el mensaje "Cuenta creada correctamente".

#pad(1.1em)[

  === 1. Nuevos imports
  #v(0.5em)
  #pad(left: 1.1em)[
    Se agregan `Context` (para `openFileOutput`), `Toast` (mensaje de confirmación) y `LocalContext` (para obtener el contexto dentro del Composable):

    #codigo[
      ```kotlin
      import android.content.Context
      import android.widget.Toast
      import androidx.compose.ui.platform.LocalContext
      ```
    ]
  ]

  === 2. Función `guardarCuenta`
  #v(0.5em)
  #pad(left: 1.1em)[
    La función abre `cuentas.txt` en modo `MODE_APPEND` y escribe una línea por cuenta con el formato `usuario,password`:

    #figure(
      image("../../img/Funcion_Guardar_Cuenta.png", width: 80%),
      caption: [Función `guardarCuenta(context, usuario, password)`],
    ) <funcion-guardar-cuenta>
  ]

  === 3. Cambios en `RegistroScreen`
  #v(0.5em)
  #pad(left: 1.1em)[
    Dentro del Composable se obtiene el contexto con `LocalContext.current` y el botón "Aceptar" ahora llama a `guardarCuenta(...)` antes de ejecutar `onRegistroExitoso()`:

    #v(0.5em)

    #codigo[
      ```kotlin
      val context = LocalContext.current

      Button(

          onClick = {

              guardarCuenta(context, usuario, password)

              onRegistroExitoso()
          },

          modifier = Modifier.fillMaxWidth()
      ) {

          Text("Aceptar")
      }
      ```
    ]
  ]

  #v(0.5em)

  === 4. Mensaje de confirmación en `MainActivity`
  #v(0.5em)
  #pad(left: 1.1em)[
    `onRegistroExitoso` muestra un `Toast` con "Cuenta creada correctamente" antes de regresar a `LoginScreen` con `popBackStack()`:
    #v(0.5em)

    #codigo[
      ```kotlin
      onRegistroExitoso = {

          Toast.makeText(
              this,
              "Cuenta creada correctamente",
              Toast.LENGTH_SHORT
          ).show()

          navController.popBackStack()
      },
      ```
    ]
  ]

  === 5. Verificación
  #v(0.5em)
  #pad(left: 1.1em)[
    Al presionar "Aceptar" por cada cuenta, las líneas quedan en el archivo `cuentas.txt`:

    #figure(
      image("../../img/Archivo_Cuenta_Con_Ejempl.png", width: 80%),
      caption: [Archivo `cuentas.txt` con las cuentas guardadas],
    ) <archivo-cuentas>
  ]
]

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

#pad(1.1em)[

#v(0.5em)

Para reemplazar la lista en memoria se creó la función guardarCuenta, que abre el archivo cuentas.txt con openFileOutput en modo Context.MODE_APPEND. Esto agrega el contenido al final del archivo sin borrar las cuentas anteriores, y el archivo se guarda en el almacenamiento interno privado de la aplicación. Cada cuenta ocupa una línea con el formato usuario,password.

En RegistroScreen se obtiene el Context con LocalContext.current. Al presionar "Aceptar" se guarda la cuenta, se muestra un Toast de confirmación y se llama a onRegistroExitoso(), que ejecuta popBackStack() y regresa a LoginScreen. El Toast sigue visible después del cambio de pantalla, por lo que el mensaje aparece sobre el login.

*1.  Función que escribe en el archivo:*
#pad(1.1em)[
#codigo[
```kotlin
const val ARCHIVO_CUENTAS = "cuentas.txt"

fun guardarCuenta(context: Context, usuario: String, password: String) {
    context.openFileOutput(ARCHIVO_CUENTAS, Context.MODE_APPEND).use { salida ->
        salida.write("$usuario,$password\n".toByteArray())
    }
}
```
]
]

*2.  Botón "Aceptar" de RegistroScreen:*
#pad(1.1em)[
#codigo[
```kotlin
val context = LocalContext.current   // al inicio de RegistroScreen

Button(
    onClick = {
        val nombre = usuario.trim()
        guardarCuenta(context, nombre, password)
        Toast.makeText(
            context,
            "Cuenta \"$nombre\" registrada correctamente",
            Toast.LENGTH_SHORT
        ).show()
        onRegistroExitoso()
    },
    modifier = Modifier.fillMaxWidth()
) {
    Text("Aceptar")
}
```
]
]

*3.  Ejecucion*
#figure(
  image("../../img/propuesta2/image-1.png", width: 35%),
  caption: [Ejecución del ejercicio 1]
)
#figure(
  image("../../img/propuesta2/image-2.png", width: 100%),
  caption: [Mensaje de guardado exitoso]
)

#v(1em)
]
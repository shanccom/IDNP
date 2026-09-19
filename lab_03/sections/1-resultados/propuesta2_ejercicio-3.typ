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
== Ejercicio 3: En LoginScreen, al presionar "Ingresar", busca una coincidencia en el archivo cuentas.txt (en lugar de la lista en memoria). Si existe, navega a HomeScreen; si no, muestra el mensaje "Cuenta no encontrada".
#pad(1.1em)[
#v(0.5em)

Se eliminó la lista cuentasRegistradas y se creó la función existeCuenta. Esta obtiene el archivo desde context.filesDir, verifica que exista (si nadie se ha registrado todavía, devuelve false) y lee todas las líneas con readLines(). Cada línea se separa con split(",", limit = 2); el parámetro limit = 2 permite que la contraseña contenga comas sin romper la lectura. Finalmente se compara usuario y contraseña con any { ... }.

En LoginScreen, si existeCuenta devuelve true se llama a onLoginExitoso(nombre), que navega a HomeScreen; de lo contrario se muestra el mensaje "Cuenta no encontrada" en color de error.

*1. Función que busca en el archivo:*
#pad(1.1em)[
#codigo[
```kotlin
fun existeCuenta(context: Context, usuario: String, password: String): Boolean {
    val archivo = File(context.filesDir, ARCHIVO_CUENTAS)
    if (!archivo.exists()) return false

    return archivo.readLines().any { linea ->
        val partes = linea.split(",", limit = 2)
        partes.size == 2 && partes[0] == usuario && partes[1] == password
    }
}
```
]
]

*2. Botón "Ingresar" de LoginScreen:*
#pad(1.1em)[
#codigo[
```kotlin
val context = LocalContext.current   // al inicio de LoginScreen

Button(
    onClick = {
        val nombre = usuario.trim()
        if (existeCuenta(context, nombre, password)) {
            mensajeError = ""
            onLoginExitoso(nombre)
        } else {
            mensajeError = "Cuenta no encontrada"
        }
    },
    modifier = Modifier.fillMaxWidth()
) {
    Text("Ingresar")
}
```
]
]
*3.  Ejecucion*
#figure(
  image("../../img/propuesta2/image-3.png", width: 35%),
  caption: [Validación de inicio de sesión con cuenta inexistente: "Cuenta no encontrada"]
)

#figure(
  image("../../img/propuesta2/image-4.png", width: 35%),
  caption: [Registro de usuario y Toast de confirmación]
)

#figure(
  image("../../img/propuesta2/image-5.png", width: 35%),

  caption: [Inicio de sesión exitoso]
)
#figure(
  image("../../img/propuesta2/image-6.png", width: 35%),
  
  caption: [Inicio de sesión exitoso y navegación a HomeScreen]
)

#v(1em)
]
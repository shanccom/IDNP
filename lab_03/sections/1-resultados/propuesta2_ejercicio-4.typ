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
== Ejercicio 4 (Reto opcional): Agrega validación de campos vacíos en ambos formularios, mostrando un mensaje de error si el usuario intenta enviar el formulario incompleto.
#pad(1.1em)[
#v(0.5em)

Se agregó validación con una expresión `when` en los botones de ambas pantallas. Antes de acceder al archivo se comprueba que el usuario y la contraseña no estén vacíos; si alguno lo está, se muestra el mensaje "Complete todos los campos" mediante la variable de estado `mensajeError`, que se dibuja en color de error. En `RegistroScreen` se creó además esta variable (no existía) junto con el bloque `if (mensajeError.isNotEmpty())` que muestra el texto.

Como la coma es el separador del archivo, en el registro se rechaza también un usuario que la contenga. Adicionalmente, a los campos de texto se les agregó `singleLine = true` para evitar que un salto de línea en la contraseña corrompa el formato del archivo.

*1.  Validación en LoginScreen:*
#pad(1.1em)[
#codigo[
```kotlin
Button(
    onClick = {
        val nombre = usuario.trim()
        when {
            nombre.isEmpty() || password.isEmpty() -> {
                mensajeError = "Complete todos los campos"
            }
            existeCuenta(context, nombre, password) -> {
                mensajeError = ""
                onLoginExitoso(nombre)
            }
            else -> {
                mensajeError = "Cuenta no encontrada"
            }
        }
    },
    modifier = Modifier.fillMaxWidth()
) {
    Text("Ingresar")
}
```
]
]
*2.  Validación en RegistroScreen:*
#pad(1.1em)[
#codigo[
```kotlin
var mensajeError by remember { mutableStateOf("") }   // nuevo estado

// ...debajo del campo de contraseña:
if (mensajeError.isNotEmpty()) {
    Text(mensajeError, color = MaterialTheme.colorScheme.error)
    Spacer(modifier = Modifier.height(8.dp))
}

Button(
    onClick = {
        val nombre = usuario.trim()
        when {
            nombre.isEmpty() || password.isEmpty() -> {
                mensajeError = "Complete todos los campos"
            }
            nombre.contains(",") -> {
                mensajeError = "El usuario no puede contener comas"
            }
            else -> {
                guardarCuenta(context, nombre, password)
                Toast.makeText(
                    context,
                    "Cuenta \"$nombre\" registrada correctamente",
                    Toast.LENGTH_SHORT
                ).show()
                onRegistroExitoso()
            }
        }
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
  image("../../img/propuesta2/image-7.png", width: 35%),
  caption: [Validación de campos vacíos en la pantalla de Login]
)

#figure(
  image("../../img/propuesta2/image-8.png", width: 35%),
  caption: [Validación de campos vacíos en la pantalla de Registro]
)

#figure(
  image("../../img/propuesta2/image-9.png", width: 35%),
  caption: [Restricción de caracteres no permitidos (coma) en el nombre de usuario]
)


#v(1em)

]
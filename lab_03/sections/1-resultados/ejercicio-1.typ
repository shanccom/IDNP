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

== Ejercicio 1: Agrega una tercera pantalla, HomeScreen(usuario), registrada en el NavHost con la ruta "home", que reciba el nombre del usuario como argumento de navegación (por ejemplo navController.navigate("home/usuario")) y lo muestre en el mensaje "Bienvenido".

#v(0.5em)

En este ejercicio se agrega una tercera pantalla a la aplicación de login/registro. La pantalla, llamada `HomeScreen(usuario)`, se registra en el `NavHost` con la ruta `home/{usuario}` y recibe el nombre del usuario como argumento de navegación para mostrarlo en un mensaje


  === 1. Definir la lista de cuentas registradas

  #pad(left: 1.1em)[
    Para validar el ingreso se mantiene una lista global de cuentas. Por ahora contiene el usuario `admin` con contraseña `1234`. Cuando un usuario se registra, la pareja `usuario to password` se agrega a esta lista:


    #v(0.5em)
    #codigo[
      ```kotlin
      val cuentasRegistradas = mutableStateListOf(
          "admin" to "1234"
      )
      ```
    ]
    #v(0.5em)
  ]

  === 2. Registrar la ruta `home/{usuario}` en el NavHost
  #v(0.5em)
  #pad(left: 1.1em)[
    Dentro del `NavHost`, cuya ruta inicial es `login`, se registran tres pantallas: `login`, `registro` y `home/{usuario}`. La ruta de home recibe el argumento `usuario` de tipo `StringType`, declarado con `navArgument`. El valor se obtiene desde `backStackEntry.arguments?.getString("usuario")` y se pasa al Composable `HomeScreen`:

    #figure(
      image("../../img/(\"home:$usuario\") .png", width: 80%),
      caption: [Registro de la ruta `home/{usuario}` con su argumento de navegación],
    ) <ruta-home>
  ]

  === 3. Navegar hacia HomeScreen al iniciar sesión
  #v(0.5em)
  #pad(left: 1.1em)[
    Cuando las credenciales ingresadas coinciden con alguna cuenta registrada, `LoginScreen` invoca `onLoginExitoso(usuario)`. En `MainActivity` esa función navega a la ruta home pasando el usuario como argumento de la ruta:

    #codigo[
      ```kotlin
      composable("login") {

          LoginScreen(

              onLoginExitoso = { usuario ->
                  navController.navigate("home/$usuario")
              },

              onIrARegistro = {
                  navController.navigate("registro")
              }
          )
      }
      ```
    ]
  ]

  === 4. Crear el Composable `HomeScreen`
  #v(0.5em)
  #pad(left: 1.1em)[
    `HomeScreen` recibe el parámetro `usuario: String` y lo muestra en un `Text` con el mensaje "Bienvenido `$usuario`":

    #figure(
      image("../../img/Funcion_HomeScreen.png", width: 40%),
      caption: [Función Composable `HomeScreen(usuario)`],
    ) <funcion-home>
  ]

  === 5. Ejecutar y verificar
  #v(0.5em)
  #pad(1.1em)[
    Al ejecutar el proyecto se muestra la pantalla de login. Al ingresar con el usuario `admin` y la contraseña `1234`, la aplicación navega a la pantalla Home y muestra el mensaje de bienvenida con el nombre del usuario:

    #figure(
      image("../../img/Bienvenido.png", width: 30%),
      caption: [Pantalla de bienvenida con el nombre del usuario],
    ) <pantalla-bienvenida>
  ]

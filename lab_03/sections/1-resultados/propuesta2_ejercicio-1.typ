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

== Ejercicio 1: Agrega una tercera pantalla, HomeScreen(usuario), registrada en el NavHost con la ruta "home", que reciba el nombre del usuario como argumento de navegación (por ejemplo navController.navigate("home \$usuario")) y lo muestre en el mensaje "Bienvenido usuario".

#pad(1.1em)[
#v(0.5em)

En este ejercicio se agregó una tercera pantalla, que se muestra cuando el inicio de sesión es correcto. Se registró en el NavHost con la ruta "home/{usuario}". La parte entre llaves es un *argumento de navegación*: se declara con navArgument y se lee en la pantalla destino mediante backStackEntry.arguments?.getString("usuario").

Para navegar se construye la ruta con el valor real del usuario, es decir navController.navigate("home/\$usuario"). Se aplicó Uri.encode(usuario) para que caracteres especiales (como /) no rompan la ruta. Además, se usó popUpTo("login") { inclusive = true } para eliminar la pantalla de login de la pila de navegación, de modo que al presionar el botón Atrás no se regrese al formulario de inicio de sesión.

_Nota:_ el HomeScreen que existía en el código de partida era una copia de RegistroScreen; se reemplazó por la nueva versión.

*1.  Nueva pantalla HomeScreen:*
#pad(1.1em)[

#codigo[
```kotlin
@Composable
fun HomeScreen(usuario: String) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(24.dp),
        verticalArrangement = Arrangement.Center,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text("Bienvenido $usuario", style = MaterialTheme.typography.headlineMedium)
    }
}
```
]
]
*2.  Registro de la ruta con argumento en el NavHost:*
#pad(1.1em)[
#codigo[
```kotlin
composable(
    route = "home/{usuario}",
    arguments = listOf(
        navArgument("usuario") { type = NavType.StringType }
    )
) { backStackEntry ->
    val usuario = backStackEntry.arguments?.getString("usuario") ?: ""
    HomeScreen(usuario)
}
```
]
]
*3.  Navegación desde el login (reemplaza el Toast anterior):*
#pad(1.1em)[
#codigo[
```kotlin
composable("login") {
    LoginScreen(
        onLoginExitoso = { usuario ->
            navController.navigate("home/${Uri.encode(usuario)}") {
                popUpTo("login") { inclusive = true }
            }
        },
        onIrARegistro = {
            navController.navigate("registro")
        }
    )
}
```
]
]
*4.  Ejecucion*
#figure(
  image("../../img/propuesta2/image.png", width: 20%),
  caption: [Ejecución del ejercicio 1]
)


#v(1em)


]
= Conclusiones

  #v(0.2em)
  #pad(1.1em)[
    *Conclusión 1:* Navigation Compose nos permite gestionar varias pantallas dentro de una sola Activity. El NavController controla los desplazamientos y el NavHost centraliza las rutas  como login, registro y home/{usuario}, esto hace que el flujo de la aplicación sea más sencillo frente al uso de múltiples Activities comunicadas por Intent.
    #v(0.2em)
    *Conclusión 2:* El paso de datos usando la ruta home/{usuario}, declarada con navArgument, permitió enviar el nombre del usuario a HomeScreen. Además, Uri.encode evitó rutas inválidas con caracteres especiales y popUpTo impidió volver al formulario de inicio de sesión con el botón Atrás.
    #v(0.2em)
    *Conclusión 3:* Las pantallas  \@Composable reciben lambdas (onLoginExitoso, onIrARegistro, onRegistroExitoso, onCancelar) en lugar de manejar la navegación por sí mismas, lo que las hace independientes y reutilizables. Por otro lado, remember y mutableStateOf nos permiten que la interfaz conserve lo que escribe el usuario y se actualice sola.
    #v(0.2em)
    *Conclusión 4:* El uso de openFileOutput en modo Context.MODE_APPEND permitió persistir las cuentas en cuentas.txt, dentro del almacenamiento interno privado de la aplicación, sin borrar los registros anteriores. La lectura con readLines() y split(",", limit = 2) permitió validar el ingreso, incluso cuando el archivo aún no existe.
    #v(0.2em)
    *Conclusión 5:* Las validaciones de campos vacíos y de caracteres no permitidos, junto con los mensajes de Toast y el texto en color de error, dieron al usuario retroalimentación inmediata. Herramientas como Logcat facilitaron verificar que los datos realmente se guardaban.
  ]

  #v(0.3em)

  = Recomendaciones

  #v(0.2em)
  #pad(1.1em)[
    *Recomendación 1:* En lugar de guardar la información en un archivo de texto plano (.txt), se sugiere usar herramientas como DataStore, ya que estas permiten organizar, consultar y proteger mucho mejor los datos de la aplicación.
    #v(0.2em)
    *Recomendación 2:* No almacenar las contraseñas en texto plano. Es recomendable guardar únicamente un _hash_ con _salt_ de la contraseña, de modo que si alguien accede al archivo no pueda leer las credenciales.
    #v(0.2em)
    *Recomendación 3:* Ampliar las validaciones del registro: verificar que el usuario no exista previamente, ya que actualmente se pueden agregar cuentas duplicadas, exigir una longitud mínima de contraseña y comprobar el formato de los datos antes de guardarlos.
    #v(0.2em)
    *Recomendación 4:* Separar los componentes \@Composable en archivos Kotlin independientes (LoginScreen.kt, RegistroScreen.kt, HomeScreen.kt) y usar el ViewModel para manejar el estado de la sesión, con el fin de mantener un código más ordenado y fácil de mantener.
    #v(0.2em)
    *Recomendación 5:* Es recomendable incluir control de excepciones (try-catch) al leer y escribir archivos, para prevenir fallos inesperados si el archivo no existe, está dañado o no se puede escribir.
  ]

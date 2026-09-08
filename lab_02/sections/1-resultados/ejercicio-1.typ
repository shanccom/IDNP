== Ejercicio 1: Replicar el ejercicio resuelto por el docente (proyecto Compose + Hello World).

#pad(1.1em)[

  1. Abrir Android Studio. En la pantalla de bienvenida, seleccionar "New Project".

    #figure(
      image("../../img/New_Project.png", width: 80%),
      caption: [New Project],
    ) <new-project>

  2. En la lista de plantillas, elegir "Empty Activity" (dentro de la categoría Phone and Tablet). Esta plantilla ya viene configurada con Jetpack Compose.

    #figure(
      image("../../img/Empty Activity.png", width: 42%),
      caption: [Empty Activity],
    ) <empty-activity>

  3. Configurar el nombre del proyecto (por ejemplo, "HelloWorldCompose"), el nombre del paquete y confirmar que el lenguaje sea Kotlin. Presionar "Finish".

    #figure(
      image("../../img/Revision de version 37 en ves de 36.png", width: 80%),
      caption: [Project Configuration],
    ) <project-config>

  4. Esperar a que Android Studio descargue dependencias y sincronice Gradle. Se abrirá automáticamente el archivo MainActivity.kt con código ya generado.

    #figure(
      image("../../img/Project created.png", width: 80%),
      caption: [Project Created],
    ) <project-created>

  5. Ejecutar el proyecto presionando el botón Run ▶ (con un emulador o un dispositivo físico conectado). Debe aparecer el mensaje "Hello Android!" en pantalla.

    #figure(
      image("../../img/Hola Android.png", width: 80%),
      caption: [Hello Android],
    ) <hello-android>

  6. Dentro de MainActivity.kt, ubicar la función \@Composable llamada `Greeting(name: String, ...)`. Esta función recibe un texto y lo muestra mediante un componente `Text`.

    #figure(
      image("../../img/Greeting.png", width: 80%),
      caption: [New Project],
    ) <new-project>

  7. Ubicar la llamada `Greeting(name = "Android", ...)` dentro de `setContent { }`, y reemplazar el texto "Android" por otro (por ejemplo, el nombre del estudiante).

    #figure(
      image("../../img/Ubicar Android.png", width: 80%),
      caption: [New Project],
    ) <new-project>


  8. Volver a ejecutar Run y verificar que el emulador ahora muestra el saludo personalizado.

    #figure(
      image("../../img/Hello_Sergio.png", width: 80%),
      caption: [Hello Sergio],
    ) <hello-sergio>
]

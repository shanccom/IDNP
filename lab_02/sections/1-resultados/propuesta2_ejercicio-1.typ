#import "../../components/code-block.typ": code-block

== Ejercicio 1: Replicar el ejercicio resuelto por el docente (proyecto Compose + Hello World).

#pad(1.1em)[

  1. Se inició Android Studio y se creó un nuevo proyecto con la plantilla Empty Activity (Jetpack Compose) en lenguaje Kotlin, esperando a que Gradle finalice la sincronización

    #figure(
      image("../../img/prop2-1.png", width: 60%),
      caption: [Hello Android],
    ) <hello-android>

  2. En MainActivity.kt, se cambió el parámetro de la función Greeting dentro de setContent { } por mi nombre.

    #figure(
      image("../../img/prop2-2.png", width: 80%),
      caption: [Función Greeting],
    ) <new-project>


  3. Volver a ejecutar Run y verificar que el emulador ahora muestra el saludo personalizado.

    #figure(
      image("../../img/prop2-3.png", width: 60%),
      caption: [Hello Denise],
    ) <hello-sergio>
]


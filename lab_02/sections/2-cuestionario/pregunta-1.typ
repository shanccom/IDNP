= Pregunta 1 : ¿Consideras complejo el entorno de Android Studio y el uso de Jetpack Compose para tu primera aplicación? Explica brevemente por qué.
#v(0.3em)
  #pad(1.1em)[

  No nos pareció complejo, el entorno de Android Studio facilitó bastante el flujo de trabajo tanto en la compilación como en la detección de errores. Aunque al principio me generó un poco de confusión por ser un lenguaje y un framework nuevos, la sintaxis de Kotlin resultó ser amigable y se logró comprender. Sobre el uso de Jetpack Compose, me pareció interesante y sencillo de usar, ya que permite crear interfaces de usuario de manera más fácil que el antiguo enfoque basado en XML.

  ]
  #v(0.5em)

  = Pregunta 2 : ¿Cuál es el propósito de la función setContent { } dentro del onCreate() de una Activity que usa Jetpack Compose?

  #pad(1.1em)[
    Primero una Activity es el componente que representa una pantalla individual con la que el usuario puede interactuar,y encargado de controlar su ciclo de vida. El método onCreate() es la primera función que se ejecuta cuando el sistema operativo crea la pantalla, es como un punto de entrada donde se realiza toda la configuración inicial.

    Teniendo esto en cuenta, el propósito principal de setContent { } es ser el mecanismo que le dice a la Activity exactamente qué elementos gráficos debe dibujar en la pantalla. Actúa como el puente que conecta el ciclo de vida de la Activity con la interfaz gráfica. Antiguamente se utilizaba setContentView() que cargaba archivos XML.

    Dentro del bloque de setContent { } se colocan las funciones que estructuran la pantalla, como textos, botones, listas o contenedores.

    *Ejemplo:*

    #rect(
      fill: rgb("#EFF3FA"),
      radius: 12pt,
      inset: 1.2em,
    )[
      ```kotlin
      class MainActivity : ComponentActivity() {
          override fun onCreate(savedInstanceState: Bundle?) {
              super.onCreate(savedInstanceState)

              setContent {
                  MiAplicacionTheme {
                      GreetingScreen("Hola, Jetpack Compose") // Componente visual
                  }
              }
          }
      }
      ```
    ]
  ]

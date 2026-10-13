= Ejercicio 1: Plano Interactivo en Jetpack Compose

== Enunciado

Desarrollar una aplicación interactiva en Jetpack Compose denominada *PlanoInteractivo_Compose*, en la cual se represente un plano arquitectónico simple con salones y marcadores interactivos dibujados mediante la API de gráficos de Compose (`Canvas`).

== Desarrollo Paso a Paso

=== Paso 1: Creación del Proyecto
Se creó un nuevo proyecto en Android Studio seleccionando la plantilla *Empty Activity (Compose)*. Se configuró el nombre del proyecto como `PlanoInteractivo_Compose`, el paquete base `com.example.planointeractivo_compose`, lenguaje Kotlin y el SDK mínimo compatible con API 34 o superior.

#align(center)[
  #figure(
    image("../../img/resuelto/paso-1.png", width: 50%),
    caption: [Configuración inicial del nuevo proyecto en Android Studio.]
  )
]

=== Paso 2: Configuración de Dependencias e Importaciones
En el archivo `MainActivity.kt`, debajo de la definición del paquete, se incorporaron las importaciones necesarias para el soporte de gráficos en Compose (`Canvas`, `Offset`, `Size`, `Color`), manejo de eventos táctiles (`pointerInput`, `detectTapGestures`), administración de estado reactivo (`remember`, `mutableStateOf`, `getValue`, `setValue`) y componentes visuales de Material 3 (`AlertDialog`, `Surface`, `Text`, `TextButton`).

#align(center)[
  #figure(
    image("../../img/resuelto/paso-2.png", width: 40%),
    caption: [Declaración de importaciones requeridas en MainActivity.kt.]
  )
]

=== Paso 3: Definición del Modelo de Datos (`Marcador`)
Fuera de cualquier función composable, se definió la clase de datos (`data class`) `Marcador`. Esta estructura encapsula las propiedades geométricas y descriptivas de cada punto de interés: las coordenadas en el plano (`offset: Offset`), el radio de cobertura táctil (`radio: Float`), así como el título y la descripción textual del ambiente.

#align(center)[
  #figure(
    image("../../img/resuelto/paso-3.png", width: 50%),
    caption: [Definición de la data class Marcador.]
  )
]

=== Paso 4: Inicialización del Composable `PlanoAmbiente` y Gestión de Estado
Se implementó la función composable `PlanoAmbiente`, inicializando una lista inmutable de marcadores de muestra mediante `remember` (Sala A y Sala B con sus respectivas coordenadas cartesianas y radios de 40f). Asimismo, se declaró la variable reactiva `marcadorSeleccionado` delegada por `mutableStateOf<Marcador?>(null)` para controlar la selección activa y la visibilidad del diálogo.

#align(center)[
  #figure(
    image("../../img/resuelto/paso-4.png", width: 68%),
    caption: [Declaración del Composable PlanoAmbiente y variables de estado iniciales.]
  )
]

=== Paso 5: Declaración del Lienzo `Canvas` y Reconocedor de Gestos
Se declaró el componente `Canvas` con un modificador que ocupa todo el ancho disponible (`fillMaxWidth()`) y una altura fija de `300.dp`. Se vinculó el detector de gestos táctiles mediante `Modifier.pointerInput(Unit)` y la función `detectTapGestures`, preparando el bloque de captura de toques antes de definir el renderizado gráfico.

#align(center)[
  #figure(
    image("../../img/resuelto/paso-5.png", width: 68%),
    caption: [Configuración del Canvas con modificador pointerInput y detectTapGestures.]
  )
]

=== Paso 6: Renderizado de la Estructura Arquitectónica (Salones y Pared)
Dentro del bloque de dibujo del `Canvas`, se renderizaron las áreas estructurales del plano. Utilizando `drawRect`, se dibujaron el *Salón 1* (color azul claro `0xFFBBDEFB`) y el *Salón 2* (color verde claro `0xFFC8E6C9`) a partir de sus desplazamientos iniciales y dimensiones. Posteriormente, se trazó la pared divisoria vertical con `drawLine` en color gris oscuro (`Color.DarkGray`) con un grosor de trazo de `4f`.

#align(center)[
  #figure(
    image("../../img/resuelto/paso-6.png", width: 35%),
    caption: [Renderizado geométrico de los salones y el muro divisorio con drawRect y drawLine.]
  )
]

=== Paso 7: Renderizado de Marcadores Interactivos
Se iteró sobre la colección `marcadores` dentro del lienzo utilizando `drawCircle`. Cada marcador se dibujó en color rojo en la posición correspondiente (`marcador.offset`) y con el radio predeterminado (`marcador.radio`), completando el renderizado visual de los puntos de interés sobre el plano arquitectónico.

#align(center)[
  #figure(
    image("../../img/resuelto/paso-7.png", width: 45%),
    caption: [Dibujo de los marcadores circulares sobre el plano mediante drawCircle.]
  )
]

=== Paso 8: Detección de Colisiones Táctiles
En el manejador `detectTapGestures`, se implementó el cálculo euclidiano para verificar si la pulsación táctil intersecta con algún marcador. Al recibir la coordenada `offset` del toque, se evalúa si la distancia `(offset - marcador.offset).getDistance()` es menor o igual al radio del elemento. En caso afirmativo, se actualiza el estado `marcadorSeleccionado`.

#align(center)[
  #figure(
    image("../../img/resuelto/paso-8.png", width: 68%),
    caption: [Lógica matemática de colisión y selección en detectTapGestures.]
  )
]

=== Paso 9: Integración del Diálogo de Información (`AlertDialog`)
Fuera del bloque `Canvas`, se utilizó la función de alcance `marcadorSeleccionado?.let { ... }` para condicionar el despliegue del componente `AlertDialog`. El diálogo muestra dinámicamente el título y la descripción del marcador pulsado, e incorpora un botón de confirmación ("Cerrar") y la acción `onDismissRequest` que restablecen el estado a `null` para descartar la ventana modal.

#align(center)[
  #figure(
    image("../../img/resuelto/paso-9.png", width: 45%),
    caption: [Incorporación del diálogo modal AlertDialog para la visualización de detalles.]
  )
]

=== Paso 10: Integración en `MainActivity` y Vista Previa
En la clase `MainActivity`, dentro del método `onCreate` y el bloque `setContent`, se invocó `PlanoAmbiente` envuelto en el tema de la aplicación (`PlanoInteractivo_ComposeTheme`) y un contenedor `Surface`. Adicionalmente, se configuró una función de previsualización anotada con `@Preview` (`PlanoAmbientePreview`) para verificar el diseño en tiempo de desarrollo.

#align(center)[
  #figure(
    image("../../img/resuelto/paso-10.png", width: 65%),
    caption: [Invocación del Composable en setContent de MainActivity y función Preview.]
  )
]

=== Paso 11: Ejecución y Validación en Emulador
Se ejecutó la aplicación en el emulador de Android (API 34). Se constató el renderizado fiel de los ambientes arquitectónicos y marcadores, así como la respuesta interactiva al pulsar sobre cada uno de ellos, abriendo correctamente los diálogos modales informativos de "Sala A" y "Sala B".

#grid(
  columns: (1.2fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  figure(
    image("../../img/resuelto/paso-11.3.png", width: 90%),
    caption: [Visualización del plano y marcadores en el emulador.]
  ),
  figure(
    image("../../img/resuelto/paso-11.1.png", width: 85%),
    caption: [Diálogo informativo modal: Sala A.]
  ),
  figure(
    image("../../img/resuelto/paso-11.2.png", width: 85%),
    caption: [Diálogo informativo modal: Sala B.]
  )
)

= Ejercicio Resuelto por el Docente

A continuación se detallan, paso a paso, las instrucciones para mostrar una lista de edificios del campus con un campo de búsqueda que filtra en tiempo real. También puede apoyarse en el siguiente video tutorial:

*Video de referencia:* "LazyColumn en Android Jetpack Compose. Lista con texto y botones" \
#link("https://www.youtube.com/watch?v=C4EkfVFC0cg")

== Pasos para la Construcción de la Aplicación

+ *Paso 1. Crear un nuevo proyecto:*
  - *Nombre sugerido para el proyecto:* `ListaFiltrable_Compose`
  - *Package name:* `com.example.listafiltrable_compose`
  - *Language:* Kotlin
  - *Minimum SDK:* Valor por defecto de la plantilla (emulador o dispositivo físico con API 34 o superior).

  #figure(
    image("../../img/resueltos/paso-1.png", width: 46%),
    caption: [Paso 1: Creación del nuevo proyecto en Android Studio con plantilla Empty Activity (Compose).]
  )

+ *Paso 2. Agregar importaciones requeridas:*
  - Agregar, debajo de la declaración del `package` y antes de la clase `MainActivity`, todas las importaciones necesarias para el ciclo de vida, componentes de Jetpack Compose (`Column`, `Spacer`, `LazyColumn`, `items`, `Card`, `OutlinedTextField`, `Surface`, `Text`), estados reactivos (`remember`, `mutableStateOf`, `getValue`, `setValue`) y utilidades de estilo.

  #figure(
    image("../../img/resueltos/paso-2.png", width: 55%),
    caption: [Paso 2: Inclusión de paquetes e importaciones de Jetpack Compose en MainActivity.kt.]
  )

+ *Paso 3. Definir la data class del modelo de datos:*
  - Declarar fuera de cualquier Composable la data class `Edificio` encargada de estructurar los registros, definiendo los campos `id` (Int), `nombre` (String), `categoria` (String) y `descripcion` (String).

  #figure(
    image("../../img/resueltos/paso-3.png", width: 50%),
    caption: [Paso 3: Definición de la data class Edificio para modelar la información.]
  )

+ *Paso 4. Crear el Composable `ListaEdificios` con estado base:*
  - Declarar la función Composable `ListaEdificios`.
  - Crear una colección inmutable de al menos 6 edificios de muestra persistida en memoria mediante `remember { listOf(...) }`.
  - Definir una variable de estado mutable para rastrear el texto de búsqueda (`texto`) inicializada en cadena vacía utilizando `remember { mutableStateOf("") }`.

+ *Paso 5. Incorporar el campo de búsqueda (`OutlinedTextField`):*
  - Estructurar el diseño vertical dentro de un contenedor `Column` ocupando el tamaño completo con espaciado interno.
  - Insertar un campo de texto `OutlinedTextField` vinculado bidireccionalmente a la variable `texto`, actualizándola mediante el callback `onValueChange` y asignándole la etiqueta "Buscar edificio".
  - Añadir un separador `Spacer` vertical inferior para distanciar el campo de la lista.

+ *Paso 6. Calcular la lista filtrada:*
  - Procesar la lista original a partir del contenido de `texto` utilizando el operador de filtrado `.filter { ... }`.
  - Comprobar que el nombre del edificio contenga el texto buscado ignorando mayúsculas y minúsculas (`ignoreCase = true`), permitiendo recalcular la lista filtrada de manera reactiva ante cada recomposición.

+ *Paso 7. Declarar el contenedor `LazyColumn`:*
  - Implementar el componente `LazyColumn` a pantalla completa.
  - Invocar la función constructora `items()` pasando la lista de edificios filtrados y proveyendo una clave única estable (`key = { it.id }`) para optimizar el reciclaje de vistas.
  - Delegar la renderización de cada elemento al Composable de fila `FilaEdificio`.

  #figure(
    image("../../img/resueltos/paso-4-5-6-7.png", width: 55%),
    caption: [Pasos 4 al 7: Construcción integrada de ListaEdificios con filtrado reactivo y LazyColumn.]
  )

+ *Paso 8. Implementar el Composable `FilaEdificio`:*
  - Definir la función Composable `FilaEdificio` que recibe un objeto `Edificio`.
  - Renderizar una tarjeta visual `Card` con márgenes verticales y espaciado interno.
  - Organizar en una disposición vertical (`Column`) al menos tres datos representativos: el nombre (destacado en negrita y tamaño amplio), la categoría (con tamaño reducido y color secundario) y la descripción general.

  #figure(
    image("../../img/resueltos/paso-8.png", width: 45%),
    caption: [Paso 8: Implementación del Composable FilaEdificio utilizando un contenedor Card.]
  )

+ *Paso 9. Configurar la ejecución en `MainActivity` y la vista previa:*
  - Configurar dentro del método `onCreate` de `MainActivity` el bloque `setContent`, envolviendo el Composable principal `ListaEdificios` dentro del tema del sistema (`ListaFiltrable_ComposeTheme`) y un contenedor `Surface`.
  - Añadir un Composable de previsualización anotado con `@Preview` (`ListaEdificiosPreview`) para validar visualmente la interfaz desde el entorno de diseño de Android Studio.

  #figure(
    image("../../img/resueltos/paso-9.png", width: 40%),
    caption: [Paso 9: Punto de entrada en MainActivity.kt y función Composable con `@Preview`.]
  )

+ *Paso 10. Ejecución y prueba interactiva en el emulador:*
  - Ejecutar la aplicación en el emulador o dispositivo de prueba con API 34+.
  - Escribir distintas cadenas de caracteres en el campo de búsqueda y constatar que la lista se recompone en tiempo real mostrando exclusivamente las coincidencias por cada pulsación.
*Estudiante 1*
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.8em,
    align: horizon + center,
    figure(
      image("../../img/resueltos/paso-10.1.png", width: 70%),
      caption: [EStudiante 1 : Lista inicial con todos los edificios.]
    ),
    figure(
      image("../../img/resueltos/paso-10.2.png", width: 70%),
      caption: [Estudiante 1 : Filtrado interactivo en tiempo real.]
    ),
    figure(
      image("../../img/resueltos/paso-10.3.png", width: 70%),
      caption: [Estudiante 1 : Coincidencia refinada específica.]
    )
  )
    

  *Estudiante 2*
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.8em,
    align: horizon + center,
    figure(
      image("../../img/propuesta2/res-completo.png", width: 70%),
      caption: [Estudiante 2 : Lista inicial con todos los edificios.]
    ),
    figure(
      image("../../img/propuesta2/res-biblioteca.png", width: 70%),
      caption: [Estudiante 2 : Busqueda de biblioteca]
    ),
    figure(
      image("../../img/propuesta2/res-versita.png", width: 70%),
      caption: [Estudiante 2 : Busqueda que contengan la palabra "versi"]
    )
  )


+ *Paso 11. Validación de escenarios límite:*
  - Ingresar intencionalmente términos o palabras clave que no coincidan con ningún registro.
  - Verificar que la lista queda vacía de forma limpia y transparente, sin generar cuelgues ni errores en la aplicación.
*Estudiante 1*
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.5em,
    align: horizon + center,
    figure(
      image("../../img/resueltos/paso-11.1.png", width: 50%),
      caption: [Paso 11 (a): Búsqueda sin coincidencias registradas.]
    ),
    figure(
      image("../../img/resueltos/paso-11.2.png", width: 50%),
      caption: [Paso 11 (b): Lista vacía sin errores en el emulador.]
    )
  )

  *Estudiante 2*
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.5em,
    align: horizon + center,
    figure(
      image("../../img/propuesta2/res-vacio.png", width: 50%),
      caption: [Estudiante 2 – Paso 11 (a): Búsqueda sin coincidencias registradas.]
    ),
    
  )


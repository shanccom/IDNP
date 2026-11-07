= I. EJERCICIO/PROBLEMA RESUELTO POR EL DOCENTE

A continuación se detallan, paso a paso, las instrucciones para implementar un Service que simula la sincronización de la lista de edificios y avisa a la UI mediante un BroadcastReceiver:

#let captura(caption, ruta: none, width: 45%, columns: (1fr, 1fr), grid-width: 80%) = figure(
  if type(ruta) == array {
    align(center, block(width: grid-width, grid(
      columns: columns,
      gutter: 0.8em,
      align: horizon + center,
      ..ruta.map(r => image(r, width: 100%))
    )))
  } else if ruta == none {
    align(center, rect(
      width: 50%,
      height: 3.5cm,
      stroke: 0.5pt + gray,
      radius: 2pt,
      fill: rgb("#FAFAFA"),
    )[#align(center + horizon)[#text(fill: luma(100), size: 8pt)[_Captura de pantalla pendiente_]]])
  } else {
    image(ruta, width: width)
  },
  caption: caption,
)

== Paso 1. Crear un nuevo proyecto

Crear un nuevo proyecto. nombre sugerido para el proyecto: “SincronizacionServicio_Compose”, Package name: com.example.sincronizacionservicio_compose, Language: Kotlin, Minimum SDK: el que venga por defecto en la plantilla (recuerden usar un emulador o dispositivo con API 34 o superior, según la sección de Recursos a utilizar).

#captura(
  ruta: "../../img/resuelto/paso-1.png",
  width: 45%,
)[Paso 1: Creación del proyecto SincronizacionServicio_Compose en Android Studio con Kotlin y el SDK mínimo de la plantilla.]

== Paso 2. Abrir el archivo AndroidManifest.xml y declarar el nuevo Service

Abrir el archivo AndroidManifest.xml y declarar el nuevo Service dentro de la etiqueta `<application>`:

#captura(
  ruta: "../../img/resuelto/paso-2.png",
  width: 40%,
)[Código (AndroidManifest.xml – fragmento dentro de `<application>`)]

== Paso 3. Agregar importaciones

Agregar, debajo del package y antes de la clase MainActivity, todas las importaciones que se usarán en este ejercicio:

#captura(
  ruta: "../../img/resuelto/paso-3.png",
  width: 42%,
)[Código (importaciones)]

== Paso 4. Crear la clase SincronizacionService

Crear la clase SincronizacionService, heredando de Service, y sobrescribir onBind() devolviendo null, ya que no será un Bound Service. Por ahora dejamos pendiente la lógica de sincronización:

#captura(
  ruta: "../../img/resuelto/paso-4-onbind.png",
  width: 42%,
)[Código (SincronizacionService – Paso 4)]

== Paso 5. Sobrescribir onStartCommand()

Sobrescribir onStartCommand(), lanzando una coroutine en Dispatchers.IO que simule una tarea de sincronización con delay(3000) y calcule un resultado simulado (por ejemplo, un número aleatorio de edificios actualizados):

#captura(
  ruta: "../../img/resuelto/paso-4.png",
  width: 45%,
)[Código (SincronizacionService – Paso 5)]

== Paso 6. Construir el Intent y enviar el Broadcast

Al terminar la coroutine, construir un Intent con una acción propia, indicar con setPackage(packageName) que el aviso es solo para esta aplicación, agregar el resultado como extra, enviarlo con sendBroadcast(), registrar un mensaje en el Logcat y llamar a stopSelf() para finalizar el Service. Con esto, SincronizacionService queda completo:

#captura(
  ruta: "../../img/resuelto/paso-5.png",
  width: 48%,
)[Código (SincronizacionService completo)]

== Paso 7. Crear el Composable PantallaSincronizacion

Crear el Composable PantallaSincronizacion, obteniendo el contexto actual y una variable de estado para el resultado recibido. Por ahora dejamos el resto del cuerpo vacío; lo iremos completando en los siguientes pasos:

#captura(
  ruta: "../../img/resuelto/paso-6.png",
  width: 42%,
)[Código (PantallaSincronizacion – Paso 7)]

== Paso 8. Registrar el BroadcastReceiver con DisposableEffect

Dentro de un DisposableEffect(Unit), crear un BroadcastReceiver que en onReceive() registre un mensaje en el Logcat y actualice resultado con el extra recibido, registrarlo con ContextCompat.registerReceiver() indicando RECEIVER_NOT_EXPORTED, y desregistrarlo en onDispose { }:

#captura(
  ruta: "../../img/resuelto/paso-7.png",
  width: 48%,
)[Código (PantallaSincronizacion – Paso 8)]

== Paso 9. Agregar botón de sincronización e indicador de progreso

Agregar un botón "Sincronizar" que inicie el Service con startService(), y un indicador de progreso que se muestre mientras resultado sea null. El Column usa statusBarsPadding() para que el contenido no quede debajo de la barra de estado. Con esto, PantallaSincronizacion queda completo:

#captura(
  ruta: "../../img/resuelto/paso-9.png",
  width: 48%,
)[Código (PantallaSincronizacion completo)]

== Paso 10. Integrar PantallaSincronizacion en MainActivity

Dentro de MainActivity, en el bloque setContent, mostrar PantallaSincronizacion:

#captura(
  ruta: "../../img/resuelto/paso-10.png",
  width: 38%,
)[Código (MainActivity.kt completo)]

== Paso 11. Ejecución en emulador y verificación en Logcat

Ejecutar la aplicación en un emulador, pulsar "Sincronizar" una vez y verificar en Logcat (filtrando con tag:SYNC) que aparece el mensaje "1. Servicio iniciado", mientras la UI muestra el indicador de progreso.
#pad(1.1em)[
*Pruebas de Integrante 1*
#captura(
  ruta: (
    "../../img/resuelto/paso-11.1.png",
    "../../img/resuelto/paso-11.png",
  ),
  columns: (1fr, 2fr),
  grid-width: 80%,
)[Paso 11: Ejecución de la aplicación en el emulador con el indicador de progreso activo y verificación en Logcat ("1. Servicio iniciado").]

*Pruebas de Integrante 2*

#captura(
  ruta: (
    "../../img/propuesta2/re-1.png",
    "../../img/propuesta2/re-1.2.png",
  ),
  columns: (1fr, 2fr),
  grid-width: 80%,
)[Paso 11 (Integrante 2): Ejecución de la aplicación en el emulador con el indicador de progreso activo y verificación en Logcat ("1. Servicio iniciado").]

]
== Paso 12. Confirmar sincronización y recepción del Broadcast

Esperar a que termine la coroutine (unos 3 segundos) y confirmar que en Logcat aparecen "2. Aviso enviado" y "3. Aviso recibido en la pantalla", y que la UI reemplaza el indicador por el mensaje recibido mediante el BroadcastReceiver.

#pad(1.1em)[
*Pruebas de Integrante 1*
#captura(
  ruta: (
    "../../img/resuelto/paso-11.2.png",
    "../../img/resuelto/paso-12.png",
  ),
  columns: (1fr, 2fr),
  grid-width: 80%,
)[Paso 12: Confirmación en Logcat de la finalización de la coroutine y actualización reactiva de la UI mediante el BroadcastReceiver.]


*Pruebas de Integrante 2*

#captura(
  ruta: (
    "../../img/propuesta2/re-2.png",
    "../../img/propuesta2/re-3.png",
  ),
  columns: (1fr, 2fr),
  grid-width: 80%,
)[Paso 12 (Integrante 2): Confirmación en Logcat de la finalización de la coroutine y actualización reactiva de la UI mediante el BroadcastReceiver.]

]


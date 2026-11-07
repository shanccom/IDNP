= 1. ¿Lograste resolver completamente el Ejercicio/Problema Resuelto por el Docente (servicio en segundo plano que sincroniza datos y notifica el resultado mediante un BroadcastReceiver)? Adjunta una captura de pantalla del emulador mostrando el resultado como evidencia.

Sí, ambos integrantes logramos resolver completamente el ejercicio del docente siguiendo cada uno de sus pasos. Cada uno lo ejecutó en su propio emulador y obtuvo el mismo resultado: al pulsar «Sincronizar» se inicia el Service con `startService()`, que hace la tarea en segundo plano y, al terminar, avisa con un broadcast [3]. La pantalla recibe ese aviso con un `BroadcastReceiver` registrado con `RECEIVER_NOT_EXPORTED`, porque el aviso viene de nuestra propia aplicación [5]. Al desarrollarlo entendimos en la práctica cómo conectar un servicio en segundo plano con una interfaz hecha en Jetpack Compose.

A continuación se adjuntan las capturas del emulador y de Logcat de cada integrante.

*Pruebas de Integrante 1*

#v(0.4em)

#figure(
  image("../../img/resuelto/paso-11.png", width: 95%),
  caption: [Evidencia 1 (Integrante 1): al presionar el botón "Sincronizar", el emulador muestra la barra de progreso activa y en Logcat se registra "1. Servicio iniciado".],
)

#v(0.4em)

#figure(
  image("../../img/resuelto/paso-12.png", width: 95%),
  caption: [Evidencia 2 (Integrante 1): luego de los 3 segundos, Logcat muestra "2. Aviso enviado" y "3. Aviso recibido en la pantalla", y la interfaz reemplaza la carga mostrando la cantidad de edificios sincronizados.],
)

*Pruebas de Integrante 2*

#v(0.4em)
#figure(
  image("../../img/propuesta2/re-1.2.png", width: 95%),
  caption: [Evidencia 1 (Integrante 2): al presionar el botón "Sincronizar", el emulador muestra la barra de progreso activa y en Logcat se registra "1. Servicio iniciado".],
)
#figure(
  image("../../img/propuesta2/re-3.png", width: 95%),
  caption: [Evidencia 2 (Integrante 2): luego de los 3 segundos, Logcat muestra "2. Aviso enviado" y "3. Aviso recibido en la pantalla", y la interfaz reemplaza la carga mostrando la cantidad de edificios sincronizados.],
)

#figure(
  image("../../img/propuesta2/re-2.png", width: 65%),
  caption: [Evidencia 3 (Integrante 2): Sincronizacion completa".],
)

#v(0.4em)




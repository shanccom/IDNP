= Pregunta 3: En forma individual, comenta en el video de referencia #link("https://www.youtube.com/watch?v=AeNnc8yhNTo")[Broadcast Receivers en Android con Jetpack Compose (YouTube)] qué otras acciones del sistema, además del cambio de batería, se pueden escuchar con un `BroadcastReceiver`. (Colocar la captura del comentario; uno por integrante del grupo).

== Respuesta

Realicé mi comentario destacando acciones esenciales del sistema como la transición al modo avión (`ACTION_AIRPLANE_MODE_CHANGED`), la conexión/desconexión a la corriente (`ACTION_POWER_CONNECTED`) y el cambio de conectividad de red.

Estas emisiones protegidas del sistema permiten que la aplicación reaccione inteligentemente al entorno del dispositivo sin necesidad de realizar sondeos constantes (polling), optimizando el uso de recursos.

#align(center)[
  #figure(
    image("../../img/Captura de pantalla 2026-09-25 a la(s) 12.15.09 p. m..png", width: 70%),
    caption: [Captura del comentario realizado en el video de referencia de YouTube.],
  )
]

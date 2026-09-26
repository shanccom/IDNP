= Pregunta 3: En forma individual, comenta en el video de referencia #link("https://www.youtube.com/watch?v=AeNnc8yhNTo")[Broadcast Receivers en Android con Jetpack Compose (YouTube)] qué otras acciones del sistema, además del cambio de batería, se pueden escuchar con un `BroadcastReceiver`. (Colocar la captura del comentario; uno por integrante del grupo).

== Respuesta

Realizamos nuestros comentarios individuales en el video de referencia, identificando eventos clave del sistema operativo que pueden ser monitoreados de forma reactiva con un `BroadcastReceiver`.


A continuación, se presentan las evidencias de la participación de ambos integrantes en YouTube:

#v(0.5em)
#block()[
  #text(weight: "bold", size: 9.5pt)[Integrante 1]
  \
  Realicé mi comentario destacando acciones esenciales del sistema como la transición al modo avión (`ACTION_AIRPLANE_MODE_CHANGED`), la conexión/desconexión a la corriente (`ACTION_POWER_CONNECTED`) y el cambio de conectividad de red.

Estas emisiones protegidas del sistema permiten que la aplicación reaccione inteligentemente al entorno del dispositivo sin necesidad de realizar sondeos constantes (polling), optimizando el uso de recursos.

  #v(0.3em)
  #align(center)[
    #figure(
      image("../../img/Captura de pantalla 2026-09-25 a la(s) 12.15.09 p. m..png", width: 70%),
      caption: [Captura del comentario realizado en el video de referencia de YouTube.],
    )
  ]



]

#v(0.8em)
#block()[
  #text(weight: "bold", size: 9.5pt)[Integrante 2]
  \
  Comente sobre el uso de `DisposableEffect` para prevenir fugas de memoria y tambien resalte el monitoreo de eventos como llamadas entrantes, mensajes SMS, estados de red Wi-Fi/Bluetooth y cambios de idioma con `ACTION_LOCALE_CHANGED`.

  #v(0.3em)
  #align(center)[
    #figure(
      image("../../img/propuesta2/youtube.png", width: 85%),
      caption: [Comentario realizado por el Integrante 2 en YouTube.],
    )
  ]
]

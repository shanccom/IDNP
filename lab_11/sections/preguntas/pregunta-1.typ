= 1. ¿Lograste resolver completamente el Ejercicio/Problema Resuelto por el Docente (reproductor de audio-guía en Foreground Service, con notificación visible al pasar la app a segundo plano)? Adjunta una captura de pantalla del emulador mostrando el resultado como evidencia.

Sí, como equipo logramos resolver e implementar satisfactoriamente el ejercicio resuelto en su totalidad. Desarrollar esta práctica nos permitió comprender en la práctica cómo trabaja un servicio en primer plano (*Foreground Service*) y cómo se coordina con el ciclo de vida de una aplicación desarrollada en Jetpack Compose.

Al principio, uno suele pensar que la reproducción en segundo plano consiste simplemente en dejar corriendo una corrutina o un hilo secundario; sin embargo, al enfrentarnos a los requerimientos actuales de Android (como declarar explícitamente el tipo de servicio `mediaPlayback` exigido desde Android 14 y solicitar el permiso de usuario `POST_NOTIFICATIONS` a partir de Android 13), entendimos la importancia que tiene la arquitectura del sistema operativo para proteger los recursos del dispositivo.

#v(0.5em)
*Integrante 1:*
#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  align: bottom + center,
  figure(
    image("../../img/resuelto/paso-13.1.png", width: 75%),
    caption: [Evidencia 1: Reproducción activa en pantalla (primer plano).],
  ),
  figure(
    image("../../img/resuelto/paso-13.3.png", width: 75%),
    caption: [Evidencia 2: Notificación visible en la bandeja tras pasar a segundo plano.],
  ),
)

*Integrante 2:*

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: bottom + center,
  figure(
    image("../../img/propuesta2/re01.png", width: 70%),
    caption: [Ejecución de la app e inicio de reproducción.],
  ),
  figure(
    image("../../img/propuesta2/re02.png", width: 70%),
    caption: [Activación de permisos de notificación en Ajustes.],
  ),
  figure(
    image("../../img/propuesta2/re03.png", width: 70%),
    caption: [Verificación de la notificación persistente en 2do plano.],
  ),
)
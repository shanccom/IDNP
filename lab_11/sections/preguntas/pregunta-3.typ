= 3. En forma individual, comenta en el video de referencia (https://www.youtube.com/watch?v=-45jGLtbhPQ) qué diferencia encuentras entre la forma de mostrar la notificación en el video y el control de visibilidad basado en ProcessLifecycleOwner implementado en este laboratorio. (Colocar la captura del comentario; uno por integrante del grupo).

La diferencia principal radica en que el video de referencia utiliza un enfoque estático: la notificación se muestra inmediatamente al iniciar el servicio y permanece fija en la barra de estado todo el tiempo, incluso mientras el usuario interactúa dentro de la app. En cambio, con `ProcessLifecycleOwner` la notificación se vuelve reactiva al ciclo de vida global: solo se hace visible cuando la aplicación pasa a segundo plano (`ON_STOP`), evitando saturar innecesariamente la bandeja cuando la interfaz principal ya está en pantalla.

#v(0.4em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  [
    *Integrante 1: Hancco Mullisaca, Sergio Danilo*

    #v(0.2em)
    _«En el video la notificación está fija todo el tiempo duplicando lo que ya vemos en pantalla. Con `ProcessLifecycleOwner` aparece solo al salir de la app, logrando una experiencia mucho más limpia y adaptada al contexto real del usuario.»_

    #v(0.4em)
    #figure(
      image("../../img/comentario.png", width: 100%),
      caption: [Comentario en YouTube (Integrante 1).],
    )
  ],
  [
    *Integrante 2: Huacani Jara, Denise Andrea*

    #v(0.2em)
    _«El tutorial aplica una notificación estática que ignora si el usuario está dentro o fuera de la app. En el laboratorio la hicimos reactiva al ciclo de vida: cumple su función de guía y control únicamente cuando dejamos de ver la interfaz.»_

    #v(0.4em)
    #figure(
      rect(width: 100%, height: 3.2cm, stroke: 0.5pt + gray, radius: 2pt)[
        #align(center + horizon)[_Captura de comentario — Denise_]
      ],
      caption: [Comentario en YouTube (Integrante 2).],
    )
  ]
)

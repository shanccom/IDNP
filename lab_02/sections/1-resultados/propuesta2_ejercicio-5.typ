#import "../../components/code-block.typ": code-block

== Ejercicio 5: (Reto opcional) Además de mostrarlo por consola, mostrar el registro leído en pantalla empleando un Text.

#pad(1.1em)[
  Para el reto opcional, se implementó la visualización del archivo en pantalla utilizando componentes `Text` dentro de una tarjeta (`Card`):

  #pad(1.1em)[

  === 1. Declaración de la variable de estado

  #pad(1.1em)[
    Se definió la variable de estado `contenidoGuardado`, para mostrar u ocultar la tarjeta con el registro en tiempo real:

    #code-block(
      file: "snippets/prop2_reto_estado.kt",
      lang: "kotlin",
      fill: rgb("#EFF3FA"),
      radius: 12pt,
      inset: 1.2em,
      text-size: 8pt,
    )
  ]

  === 2. Lectura del archivo y actualización del estado al presionar "VER REGISTRO"

  #pad(1.1em)[
    En el botón *"VER REGISTRO"*, se abre el archivo `registro_libro.txt` y se lee su contenido y se actualiza el estado `contenidoGuardado`, notificando a Compose que debe refrescar la vista con los nuevos datos:

    #code-block(
      file: "snippets/prop2_reto_lectura.kt",
      lang: "kotlin",
      fill: rgb("#EFF3FA"),
      radius: 12pt,
      inset: 1.2em,
      text-size: 8pt,
    )
  ]

  === 3. Renderizado del registro en pantalla mediante componentes `Text`

  #pad(1.1em)[
    Para presentar los datos se utiliza la condición `if (contenidoGuardado.isNotEmpty())`. Si existe contenido leído, se muestra una tarjeta `Card`. :

    #code-block(
      file: "snippets/prop2_reto_mostrar_text.kt",
      lang: "kotlin",
      fill: rgb("#EFF3FA"),
      radius: 12pt,
      inset: 1.2em,
      text-size: 8pt,
    )
  ]

  === 4. Pruebas y visualización de resultados en el emulador

  #pad(1.1em)[
    A continuación se muestra el flujo de funcionamiento de la aplicación:

    1. *Guardado de los datos:* Se ingresan los datos del libro (título, autor y páginas leídas) y, al presionar *"GUARDAR"*, se guarda y se notifica al usuario mediante un mensaje `Toast`:

    #figure(
      image("../../img/prop2-finalguardar.png", width: 30%),
      caption: [Persistencia de datos en almacenamiento interno y confirmación con Toast],
    ) <prop2-final-guardar>

    2. *Visualización del registro en pantalla:* Al presionar *"VER REGISTRO"*, se realiza la lectura del archivo y el contenido se visualiza dinámicamente en pantalla mediante los componentes `Text`:

    #figure(
      image("../../img/prop2-finalverregistro.png", width: 30%),
      caption: [Visualización del registro leído en pantalla empleando componentes Text],
    ) <prop2-final-ver-registro>

  ]

  ]
]

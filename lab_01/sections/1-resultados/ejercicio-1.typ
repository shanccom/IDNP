= Ejercicio 1: Investiga y explica con tus propias palabras: ¿Qué es una aplicación móvil? ¿Qué se entiende por nuevas plataformas de desarrollo? ¿Por qué es importante el desarrollo móvil en la actualidad?

== ¿Qué es una aplicación móvil?

Una aplicación móvil es un software que está diseñado para ser utilizado en los dispositivos móviles; estos son aparatos electrónicos pequeños que están diseñados para la comunicación, procesar datos, etc., como las tabletas y celulares. Las aplicaciones móviles tienen diversas funciones como para el entretenimiento, la productividad, etc. Estas aplicaciones aprovechan las características del dispositivo que tienen, como la cámara, el GPS, etc. Sus diseños están configurados para que sean fáciles de usar en las pantallas pequeñas.

#v(6pt)

== ¿Qué se entiende por nuevas plataformas de desarrollo?

Las nuevas plataformas de desarrolllo, son entornos de desarrollo modernos que tratan de optimizar la experiencia, unificando las herramientas, servicios, etc., para que sea más sencilla la creación, despliegue y gestión de las aplicaciones. EStas plataformas pueden categorizarse en 4 enfoques principales:
#v(0.8em)

#let hc(body) = table.cell(fill: rgb("#708090"))[#text(fill: white, weight: "bold")[#body]]
#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  align: left + top,
  table.header(
    [#hc[Impulsadas por IA]],
    [#hc[No-Code / Low-Code]],
    [#hc[Multiplataforma]],
    [#hc[Backend Moderno]],
  ),
  [Son herramientas que usan inteligencia artificial para ayudarnos a escribir, corregir o generar código automáticamente a partir de instrucciones.],
  [Son plataformas que se enfocan en construir aplicaciones de forma visual, arrastrando elementos y sin necesidad de escribir nada o poco código.],
  [Son entornos que nos permiten programar una sola vez y hacer que la aplicación funcione tanto en Android como en iOS o la web.],
  [Son servicios en la nube que nos ayudan en la parte lógica y la base de datos sin tener que configurar servidores complejos desde cero.],
  
  [
    *Ejemplos:*
    - Cursor
    - Bolt.new
    - Lovable / Stitch
  ],
  [
    *Ejemplos:*
    - Wix Studio
    - App Builder
  ],
  [
    *Ejemplos:*
    - Kotlin Multiplatform
    - Flutter
  ],
  [
    *Ejemplos:*
    - FastAPI
    - Supabase
  ]
)

#v(1em)

== ¿Por qué es importante el desarrollo móvil en la actualidad?

El desarrollo móvil en la actualidad es importante porque los dispositivos móviles se han convertido en el principal punto de acceso a Internet y la herramienta central de la vida cotidiana y profesional. La mayoría de los usuarios acceden a internet y realizan diversas actividades a través de sus  celulares y tablets, lo que hace que las aplicaciones móviles sean esenciales para la comunicación, el comercio, la educación y el entretenimiento. Además, el desarrollo móvil permite a las empresas llegar a un público más amplio, mejorar la experiencia del usuario y mantenerse competitivas en un mercado cada vez más digitalizado.

En la figura se puede observar una ilustracion que sintetiza los puntos clave mencionados anteriormente:

#figure(
  image("../../img/ejercicio1-Importancia.jpeg", width: 80%),
  caption: [Importancia del desarrollo móvil en la actualidad]
)

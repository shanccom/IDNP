= Ejercicio 1: Investiga y explica con tus propias palabras: ¿Qué es una aplicación móvil? ¿Qué se entiende por nuevas plataformas de desarrollo? ¿Por qué es importante el desarrollo móvil en la actualidad?

== ¿Qué es una aplicación móvil?

Una aplicación móvil es un software que está diseñado para ser utilizado en los dispositivos móviles; estos son aparatos electrónicos pequeños que están diseñados para la comunicación, procesar datos, etc., como las tabletas y celulares. Las aplicaciones móviles tienen diversas funciones como para el entretenimiento, la productividad, etc. Estas aplicaciones aprovechan las características del dispositivo que tienen, como la cámara, el GPS, etc. Sus diseños están configurados para que sean fáciles de usar en las pantallas pequeñas.

#v(6pt)

== ¿Qué se entiende por nuevas plataformas de desarrollo?

Las nuevas plataformas de desarrolllo, son entornos de desarrollo modernos que tratan de Las nuevas plataformas de desarrollo son entornos de desarrollo modernos que tratan de mejorar la experiencia, unificando las herramientas, servicios, etc., para que sea más sencilla la creación, despliegue y gestión de las aplicaciones. Por ejemplo, se tienen aquellas plataformas low-code (no-code), impulsadas por agentes de IA, etc.

#v(8pt)

#align(center)[
  #block(
    width: 75%,
    fill: rgb("#7aa4ff"),
    inset: 6pt,
    radius: 4pt,
    stroke: 1pt + rgb("#1d4ed8")
  )[
    #text(fill: black, weight: "bold", size: 9pt)[Categorias]
  ]

  #table(
    columns: (1fr, 1fr, 1fr, 1fr),
    align: center + horizon,
    stroke: 0.5pt + rgb("#cbd5e1"),
    fill: (x, y) => if y == 0 { rgb("#e2e8f0") } else { rgb("#ffffff") },
    inset: 6pt,
    
    // Fila 1: Categorías
    [#text(weight: "bold")[Impulsadas por IA y Agentes]],
    [#text(weight: "bold")[No-Code / Low-Code]],
    [#text(weight: "bold")[Desarrollo Multiplataforma]],
    [#text(weight: "bold")[Backend Moderno]],

    // Fila 2: Descripción breve
    [Automatización y generación de código mediante IA],
    [Creación visual con poca o ninguna programación],
    [Código compartido entre múltiples sistemas operativos],
    [APIs de alto rendimiento para servicios en la nube],

    // Fila 3: Ejemplos
    [
      #list(
        align(left)[*Cursor:* Editor con IA agente],
        align(left)[*Bolt.new:* Full-stack inmediato],
        align(left)[*Lovable / Stitch:* Generación de UI]
      )
    ],
    [
      #list(
        align(left)[*Wix Studio:* Diseño web avanzado],
        align(left)[*App Builder:* Arrastrar y soltar]
      )
    ],
    [
      #list(
        align(left)[*Kotlin Multiplatform:* Lógica compartida iOS/Android],
        align(left)[*Flutter:* UI nativa desde una base]
      )
    ],
    [
      #list(
        align(left)[*FastAPI:* Framework rápido de Python],
        align(left)[*Supabase:* Backend as a Service]
      )
    ]
  )
]

#v(10pt)

== ¿Por qué es importante el desarrollo móvil en la actualidad?

El desarrollo móvil en la actualidad es importante porque los dispositivos móviles se han convertido en el principal punto de acceso a Internet y la herramienta central de la vida cotidiana y profesional. La mayoría de los usuarios acceden a internet y realizan diversas actividades a través de sus  celulares y tablets, lo que hace que las aplicaciones móviles sean esenciales para la comunicación, el comercio, la educación y el entretenimiento. Además, el desarrollo móvil permite a las empresas llegar a un público más amplio, mejorar la experiencia del usuario y mantenerse competitivas en un mercado cada vez más digitalizado.

#figure(
  image("../../img/ejercicio1-Importancia.png", width: 80%),
  caption: [Importancia del desarrollo móvil en la actualidad]
)

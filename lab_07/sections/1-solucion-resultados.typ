#import "../template.typ": lab-section

#lab-section(
  "SOLUCIÓN Y RESULTADOS",
  [
    #pad(left: 0.5em, top: 0.5em)[
    #block(text(weight: "bold")[I. SOLUCIÓN DE EJERCICIOS/PROBLEMAS], below: 0.8em)

      - Link Repositorio Propuesta 1: https://github.com/shanccom/IDNP_Repo/tree/main/PlanoInteractivo_Compose
      - Link Repositorio Propuesta 2:https://github.com/DeniseHuacani/IDNP-LABORATORIO/tree/main/lab07/PlanoInteractivo_Compose

      #include "ejercicios/ejercicio-1.typ"
      #v(0.6em)
      #include "ejercicios/ejercicio-2.typ"
      #v(0.6em)
      #include "ejercicios/propuesta2/ejercicio-1.typ"

    ]
  ],
  [
    #pad(left: 0.5em, top: 0.5em)[
      #block(text(weight: "bold")[II. SOLUCIÓN DEL CUESTIONARIO], below: 0.8em)
      #include "preguntas/pregunta-1.typ"
      #v(0.6em)
      #include "preguntas/pregunta-2.typ"
      #v(0.6em)
      #include "preguntas/pregunta-3.typ"
    ]
  ],
  [
    #pad(left: 0.5em, top: 0.5em)[
      #block(text(weight: "bold")[III. CONCLUSIONES], below: 0.8em)
      #include "conclusiones.typ"
    ]
  ],
)

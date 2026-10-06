#import "../template.typ": lab-section

#lab-section(
  "SOLUCIÓN Y RESULTADOS",
  [
    #pad(left: 0.5em, top: 0.5em)[
    #block(text(weight: "bold")[I. SOLUCIÓN DE EJERCICIOS/PROBLEMAS], below: 0.8em)
      Link (Propuesta 1): https://github.com/shanccom/IDNP_Repo/tree/main/lab_05_CampusNavigator_Compose/CampusNavigator_Composes

      Link (Propuesta 2): https://github.com/DeniseHuacani/IDNP-LABORATORIO/tree/main/lab05/CampusNavigator_Compose

      #include "ejercicios/ejercicio-1.typ"
      #v(0.6em)
      = EJERCICIOS/PROBLEMAS PROPUESTOS
      #pad(1.1em)[
      #include "ejercicios/ejercicio-2.typ"
      #include "ejercicios/propuesta2/ejercicio-1.typ"
    ]

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

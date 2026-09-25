#import "../template.typ": lab-section

#lab-section(
  "SOLUCIÓN Y RESULTADOS",
  [
    #pad(left: 0.5em, top: 0.5em)[

    #block(text(weight: "bold")[I. SOLUCIÓN DE EJERCICIOS PROPUESTOS], below: 0.8em)
      #pad(1.1em)[
        = PROPUESTA 1
        #include "ejercicios/ejercicio-1.typ"
        #v(0.6em)
        #include "ejercicios/ejercicio-2.typ"
        #v(0.6em)
        #include "ejercicios/ejercicio-3.typ"
        #v(0.6em)
        = PROPUESTA 2
        #v(0.6em)
        #include "ejercicios/pr2-ejercicio1.typ"
        #v(0.6em)
        #include "ejercicios/pr2-ejercicio2.typ"
        #v(0.6em)
        #include "ejercicios/pr2-ejercicio3.typ"
        #v(0.6em)
        #include "ejercicios/pr2-ejercicio4.typ"

      ]
    ]
  ],
  [
    #pad(left: 0.5em, top: 0.5em)[
      #block(text(weight: "bold")[II. SOLUCIÓN DEL CUESTIONARIO], below: 0.8em)
        #pad(1.1em)[
        #include "preguntas/pregunta-1.typ"
        #v(0.6em)
        #include "preguntas/pregunta-2.typ"
        #v(0.6em)
        #include "preguntas/pregunta-3.typ"
        ]
    ]
  ],
  [
    #pad(left: 0.5em, top: 0.5em)[
      #block(text(weight: "bold")[III. CONCLUSIONES], below: 0.8em)
      #include "conclusiones.typ"
    ]
  ],
)

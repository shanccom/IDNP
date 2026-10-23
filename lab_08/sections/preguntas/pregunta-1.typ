= Pregunta 1: ¿Lograste resolver completamente el Ejercicio/Problema Resuelto por el Docente (lista de edificaciones que se filtra en tiempo real al escribir en el campo de búsqueda)? Adjunta una captura de pantalla del emulador mostrando el resultado como evidencia.

#pad(left:1.5em)[
Sí, se resolvió de forma completa y satisfactoria el ejercicio propuesto por el docente (`ListaFiltrable_Compose`).

La solución implementó con éxito la arquitectura reactiva en Jetpack Compose:
1. *Estado de búsqueda reactivo:* Se vinculó el campo `OutlinedTextField` a una variable de estado mutable (`var texto by remember { mutableStateOf("") }`), notificando cada cambio de texto a través de su callback `onValueChange`.
2. *Filtrado en tiempo real:* Se procesó la lista de edificios con el operador `.filter { it.nombre.contains(texto, ignoreCase = true) }`, recalculando dinámicamente el subconjunto de datos coincidentes en cada recomposición sin retrasos de interfaz.
3. *Composición perezosa eficiente:* Se desplegó la lista con `LazyColumn`, asignando la clave única `key = { it.id }` y reutilizando el composable `FilaEdificio` envuelto en contenedores `Card`.
4. *Manejo de escenarios límite:* Se validó que al borrar el texto se restaure la lista íntegra, y al ingresar términos sin coincidencias la interfaz se mantenga estable y limpia sin provocar excepciones ni cierres forzados.

=== Evidencias de Ejecución en el Emulador

  *Estudiante 1*
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: horizon + center,
  figure(
    image("../../img/resueltos/paso-10.1.png", width: 60%),
    caption: [Lista inicial completa de edificios desplegada en el emulador.]
  ),
  figure(
    image("../../img/resueltos/paso-10.2.png", width: 60%),
    caption: [Filtrado interactivo en tiempo real al escribir en el buscador.]
  ),
  figure(
    image("../../img/resueltos/paso-10.3.png", width: 60%),
    caption: [Coincidencia refinada mostrando la tarjeta específica.]
  )
)

  *Estudiante 2*
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 0.8em,
    align: horizon + center,
    figure(
      image("../../img/propuesta2/res-completo.png", width: 70%),
      caption: [Estudiante 2 : Lista inicial con todos los edificios.]
    ),
    figure(
      image("../../img/propuesta2/res-biblioteca.png", width: 70%),
      caption: [Estudiante 2 : Busqueda de biblioteca]
    ),
    figure(
      image("../../img/propuesta2/res-vacio.png", width: 70%),
      caption: [Estudiante 2 – Paso 11 (a): Búsqueda sin coincidencias registradas.]
    ),
  )

]
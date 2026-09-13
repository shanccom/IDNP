= Conclusiones

  #v(0.2em)
  #pad(1.1em)[
    * Conclusión 1:*
     Android Studio es una herramienta importante que simplifica el flujo de trabajo gracias a su integración con Gradle y herramientas de compilación en tiempo real.
    #v(0.2em)
     *Conclusión 2:* Jetpack Compose sustituye de manera eficiente el diseño tradicional basado en XML, nos ayuda a construir interfaces de usuario mediante código Kotlin puro con una sintaxis más limpia y directa.
    #v(0.2em)
    *Conclusión 3:* El uso de `remember` y `mutableStateOf` resulta muy útil en el desarrollo, ya que nos permite que la pantalla guarde lo que el usuario escribe y se actualice sola de forma automática, lo cual facilita mucho la creación de interfaces dinámicas.
    *Conclusión 4:* El uso de `openFileOutput` en modo `Context.MODE_PRIVATE` nos garantiza un mecanismo rápido y seguro para la persistencia de datos en el almacenamiento interno de la aplicación.
    #v(0.2em)
    *Conclusión 5:* Las herramientas como Logcat y la renderización dinámica mediante componentes `Text` facilitan el diagnóstico y la verificación inmediata del flujo de datos en la pantalla.
  ]

  #v(0.3em)

  = Recomendaciones

  #v(0.2em)
  #pad(1.1em)[
    * Recomendación 1:* Implementar validaciones previas en los campos de texto antes de procesar el guardado, para asegurarnos que los datos no estén vacíos y tengan el formato adecuado.
    #v(0.2em)
    * Recomendación 2:* Modularizar el proyecto separando los componentes `@Composable` en archivos Kotlin independientes nos ayuda a mantener un código estructurado y mantenible.
    #v(0.2em)
    *Recomendación 3:* En lugar de guardar la información en un archivo de texto simple (`.txt`), se sugiere usar herramientas más avanzadas como Room o DataStore, ya que estos nos permiten organizar y proteger mucho mejor los datos de la aplicación.
    #v(0.2em)
    * Recomendación 4:* Utilizar un dispositivo físico en caso de contar con recursos de hardware limitados para evitar la lentitud de los emuladores.
    #v(0.2em)
    * Recomendación 5:* Incluir el control de excepciones (`try-catch`) al realizar la lectura de archivos para prevenir fallos inesperados si el usuario intenta consultar registros inexistentes.
  ]

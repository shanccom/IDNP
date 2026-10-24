- Con la lista filtrable cambia como consecuencia del estado. Al declarar el texto de búsqueda con remember { mutableStateOf("") }, cada letra que el usuario escribe provoca una recomposición donde se vuelve a calcular la lista con .filter { ... }. Esto nos dejó claro que conviene tener una sola fuente de verdad para el estado y mantener el cálculo de la lista separado de la parte visual.

- También aprendimos a usar LazyColumn, que solo compone los elementos que se ven en pantalla, algo muy útil cuando hay muchos registros. Al usar items() con una clave estable (key = { it.id }) es por qué cada elemento necesita una identidad única y constante: sin ella se pierde el estado y se recomponen elementos sin necesidad, algo que no se nota con listas cortas en un Column normal.

- Al reemplazar la lista escrita directamente en Kotlin por la lectura de assets/edificios.txt, copiado al almacenamiento interno, es una ventaja para separar los datos de la presentación. ESto permite agregar nuevos edificios sin recompilar la app y reutilizar el mismo parser (parsearEdificios) tanto al ejecutar la aplicación como en la función \@Preview. 

- Al combinar el filtro por nombre con el menú desplegable de categorías, y agregar íconos y colores distintos para cada una, nos damos cuenta que una búsqueda es realmente útil cuando permite varios criterios y muestra el resultado con claridad. También comprobé que hay que manejar de forma explícita los casos límite, como cuando una búsqueda no tiene coincidencias.

#v(0.6em)
#block(text(weight: "bold")[Recomendaciones], below: 0.5em)

- Es mejor mantener el texto de búsqueda y la categoría seleccionada en el Composable contenedor y pasar a los componentes hijos solo los valores que necesitan. Así FilaEdificio o FiltroCategoria no manejan estados propios que podrían desincronizarse, y resulta más fácil añadir nuevos filtros sin rehacer la estructura visual.

- Envolver el cálculo de la lista filtrada en remember(texto, categoriaSeleccionada, edificios) { ... }, de modo que solo se ejecute cuando alguno de esos valores cambie y no en cada recomposición. Es una práctica sencilla que ayuda a distinguir entre cálculos costosos y trabajo trivial, y que sirve de base para pasar luego a derivedStateOf y ViewModel en proyectos más grandes.

- Recomiendo reforzar el manejo de datos inválidos en parsearEdificios, validando identificadores duplicados, etc. También sería bueno definir cómo actualizar el archivo de filesDir cuando cambie la versión incluida en assets, en vez de depender de borrar los datos de la aplicación.

- Por último, sugiero agregar desde el principio pruebas unitarias para parsearEdificios y filtrarEdificios, ya que son funciones puras que se pueden verificar sin emulador, y complementarlas con pruebas de interfaz para los casos de lista vacía, coincidencia exacta y combinación de filtros. 
= Pregunta 3: ¿Por qué es recomendable pasar un parámetro key = { it.id } a la función items() de una LazyColumn? ¿Qué podría ocurrir si no se especifica al filtrar o reordenar la lista?

Por defecto, cuando no se provee un parámetro `key`, `LazyColumn` utiliza la *posición numérica (índice 0, 1, 2...)* de cada elemento dentro de la lista para identificarlo en el árbol de composición.

Al especificar explícitamente `key = { it.id }` con un identificador único y estable:
- *Identidad semántica:* Jetpack Compose vincula la identidad persistente del objeto de datos con el nodo composable correspondiente en lugar de su ubicación transitoria.
- *Preservación de estado:* Permite al compilador y al runtime de Compose retener correctamente los estados internos (`remember`, variables mutables, animaciones, selecciones de usuario o foco) asociados a ese registro específico a lo largo de las recomposiciones.

Consecuencias de no especificar `key` al filtrar o reordenar

Si no se define una clave estable, ante cualquier modificación en la colección (filtrado por texto, selección de categoría, reordenamiento o eliminación) surgen fallas críticas:

1. *Pérdida o propagación errónea de estados locales (Bug de interfaz):* Si un ítem poseía un estado visual mutable (por ejemplo, una tarjeta expandida, un interruptor activado o un campo de texto), al cambiar el orden o filtrar elementos, dicho estado permanecerá anclado a la *posición ordinal*. En consecuencia, un elemento completamente diferente que ocupe esa posición heredará de manera indebida el estado previo.
2. *Degradación de rendimiento y parpadeos (Jank):* Compose no sabrá si un ítem se desplazó o si cambió por completo; por lo tanto, forzará la recomposición y redibujado innecesario de todos los composables visibles en lugar de simplemente reutilizar los nodos existentes.
3. *Fallo en animaciones de lista:* Los modificadores de animación (como `Modifier.animateItem()` o `animateItemPlacement()`) requieren obligatoriamente de una clave estable para calcular las trayectorias de interpolación espacial; sin ella, las transiciones de inserción, movimiento y descarte no pueden ejecutarse suavemente.

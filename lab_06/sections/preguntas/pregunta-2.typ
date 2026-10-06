= Pregunta 2: ¿Qué combinación de Composables (Row, Column, Box) y Modifiers consideras que fue la mejor opción para cada uno de los dos estilos de tarjeta implementados? Justifica tu respuesta comparando ambos casos.

== Respuesta 1

Para la primera tarjeta, considero que la mejor combinación fue Row para colocar la imagen a un lado y Column para organizar el título y la descripción verticalmente. Esto permitió que el contenido fuera legible y mantuviera una estructura horizontal equilibrada. Para la segunda tarjeta, Box fue la opción más adecuada, ya que nos permite apilar elementos y con align o padding logramos superponer el texto sobre la imagen sin romper el diseño. En comparación, la primera prioriza la organización jerárquica por filas y columnas, mientras que la segunda busca un enfoque más visual y centrado en la imagen.

== Respuesta 2

Coincido en que Row + Column es la mejor opción para el primer estilo: Row resuelve la disposición horizontal de imagen y texto, y Column apila título y descripción; los Modifiers `padding`, `size` y `clip(CircleShape)` dan espaciado y forma a la miniatura. Para el segundo estilo, Box es superior porque aprovecha la superposición en el eje Z: la imagen ocupa todo el contenedor con `matchParentSize` y el texto se ubica con `align(Alignment.BottomStart)`, mientras un scrim con `background(Color.Black.copy(alpha = 0.35f))` garantiza legibilidad. La diferencia clave es que el primer estilo prioriza la lectura de datos y el segundo el impacto visual.

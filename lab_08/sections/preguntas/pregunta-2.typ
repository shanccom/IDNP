= Pregunta 2: En el video de referencia se aborda el uso de LazyColumn. ¿Qué términos o conceptos nuevos, o que amplían lo visto en la sesión de teoría, se mencionan en el video? Explica brevemente.

El video de referencia aborda y profundiza conceptos esenciales para el diseño de interfaces escalables mediante `LazyColumn`:

1. *Sustitución declarativa de RecyclerView:* En contraste con el enfoque tradicional basado en vistas XML que exige clases intermedias (`RecyclerView.Adapter`, `ViewHolder`), inflado manual de layouts y métodos de enlace (`onBindViewHolder`), `LazyColumn` simplifica la construcción de listas declarando únicamente el bloque de renderizado en un scope directo (`LazyListScope`).
2. *Diferenciación entre `item` e `items`:* Se detalla el uso de la función `item` (en singular) para renderizar elementos individuales o estáticos (como encabezados de sección, banners o separadores) intercalados de forma natural con bloques `items` (en plural) que procesan listas dinámicas.
3. *Uso de `itemsIndexed`:* Se explica la alternativa a `items` que proporciona tanto el índice numérico (`index`) como el elemento (`item`), facilitando casos de uso como numeración secuencial de filas, coloreado alterno o condicional según paridad, y manipulación directa por posición.

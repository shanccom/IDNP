= Pregunta 3: ¿Qué diferencia encontraste entre construir estas interfaces con Composables y Modifier, en comparación con el enfoque clásico de LinearLayout/ConstraintLayout en XML? Menciona al menos una ventaja concreta que hayas notado.

== Respuesta 1

La principal diferencia es que en Compose todo es declarativo, es decir, se describe cómo debe verse la interfaz y el sistema se encarga de actualizarla, mientras que en XML con LinearLayout o ConstraintLayout es más imperativo y hay que lidiar con referencias y jerarquías más rígidas. Además, con Composables y Modifier se puede aplicar estilo, espaciado y alineación de manera más directa y reutilizable, sin necesidad de crear múltiples archivos o atributos anidados. Una ventaja concreta que noté fue la rapidez para hacer cambios: al modificar un Composable, el preview o la compilación es más ágil y puedo ver el resultado casi al instante, lo cual facilita mucho el proceso de diseño.

== Respuesta 2

La diferencia principal es de paradigma: en XML describimos una jerarquía de vistas estática que hay que actualizar manualmente, mientras que en Compose describimos el estado y la interfaz se redibuja sola. Los Modifiers reemplazan buena parte de los atributos XML (`layout_margin`, `padding`, `background`, `cornerRadius`) encadenados en una sola línea y reutilizables entre Composables. Una ventaja concreta que noté fue la reutilización: una misma función `TarjetaLugar` se invoca en distintas pantallas sin duplicar layouts, algo más engorroso de lograr con `include` y `merge` en XML.

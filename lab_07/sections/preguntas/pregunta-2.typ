= Pregunta 2: En tu propia implementación, ¿cómo calculaste si un toque cayó dentro de un marcador circular? ¿Qué otra estrategia se te ocurre para detectar toques sobre formas no circulares, como un rectángulo o un polígono?

== 1. Cálculo en marcadores circulares

Se utilizó la *distancia euclidiana* entre la coordenada del toque (`tap`) y el centro del marcador (`marcador.offset`):

$ d = sqrt((x_t - x_m)^2 + (y_t - y_m)^2) <= r $

En Compose se evalúa directamente con `(tap - marcador.offset).getDistance() <= marcador.radio`. Si la distancia es menor o igual al radio, el toque colisiona con el marcador.

== 2. Estrategias para formas no circulares

- *Rectángulos (Bounding Box):* Se valida si el punto cae dentro de los límites cartesianos ($x_0 <= x_t <= x_0 + w$ y $y_0 <= y_t <= y_0 + h$), lo cual en Compose se resuelve con `Rect(topLeft, size).contains(tap)`.
- *Polígonos (Ray-Casting):* Se traza un rayo horizontal imaginario desde el toque hacia el infinito; si cruza un número impar de aristas del polígono, el toque está dentro.
- *Regiones nativas (`android.graphics.Region`):* Se define la figura con un `Path` y se delega la comprobación al método nativo `region.contains(x, y)`.
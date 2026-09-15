== Pregunta 1: ¿Qué ventajas tiene usar Navigation Compose (una sola Activity con varias pantallas) frente al enfoque tradicional de múltiples Activities comunicadas por Intent?

#v(0.5em)

  Las principales ventajas son:

  - Transiciones más fluidas: al no destruir y recrear Activities, las animaciones entre pantallas son más rápidas y se pueden personalizar.
  - Compartición de estado: el estado se comparte fácilmente entre pantallas ya que todas comparten el mismo scope de la Activity.
  - Back stack más flexible: Navigation gestiona la pila de retroceso de forma más controlable.
  - Patrón unificado: todo se desarrolla en Compose, sin alternar entre intents y callbacks.
  - Mejor rendimiento: no hay sobrecarga de crear o destruir múltiples Activities.

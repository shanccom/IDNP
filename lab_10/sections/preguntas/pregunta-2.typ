= 2. En tu propia implementación, ¿qué ocurriría si la tarea dentro de onStartCommand() se ejecutara directamente en el hilo principal en lugar de una coroutine en Dispatchers.IO? Explica el efecto sobre la interfaz de usuario.


Si en la implementación hubiéramos puesto la tarea directamente dentro de `onStartCommand()` (por ejemplo, con un `Thread.sleep(3000)`) en vez de usar una coroutine en `Dispatchers.IO`, la tarea se ejecutaría en el hilo principal, porque un Service corre ahí por defecto. Como ese hilo es el que dibuja la pantalla y atiende los toques, en la interfaz ocurriría lo siguiente:

+ *La pantalla se congelaría:*
  Durante los 3 segundos de espera, el hilo principal no podría dibujar nada nuevo. El indicador de progreso (`CircularProgressIndicator`) no se movería y puede que ni siquiera llegara a aparecer al presionar el botón, porque el cambio de estado no se alcanzaría a dibujar hasta que termine la espera.

+ *La aplicación no respondería al tacto:*
  Cualquier toque, scroll o pulsación de otro botón durante esos 3 segundos se ignoraría, y daría la sensación de que la app "se colgó". Incluso el botón «Detener sincronización» del ejercicio propuesto no serviría.

+ *Habría riesgo de ANR:*
  Con solo 3 segundos probablemente no llegaría a ocurrir, pero si la tarea fuera más larga, Android muestra el aviso de "La aplicación no responde" (ANR) cuando la app no atiende un toque en 5 segundos, o cuando un Service no termina `onStartCommand()` en pocos segundos . En una sincronización real, que puede tardar más que esta simulación, esto sería un problema serio.

+ *Con la coroutine esto no pasa:*
  La espera se hace en otro hilo (`Dispatchers.IO`), así que el hilo principal queda libre: el indicador de progreso sigue girando y la app responde a los toques mientras se sincroniza. Por eso el ejercicio mueve la tarea a una coroutine.

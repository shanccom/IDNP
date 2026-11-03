= 2. En tu propia implementación, ¿qué ocurriría si la tarea dentro de onStartCommand() se ejecutara directamente en el hilo principal en lugar de una coroutine en Dispatchers.IO? Explica el efecto sobre la interfaz de usuario.

Si en mi propia implementación hubiera puesto la tarea pesada o bloqueante directamente dentro de `onStartCommand()` (por ejemplo, usando un `Thread.sleep(3000)` en vez de la corrutina), en la interfaz ocurriría lo siguiente:

+ *La pantalla se congelaría por completo:*
  El hilo principal se encarga de refrescar la pantalla a 60 fps (cada 16 ms) y de hacer girar las animaciones. Si lo mantengo ocupado durante 3 segundos, la interfaz no podría dibujar nuevos fotogramas. En mi app, el circulito de carga (`CircularProgressIndicator`) no se movería en absoluto; se quedaría totalmente congelado o ni siquiera llegaría a renderizarse tras presionar el botón.

+ *La aplicación dejaría de responder al tacto:*
  Cualquier intento de presionar otro botón, hacer scroll o interactuar con la pantalla durante esos 3 segundos sería ignorado, dando la molesta sensación de que la app "se colgó" o se trabó.

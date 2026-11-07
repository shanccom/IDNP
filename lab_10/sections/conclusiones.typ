- En conclusión, un `Service` no crea por sí solo un hilo secundario, sino que se ejecuta en el hilo principal de la aplicación. Por esta razón, aprendí que es indispensable combinarlo con corrutinas en `Dispatchers.IO` para procesar datos pesados de fondo sin congelar la pantalla ni generar caídas de rendimiento.

- Otra conclusión es que el `BroadcastReceiver` ayuda como un puente de comunicación entre el servicio y la interfaz en Compose de forma totalmente desacoplada. Esto evita que el servicio tenga que conocer la pantalla activa o retener referencias a la interfaz, previniendo así fugas de memoria y permitiendo que la UI reaccione naturalmente a las novedades.

- Se comprendió la importancia de gestionar responsablemente el ciclo de vida del servicio llamando a `stopSelf()` apenas se completa la tarea. Dejar procesos activos en segundo plano consume batería y memoria sin necesidad, por lo que finalizarlo a tiempo cuida los recursos del dispositivo y la estabilidad de la app.

- El uso de `DisposableEffect` junto a la directiva `RECEIVER_NOT_EXPORTED` ayudó a integrar de forma segura el receptor con Jetpack Compose. Esto permitió conectar y desconectar la escucha de datos automáticamente según el ciclo de vida de la pantalla, además de proteger la aplicación bloqueando posibles transmisiones no autorizadas desde apps externas.

#v(0.6em)
#block(text(weight: "bold")[Recomendaciones], below: 0.5em)

- Se recomienda evaluar WorkManager si en el futuro la sincronización debe completarse incluso al cerrar la app o reiniciar el dispositivo. Esta herramienta gestiona automáticamente las restricciones del sistema, la batería y la red, evitando que el proceso sea destruido en versiones recientes de Android.

- Se sugiere también implementar cancelación cooperativa asociando la corrutina en Dispatchers.IO a un Job. De esta manera, si el usuario detiene el proceso o se llama a stopService(), la tarea de red o cálculo se cancela inmediatamente con job?.cancel(), evitando emitir eventos innecesarios.

- Otra sugerencia es evolucionar hacia StateFlow o SharedFlow dentro de un ViewModel para la comunicación interna de la app. Esto simplifica las pruebas unitarias, elimina la serialización manual en los Intent y proporciona tipado estricto en tiempo de compilación.

- Finalmente, resulta clave validar la conectividad a la red mediante ConnectivityManager antes de iniciar el servicio para no ejecutar procesos destinados a fallar. Además, conviene enriquecer la interfaz mostrando estados de progreso e información clara sobre los errores para dar más transparencia al usuario.
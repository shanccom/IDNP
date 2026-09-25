= Ejercicio 2: Actualización manual del porcentaje de batería con broadcast personalizado

== Enunciado

Tomando como referencia el ejercicio resuelto por el docente, agrega una segunda forma de actualizar el porcentaje de batería, disparada manualmente en lugar de por el evento automático del sistema:

1. Agrega un botón "Actualizar manualmente" a `BatteryScreen`. Al presionarlo, en vez de esperar el evento del sistema, dispara un broadcast personalizado: crea un `Intent` con una acción propia (por ejemplo `com.tuapp.ACTUALIZAR_BATERIA`), envuélvelo en un `PendingIntent.getBroadcast(...)`, y actívalo con `PendingIntent.send()`.

2. Implementa un segundo `BroadcastReceiver` (o reutiliza el mismo patrón) que escuche esa acción personalizada y, al recibirla, vuelva a leer el estado de la batería (por ejemplo con `BatteryManager`) y actualice el mismo estado en pantalla.

3. Registra y desregistra este segundo receiver siguiendo el mismo patrón de `DisposableEffect` usado en el ejercicio resuelto.

4. (Reto opcional) Muestra en pantalla, además del porcentaje, si la batería se está cargando o no, usando `EXTRA_STATUS` del `Intent` original.

== Desarrollo

Solución desarrollada por el integrante encargado.
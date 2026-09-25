= Pregunta 2: En tu propia implementación, ¿qué diferencia encontraste entre recibir el evento automático del sistema (`ACTION_BATTERY_CHANGED`) y disparar un broadcast manualmente con `PendingIntent`? ¿En qué situaciones usarías cada uno?

== Respuesta

La principal diferencia radica en el control del flujo: el sistema emite `ACTION_BATTERY_CHANGED` de manera pasiva y automática, mientras que con `PendingIntent` decido el momento exacto en que se dispara la actualización bajo demanda.

En la práctica, el evento del sistema es sticky y entrega el estado actual de inmediato al suscribirse; en cambio, el broadcast manual requiere disparar explícitamente el intent para gatillar la lectura.

Utilizaría `ACTION_BATTERY_CHANGED` para paneles de monitoreo continuo o ahorro de energía, y el broadcast manual con `PendingIntent` para botones interactivos o refrescos solicitados directamente por el usuario.

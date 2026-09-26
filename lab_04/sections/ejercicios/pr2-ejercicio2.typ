
=== Paso 2: Implementa un segundo BroadcastReceiver (o reutiliza el mismo patrón) que escuche esa acción personalizada y, al recibirla, vuelva a leer el estado de la batería (por ejemplo con BatteryManager) y actualice el mismo estado en pantalla.

#pad(1.1em)[

    #v(0.5em)


    En este ejercicio se implementa el receptor encargado de procesar la acción personalizada disparada en el Ejercicio 1. Cuando se presiona el botón "Actualizar manualmente", el `PendingIntent` emite la acción `com.tuapp.ACTUALIZAR_BATERIA`. Este `BroadcastReceiver` la intercepta, consulta el estado actual de la energía y actualiza la variable `porcentaje` en la interfaz.


    === 1. El problema: el Intent personalizado no trae los extras de batería

    #pad(left: 1.1em)[
        A diferencia del evento del sistema `ACTION_BATTERY_CHANGED`, el `Intent` de nuestra acción personalizada `com.tuapp.ACTUALIZAR_BATERIA` llega completamente "vacío" (sin datos extras de carga).

        Por ello, dentro de `onReceive()`, no se leen los extras del `intent` recibido. En su lugar, se consulta al sistema operativo por el último estado conocido utilizando un registro temporal con `null`: al pasar `null` como receptor en `registerReceiver()`, Android nos devuelve directamente el último `Intent` "sticky" de la batería sin dejar un receptor registrado de forma permanente.
    ]

    === 2. Crear el segundo BroadcastReceiver

    #v(0.5em)
    #pad(left: 1.1em)[
        Se define el objeto `receiverManual`. Al recibir la señal, realiza la lectura del estado mediante el receptor temporal, extrae los valores crudos, calcula el porcentaje real y refresca la pantalla:

        #v(0.5em)
        #block[
    ```kotlin
        val receiverManual = object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent?) {
                // 1. Obtener la captura más reciente de la batería (Intent sticky)
                val batteryStatus = context?.registerReceiver(
                    null,
                    IntentFilter(Intent.ACTION_BATTERY_CHANGED)
                )

                // 2. Extraer el nivel actual y la escala máxima de carga
                val nivel = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
                val escala = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1

                // 3. Calcular el porcentaje correspondiente de 0 a 100%
                if (nivel != -1 && escala != -1) {
                    porcentaje = (nivel * 100) / escala
                }

                Log.d("BatteryScreen", "Actualización manual recibida")
            }
        }
    ```
        ]
        #v(0.5em)
    ]
    #figure(
        image("../../img/propuesta2/ej2.png", width: 100%),
        caption: [Segundo `BroadcastReceiver` implementado],
    ) <receiver-manual>


]

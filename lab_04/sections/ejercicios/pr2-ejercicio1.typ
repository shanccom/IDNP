
== Ejercicio 1: Agrega un botón "Actualizar manualmente" a BatteryScreen. Al presionarlo, en vez de esperar el evento del sistema, dispara un broadcast personalizado: crea un Intent con una acción propia (por ejemplo "com.tuapp.ACTUALIZAR_BATERIA"), envuélvelo en un PendingIntent.getBroadcast(...), y actívalo con PendingIntent.send().
#pad(1.1em)[


    #v(0.5em)


    En este ejercicio se agrega a `BatteryScreen` un botón que permite forzar la actualización del porcentaje de batería sin depender del evento automático `ACTION_BATTERY_CHANGED`. Para lograrlo se define una acción personalizada, se envuelve en un `PendingIntent` y se envía como un broadcast propio al presionar el botón.

    === 1. Definir la acción personalizada

    #pad(left: 1.1em)[
        Se declara, fuera del Composable, una constante con el nombre de la acción propia que identificará a este broadcast dentro de la aplicación:

        #v(0.5em)
        #block[
    ```kotlin
        const val ACTION_ACTUALIZAR_BATERIA = "com.tuapp.ACTUALIZAR_BATERIA"
    ```
        ]
        #v(0.5em)
    ]

    === 2. Nuevos imports

    #v(0.5em)
    #pad(left: 1.1em)[
        Se agregan `PendingIntent` (para envolver el Intent) y los componentes de UI necesarios para el botón:

        #block[
    ```kotlin
        import android.app.PendingIntent
        import androidx.compose.foundation.layout.Column
        import androidx.compose.material3.Button
    ```
        ]
    ]

    === 3. Agregar el botón "Actualizar manualmente"
    #v(0.5em)
    #pad(left: 1.1em)[
        Dentro del cuerpo de `BatteryScreen`, se agrega un `Button`. Al presionarlo se construye un `Intent` con la acción personalizada, se envuelve en un `PendingIntent.getBroadcast(...)` y se dispara con `.send()`:

        #v(0.5em)
        #block[
    ```kotlin
        Column(modifier = modifier) {
            Text("Batería: $porcentaje%")

            Button(onClick = {
                val intent = Intent(ACTION_ACTUALIZAR_BATERIA).apply {
                    setPackage(context.packageName)
                }

                val pendingIntent = PendingIntent.getBroadcast(
                    context,
                    0,
                    intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )

                pendingIntent.send()
            }) {
                Text("Actualizar bateria manualmente")
            }
        }
    ```
        ]
        #v(0.5em)
    ]
    === 4. Verificación
    #v(0.5em)
    #pad(left: 1.1em)[
        Al ejecutar el proyecto se muestra el botón "Actualizar manualmente" debajo del texto de porcentaje. Presionarlo no produce aún ningún cambio visible en pantalla (porque todavía no existe el receiver que escuche esta acción), pero en Logcat puede confirmarse que el broadcast se envía sin errores:

        #figure(
        image("../../img/ejercicios/ej1.png", width: 40%),
        caption: [Botón "Actualizar manualmente" agregado a `BatteryScreen`],
        ) <boton-actualizar>
    ]

]

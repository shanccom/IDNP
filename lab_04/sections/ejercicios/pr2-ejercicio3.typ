=== Paso 3: Registra y desregistra este segundo receiver siguiendo el mismo patrón de DisposableEffect usado en el ejercicio resuelto.

#v(0.5em)

En este ejercicio se activa el `receiverManual` definido en el Ejercicio 2, registrándolo con el sistema dentro de un `DisposableEffect` independiente, y liberándolo correctamente cuando el Composable sale de pantalla, siguiendo el mismo patrón que usa el docente para el receiver automático.

#pad(1.1em)[


  === 1. Segundo DisposableEffect

  #pad(left: 1.1em)[
    Se agrega un nuevo bloque `DisposableEffect(Unit)`, separado del que registra el receiver automático, dedicado exclusivamente al `receiverManual`. Dentro se llama a `context.registerReceiver(...)` filtrando por la acción personalizada y se imprime un mensaje de confirmación por consola:

    #v(0.5em)
    #block[
```kotlin
      DisposableEffect(Unit) {
        
        ContextCompat.registerReceiver(
            context,
            receiverManual,
            IntentFilter(ACTION_ACTUALIZAR_BATERIA),
            ContextCompat.RECEIVER_NOT_EXPORTED
        )
          Log.d("BatteryScreen", "Receiver manual registrado")

          onDispose {
              context.unregisterReceiver(receiverManual)
              Log.d("BatteryScreen", "Receiver manual desregistrado")
          }
      }
```
    ]
    #v(0.5em)
  ]

  === 2. Por qué se usa `RECEIVER_NOT_EXPORTED`
  #v(0.5em)
  #pad(left: 1.1em)[
    A partir de Android 13 (API 33), todo `registerReceiver` dinámico debe declarar explícitamente si el receiver puede recibir broadcasts de otras aplicaciones (`RECEIVER_EXPORTED`) o solo de la propia app (`RECEIVER_NOT_EXPORTED`). Se usa `RECEIVER_NOT_EXPORTED` por seguridad, evitando que otras apps puedan activar este receiver.
  ]

  === 3. Verificación
  #v(0.5em)
  #pad(left: 1.1em)[
    
    En Logcat, filtrando por la etiqueta "BatteryScreen", se observan los mensajes "Receiver manual registrado" al entrar a la pantalla, "Actualización manual recibida" cada vez que se presiona el botón, y "Receiver manual desregistrado" al salir:

    #figure(
      image("../../img/propuesta2/ej3.png", width: 100%),
      caption: [Logcat mostrando registro, actualización manual y desregistro del segundo receiver],
    ) <logcat-manual>
  ]
]

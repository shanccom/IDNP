=== Paso 4 (Reto opcional): Muestra en pantalla, además del porcentaje, si la batería se está cargando o no, usando EXTRA_STATUS del Intent original.

#v(0.5em)

En este ejercicio se agrega una segunda variable de estado que indica si el dispositivo está cargando, obtenida a partir de `EXTRA_STATUS`. Esta variable se actualiza tanto desde el receiver automático como desde el receiver manual, y se muestra en un segundo `Text` junto al porcentaje.

#pad(1.1em)[

  === 1. Nueva variable de estado

  #pad(left: 1.1em)[
    Se declara `cargando`, junto a `porcentaje`, para almacenar si la batería está en proceso de carga:

    #v(0.5em)
    #block[
```kotlin
      var cargando by remember { mutableStateOf(false) }
```
    ]
    #v(0.5em)
  ]

  === 2. Leer EXTRA_STATUS en el receiver automático
  #v(0.5em)
  #pad(left: 1.1em)[
    Dentro de `onReceive()` del receiver del Ejercicio resuelto por el docente, además de `EXTRA_LEVEL` y `EXTRA_SCALE`, se extrae `EXTRA_STATUS` y se compara contra las constantes `BatteryManager.BATTERY_STATUS_CHARGING` y `BATTERY_STATUS_FULL` (batería llena conectada al cargador también cuenta como "cargando" a efectos prácticos):

    #v(0.5em)
    #block[
```kotlin
      val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1

      cargando = status == BatteryManager.BATTERY_STATUS_CHARGING ||
              status == BatteryManager.BATTERY_STATUS_FULL
```
    ]
    #v(0.5em)
  ]

  === 3. Leer EXTRA_STATUS en el receiver manual
  #v(0.5em)
  #pad(left: 1.1em)[
    El mismo cálculo se agrega dentro de `receiverManual`, ya que este también consulta el estado real de la batería mediante `registerReceiver(null, ...)` y por lo tanto también tiene acceso a `EXTRA_STATUS`:

    #v(0.5em)
    #block[
```kotlin
      val status = batteryStatus?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1

      cargando = status == BatteryManager.BATTERY_STATUS_CHARGING ||
              status == BatteryManager.BATTERY_STATUS_FULL
```
    ]
    #v(0.5em)
  ]

  === 4. Mostrar el estado en pantalla
  #v(0.5em)
  #pad(left: 1.1em)[
    En el cuerpo de `BatteryScreen`, debajo del `Text` del porcentaje, se agrega un segundo `Text` que refleja `cargando`:

    #v(0.5em)
    #block[
```kotlin
      Text(text = if (cargando) "Estado: Cargando" else "Estado: No cargando")
```
    ]
    #v(0.5em)
  ]

  === 5. Verificación
  #v(0.5em)
  #pad(left: 1.1em)[
    Desde Extended Controls > Battery del emulador, al cambiar el "Charge state" entre `Charging` y `Discharging`, el texto de estado cambia automáticamente entre "Estado: Cargando" y "Estado: No cargando", tanto por el evento del sistema como al presionar "Actualizar manualmente":

    #figure(
      image("../../img/propuesta2/ej4-1.png", width: 90%),
      caption: [Pantalla mostrando porcentaje y estado de carga "NO CARGANDO"],
    ) <estado-carga>

    #figure(
      image("../../img/propuesta2/ej4-2.png", width: 90%),
      caption: [Pantalla mostrando porcentaje y estado de carga "CARGANDO"],
    ) <estado-carga-2>

  ]
]
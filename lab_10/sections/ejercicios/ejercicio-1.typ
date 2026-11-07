= EJERCICIOS/PROBLEMAS PROPUESTOS

Amplía el ejercicio resuelto para dar más control al usuario sobre la sincronización:
= Propuesta 1 

= 1. Agrega un botón "Detener sincronización" que llame a context.stopService(Intent(context, SincronizacionService::class.java)) mientras la tarea está en curso.

#pad(1.1em)[

Para detener la sincronización en ejecución, se extendió la interfaz en `PantallaSincronizacion()` dentro de `MainActivity.kt`.

=== Cambios Realizados
#pad(left:1.1em)[

- *Archivo modificado:* MainActivity.kt

1. *Nuevo estado `enCurso`:* Se incorporó `var enCurso by remember { mutableStateOf(false) }` para modelar de forma reactiva si el servicio de sincronización está activo.
2. *Inicio de sincronización:* Al pulsar *"Sincronizar"*, se reinicia `resultado = null`, se asigna `enCurso = true` y se invoca `context.startService(...)`.
3. *Finalización por Broadcast:* En el `BroadcastReceiver`, al recibir la confirmación de término de sincronización, se asigna `enCurso = false` y se actualiza el mensaje con los edificios procesados.
4. *Botón "Detener sincronización":* Se añadió un botón condicional visible únicamente mientras `enCurso == true`. Al hacer clic, invoca `context.stopService(Intent(context, SincronizacionService::class.java))` y actualiza el estado local a `enCurso = false`.
5. *Indicador visual reactivo:* El componente `CircularProgressIndicator()` se gobierna ahora según el valor de `enCurso` (en lugar de evaluar `resultado == null`).
6. *Alcance de modificaciones:* No se requirió alterar el servicio `SincronizacionService`, el archivo `AndroidManifest.xml` ni las importaciones previas.
]
=== Código Implementado en `PantallaSincronizacion()`

```kotlin
// 1. Estado reactivo para rastrear si la sincronización está activa
var enCurso by remember { mutableStateOf(false) }

// En el BroadcastReceiver:
val receiver = object : BroadcastReceiver() {
    override fun onReceive(c: Context?, intent: Intent?) {
        val cantidad = intent?.getIntExtra("CANTIDAD", 0) ?: 0
        resultado = "Sincronización completa: $cantidad edificios actualizados"
        // 3. Se desactiva el estado al recibir el aviso de finalización
        enCurso = false
    }
}

// Dentro del Column:
Button(onClick = {
    resultado = null
    // 2. Se activa el estado al iniciar el servicio
    enCurso = true
    context.startService(Intent(context, SincronizacionService::class.java))
}) {
    Text("Sincronizar")
}

// 4. Botón visible únicamente mientras la tarea está en curso
if (enCurso) {
    Spacer(modifier = Modifier.height(16.dp))
    Button(onClick = {
        context.stopService(Intent(context, SincronizacionService::class.java))
        enCurso = false
    }) {
        Text("Detener sincronización")
    }
}

Spacer(modifier = Modifier.height(16.dp))

// 5. El indicador de carga o el resultado se renderizan según enCurso
if (enCurso) {
    CircularProgressIndicator()
} else {
    Text(resultado ?: "")
}
```
=== Evidencias

#figure(
  image("../../img/propuestos/ejercicio-1.1.png", width: 100%),
  caption: [Implementación en `MainActivity.kt` y visualización simultánea de la interfaz en Android Studio.],
)

#figure(
  image("../../img/propuestos/ejercicio-1.png", width: 45%),
  caption: [Emulador ejecutando la sincronización, mostrando el botón "Detener sincronización" y el indicador de progreso activo.],
)


]
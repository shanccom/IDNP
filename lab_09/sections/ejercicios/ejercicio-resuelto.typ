= Ejercicio resuelto por el docente

#let captura(caption, ruta: none, width: 50%) = figure(
  if type(ruta) == array {
    align(center, block(width: 75%, grid(
      columns: (1fr, 1fr),
      gutter: 0.8em,
      ..ruta.map(r => image(r, width: 100%))
    )))
  } else if ruta == none {
    align(center, rect(
      width: 50%,
      height: 4cm,
      stroke: 0.5pt + gray,
      radius: 2pt,
    )[#align(center + horizon)[_Captura de pantalla pendiente_]])
  } else {
    image(ruta, width: width)
  },
  caption: caption,
)

== Paso 1. Crear un nuevo proyecto

nombre sugerido para el proyecto: “PersistenciaRoom_Compose”, Package name:
com.example.persistenciaroom_compose, Language: Kotlin, Minimum SDK: el que venga por defecto en la
plantilla (recuerden usar un emulador o dispositivo con API 34 o superior, según la sección de Recursos a
utilizar).

#captura(
  ruta: "../../img/resuelto/paso-1.png",
  width: 52%,
)[Paso 1: creación del proyecto PersistenciaRoom_Compose en Android Studio con Kotlin y el SDK
mínimo de la plantilla.]

== Paso 2. Configurar Gradle para usar Room con KSP

Se modifican tres archivos, en este orden (las versiones indicadas funcionaron con Android Studio con AGP
9.3.3 y Kotlin 2.2.10; si tu proyecto usa otras versiones, revisa la nota que sigue a los códigos):

Nota (versiones y errores de sincronización). Las versiones dependen de tu Android Studio; en algunos casos
hay que cambiarlas:

- Plugin [id: 'com.google.devtools.ksp'] was not found: KSP está sin versión. Debe declararse con versión
  en libs.versions.toml y aplicarse con alias(libs.plugins.ksp) dentro de plugins { }. La línea
  ksp("androidx.room:room-compiler:...") va dentro de dependencies { }.
- [ksp] IllegalStateException: unexpected jvm signature V: ocurre con Room 2.6.1 y un KSP nuevo. Usar
  Room 2.7.0 o superior en las tres líneas. Si Gradle no encuentra 2.7.2, probar 2.7.0 o 2.8.0.
- Con AGP 9 se necesita KSP 2.3.1 o superior (se recomienda 2.3.6). Si el Sync indica que KSP no es
  compatible con tu versión de Kotlin, cambiar la versión de KSP (por ejemplo 2.3.12). En proyectos con
  AGP 8.x, KSP usa el formato <Kotlin>-<KSP>, por ejemplo 2.2.10-2.0.2.
- Unresolved reference 'compose' o 'viewModel': falta lifecycle-viewmodel-compose; usar la misma versión
  que lifecycleRuntimeKtx del libs.versions.toml.
- Después de editar los archivos, pulsar Sync Now. Si quedan errores rojos en crearBaseDeDatos o
  edificioDao, ejecutar Build > Rebuild Project para que KSP genere las clases de Room.

#captura(
  ruta: (
    "../../img/resuelto/paso-2.1.png",
    "../../img/resuelto/paso-2.2.png",
    "../../img/resuelto/paso-2.3.png",
  ),
)[Paso 2: configuración de Gradle con las versiones de KSP y las dependencias de Room en
libs.versions.toml, build.gradle.kts del proyecto y build.gradle.kts del módulo app, junto con el Sync
Now completado sin errores.]

== Paso 3. Agregar las importaciones

Agregar, debajo del package y antes de la clase MainActivity, todas las importaciones que se usarán en este
ejercicio (incluye Preview, porque la plantilla del proyecto conserva Greeting y GreetingPreview; sin ese
import aparece Unresolved reference 'Preview'):

#captura(
  ruta: "../../img/resuelto/paso-3.png",
  width: 42%,
)[Paso 3: importaciones agregadas debajo del package y antes de la clase MainActivity en
MainActivity.kt.]

== Paso 4. Definir la entidad EdificioEntity

Definir la entidad EdificioEntity:

#captura(
  ruta: "../../img/resuelto/paso-4.png",
  width: 48%,
)[Paso 4: código de la entidad EdificioEntity con su clave primaria autogenerada, nombre y
categoría.]

== Paso 5. Definir la entidad AmbienteEntity

Definir la entidad AmbienteEntity, agregando una ForeignKey que la relacione con EdificioEntity:

#captura(
  ruta: "../../img/resuelto/paso-5.png",
  width: 48%,
)[Paso 5: código de la entidad AmbienteEntity con la ForeignKey que la relaciona con
EdificioEntity.]

== Paso 6. Crear la interfaz EdificioDao

Crear la interfaz EdificioDao con las operaciones básicas de inserción, actualización, borrado y una
consulta simple. Por ahora dejamos un comentario donde irá la consulta relacional:

#captura(
  ruta: "../../img/resuelto/paso-6.png",
  width: 25%,
)[Paso 6: interfaz EdificioDao con las operaciones de inserción, actualización, borrado y la
consulta simple de edificios.]

== Paso 7. Definir EdificioConAmbientes

Definir la clase intermedia EdificioConAmbientes con `@Embedded` y `@Relation`, y agregar en el mismo Dao
una consulta `@Transaction` que la devuelva. Con esto, EdificioDao queda completo:

#captura(
  ruta: "../../img/resuelto/paso-7.png",
  width: 40%,
)[Paso 7: clase EdificioConAmbientes con `@Embedded` y `@Relation`, y la consulta `@Transaction` que
devuelve los edificios con sus ambientes.]

== Paso 8. Crear la clase AppDatabase

Crear la clase AppDatabase reuniendo ambas entidades y exponiendo el Dao, junto a una función que la
instancie una sola vez con Room.databaseBuilder:

#captura(
  ruta: "../../img/resuelto/paso-8.png",
  width: 50%,
)[Paso 8: clase AppDatabase con las dos entidades y la función crearBaseDeDatos que usa
Room.databaseBuilder.]

== Paso 9. Crear el EdificiosViewModel

Crear un EdificiosViewModel que, al iniciar, inserte (si la base está vacía) 2 edificios de muestra con sus
ambientes mediante una coroutine, y exponga el resultado de obtenerConAmbientes() como un StateFlow
observable. Como el ViewModel necesita el Dao en su constructor, se agrega también un Factory sencillo:

#captura(
  ruta: "../../img/resuelto/paso-9.png",
  width: 35%,
)[Paso 9: clase EdificiosViewModel con la inserción de los datos de muestra y el
EdificiosViewModelFactory.]

== Paso 10. Crear el Composable ListaEdificiosConAmbientes

Crear el Composable ListaEdificiosConAmbientes, que observe el StateFlow del ViewModel y muestre el
resultado en una LazyColumn, agrupando visualmente los ambientes bajo el nombre de cada edificio:

#captura(
  ruta: "../../img/resuelto/paso-10.png",
  width: 38%,
)[Paso 10: Composable ListaEdificiosConAmbientes mostrando los edificios y sus ambientes en una
LazyColumn.]

== Paso 11. Modificar MainActivity

Dentro de MainActivity, crear la base de datos, el Dao y el Factory, y mostrar
ListaEdificiosConAmbientes dentro de setContent:

#captura(
  ruta: "../../img/resuelto/paso-11.png",
  width: 45%,
)[Paso 11: MainActivity completo con la creación de la base de datos, el Dao, el Factory y la
llamada a ListaEdificiosConAmbientes dentro de setContent.]

== Paso 12. Ejecutar la aplicación

Ejecutar la aplicación en un emulador y verificar en la LazyColumn que los edificios aparecen junto con sus
ambientes; cerrar y volver a abrir la aplicación y confirmar que los datos siguen ahí (persisten en la base
de datos local).
#v(1em)

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    *Pruebas de Integrante 1*
    #captura(
      ruta: "../../img/resuelto/paso-12.png",
      width: 60%,
    )[Paso 12-Integrante 1: aplicación en ejecución en el emulador, mostrando los edificios con sus ambientes en la LazyColumn después de cerrar y volver a abrir la aplicación.]
  ],
  [
    *Pruebas de Integrante 2*
    #captura(
      ruta: "/img/propuesta2/re-completo.png",
      width: 60%,
    )[Paso 12-Integrante 2: ejecución con los edificios y sus ambientes.]
  ]
)#v(1em)

== Paso 13. Verificar la base de datos

Verificar la base de datos: Room usa SQLite y guarda el archivo app.db dentro del dispositivo. Con la app en
ejecución, abrir View > Tool Windows > App Inspection > Database Inspector y revisar las tablas
EdificioEntity y AmbienteEntity (deben verse 2 edificios y 3 ambientes).

*Pruebas de Integrante 1*
#captura(
  ruta: "../../img/resuelto/paso-13.png",
  width: 75%,
)[Paso 13: Database Inspector mostrando las tablas EdificioEntity y AmbienteEntity de la base de
datos app.db, con 2 edificios y 3 ambientes.]

*Pruebas de Integrante 2*

#captura(
  ruta: "/img/propuesta2/re-ambientes.png",
  width: 70%,
)[Paso 13 (Integrante 2): Database Inspector mostrando la tabla AmbienteEntity de app.db, con 3 ambientes.]
    #v(0.5em)
    #captura(
      ruta: "/img/propuesta2/re-edificio.png",
      width: 70%,
    )[Paso 13 (Integrante 2): Database Inspector mostrando las tablas EdificioEntity]

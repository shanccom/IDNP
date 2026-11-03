= 3. ¿En dónde almacena Room los datos de la aplicación (almacenamiento interno o externo del dispositivo)? Justifica tu respuesta y explica qué implica para la privacidad de los datos del usuario.
#pad(1.5em)[

*Respuesta:*

Room almacena las bases de datos en el almacenamiento interno privado del dispositivo (`Internal Storage`), dentro del directorio sandbox asignado exclusivamente a la aplicación por el sistema operativo Android @appspecific:

$ "/data/data/<package_name>/databases/<database_name>.db" $

Para este proyecto, la ruta concreta en el sistema de archivos corresponde a:
`/data/data/com.example.persistenciaroom_compose/databases/app.db` (acompañada por sus archivos de registro en modo WAL: `app.db-wal` y `app.db-shm`).

== 1. Justificación técnica

- *Comportamiento de `Room.databaseBuilder`:* Al instanciar la base de datos con `Room.databaseBuilder(context, AppDatabase::class.java, "app.db")` @room, el framework delega la resolución del archivo al método del framework `context.getDatabasePath("app.db")`, el cual apunta intrínsecamente al almacenamiento interno privado de la app.
- *Modelo de aislamiento de Android (Sandbox de Linux):* En el sistema operativo Android, cada aplicación se ejecuta con un UID (User ID) único dentro del kernel de Linux @sandbox. El directorio `/data/data/<package_name>` se crea con permisos Unix estrictos (`rwx------`) @sandbox, impidiendo que procesos con otro identificador de usuario puedan listar, leer o escribir en sus archivos.

== 2. Implicaciones para la privacidad de los datos del usuario
#pad(left:1.5em)[
+ *Aislamiento y confidencialidad frente a terceros:* Ninguna otra aplicación instalada en el dispositivo puede acceder ni leer la base de datos `app.db`, resguardando la información sin necesidad de solicitar permisos especiales en tiempo de ejecución (`Runtime Permissions`) @appspecific.
+ *Ciclo de vida sincronizado con la aplicación:* Al desinstalar la aplicación o limpiar su almacenamiento desde _Ajustes > Aplicaciones_, el sistema operativo purga automáticamente el directorio privado, garantizando que no queden datos residuales huérfanos @appspecific.
+ *Inaccesibilidad en dispositivos no modificados:* Los datos permanecen ocultos ante exploradores de archivos estándar; únicamente son accesibles en entornos de depuración autorizados mediante ADB (`Database Inspector` de Android Studio) o en dispositivos que cuenten con acceso `root`.
+ *Compatibilidad con cifrado en reposo:* Si se requiere proteger la información frente a extracciones forenses físicas en dispositivos vulnerados, Room se integra directamente con bibliotecas como *SQLCipher* @sqlcipher, cifrando el archivo SQLite en almacenamiento interno mediante el algoritmo AES-256 @commonsware.

]
]

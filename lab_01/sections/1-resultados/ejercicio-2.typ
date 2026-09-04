= Ejercicio 2: Elabora un cuadro comparativo entre aplicación móvil, aplicación web y aplicación de escritorio, considerando al menos: dispositivo donde se ejecuta, conexión a internet, instalación, acceso a recursos del equipo y ejemplos.

#v(1em)

#let hc(body) = table.cell(fill: rgb("#708090"))[#text(fill: white)[#body]]

#table(
  columns: (1fr, 1.2fr, 1.2fr, 1.2fr),
  align: left,
  table.header(
    [#hc[Característica]], [#hc[Aplicación Móvil]], [#hc[Aplicación Web]], [#hc[Aplicación de Escritorio]],
  ),

  [*Entorno de ejecución*],
  [En sistema operativo movil como iOS Android.],
  [En navegadores web como Chrome, Firefox, Safari, etc.],
  [En sistema operativo de escritorio como Windows, macOS o Linux.],


  [*Dispositivo donde se ejecuta*],
  [En dispositivos moviles como teléfonos inteligentes y tabletas.],
  [En cualquier dispositivo con un navegador web, como en una PC, móvil, TV.],
  [En computadoras de escritorio y laptops.],


  [*Conexión a internet*],
  [*Opcional / Deseable.* Muchas funciones o datos locales pueden trabajar sin conexión (*offline*).],
  [*Obligatoria.* Requiere conexión constante para cargar la interfaz y los datos desde el servidor.],
  [*Opcional.* Puede funcionar al 100\% de forma local, salvo que requiera sincronizar datos en la nube.],

  [*Instalación*],
  [*Requerida.* Se descarga e instala obligatoriamente desde tiendas oficiales  como App Store o Google Play.],
  [*No requerida.* Se accede directamente mediante la URL o dirección web en el navegador.],
  [*Requerida.* Se descarga un archivo ejecutable (`.exe`, `.dmg`, `.deb`) y se instala en el sistema operativo.],

  [*Acceso a recursos del equipo*],
  [*Alto.* Tienen acceso directo a los componentes nativos mediante permisos que el usuario otorga. Esto les permite utilizar los componente como la cámara, GPS, contactos, notificaciones push, Bluetooth y biometría.],
  [*Bajo / Limitado.* Estan restringidos por la seguridad del  para proteger al usuario. Se tiene un acceso limitado para acceder a recursos como la cámara o micrófono con permiso si el usuario lo autoriza.],
  [*Total / Muy alto.* Ya que se ejecutan directamnete sobre el sistema operativo, les permite un acceso completo al sistema de archivos, memoria RAM, tarjeta gráfica y periféricos conectados.],

  [*Rendimiento/Velocidad*],
  [*Alto.* Al estar instalada de forma local y compilada directamente para el chip del celular, su tiempo de respuesta es óptimo. El renderizado es fluido y aprovecha la aceleración por hardware del dispositivo móvil.],
  [*Variable / Dependiente*. Su rendimiento depende de la calidad de la conexión a internet del usuario y de la latencia del servidor remoto. El navegador debe descargar e interpretar los recursos en cada visita.],
  [*Máximo*. Ya que se ejecutan directamente sobre el sistema operativo, les permite un acceso directo y sin intermediarios a la memoria RAM, al procesador y a la tarjeta gráfica, es ideal para realizar tareas pesadas.],

  [*Ejemplos*],
  [WhatsApp (App móvil), Instagram, Uber, Duolingo, Spotify (App).],
  [Google Docs, Canva, Trello, Netflix (versión web), Amazon.],
  [Adobe Photoshop, Microsoft Word (local), VS Code, Steam, VLC Media Player.]
)
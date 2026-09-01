= Elabora un cuadro comparativo entre aplicación móvil, aplicación web y aplicación de escritorio, considerando al menos: dispositivo donde se ejecuta, conexión a internet, instalación, acceso a recursos del equipo y ejemplos.

#table(
  columns: (auto, 1fr, 1fr, 1fr),
  align: (left, left, left, left),
  stroke: 0.5pt,
  inset: 8pt,

  [*Característica*],
  [*Aplicación Móvil*],
  [*Aplicación Web*],
  [*Aplicación de Escritorio*],

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
  [*No requerida.* Se accede directamente mediante una URL o dirección web en el navegador.],
  [*Requerida.* Se descarga un archivo ejecutable (`.exe`, `.dmg`, `.deb`) y se instala en el sistema operativo.],

  [*Acceso a recursos del equipo*],
  [*Alto.* Acceso profundo al hardware: cámara, GPS, contactos, notificaciones push, Bluetooth y biometría.],
  [*Bajo / Limitado.* Restringido por la seguridad del navegador (acceso limitado a cámara o micrófono con permiso).],
  [*Total / Muy alto.* Acceso completo al sistema de archivos, memoria RAM, tarjeta gráfica y periféricos conectados.],

  [*Ejemplos*],
  [WhatsApp (App móvil), Instagram, Uber, Duolingo, Spotify (App).],
  [Google Docs, Canva, Trello, Netflix (versión web), Amazon.],
  [Adobe Photoshop, Microsoft Word (local), VS Code, Steam, VLC Media Player.]
)
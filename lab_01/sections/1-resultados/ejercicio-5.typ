= Plantea una idea sencilla de aplicación móvil que ayude a resolver una necesidad real, indicando: nombre de la app, problema que busca resolver, usuario al que está dirigida, funciones básicas y posible estructura de pantallas. Este ejercicio servirá como base para el trabajo de las siguientes unidades.

  *Nombre de la app:* Medifácil

  *Problema a resolver:* Automatización de clínicas fisioterapeutas pequeñas y consultorios médicos que aún gestionan citas, historiales y pagos de forma manual, generando demoras, errores y pérdida de pacientes.

  *Público dirigido:* Médicos generales, dentistas, psicólogos y demás profesionales de salud que atienden en consultorios privados o clínicas pequeñas. También los pacientes que buscan agilizar el proceso de reserva y seguimiento.

  *Funciones básicas:*
  - Historial clínico digital del paciente accesible desde el móvil.
  - Panel de control del médico con estadísticas de consultas diarias.
  - Chat médico-paciente para consultas previas a la cita.

  *Estructura de pantallas:*

  #table(
    columns: 2,
    align: (left, left),
    [*Pantalla*], [*Descripción*],
    [Panel principal (Paciente)], [Menú con opciones: Reservar cita, Mis citas, Historial, Pagos, Perfil.],
    [Dashboard(Médico)], [Menú con opciones: Agenda del día, Pacientes, Estadísticas, Configuración.],
    [Reservar cita], [Selección de especialidad, médico disponible y horario en calendario.],
    [Detalle de cita], [Información completa de la cita: médico, fecha, hora, motivo y estado.],
    [Historial clínico], [Lista de consultas anteriores con diagnóstico, tratamiento y notas.],
    [Chat], [Conversación directa médico-paciente con opción de enviar archivos.],
    [Perfil], [Datos personales, configuración de notificaciones y preferencias.],
  )

  #figure(
    image("../../img/MediFacil.png", width: 27%),
    caption: [Mockup de la aplicación Medifácil]
  )

  #figure(
    image("../../img/MediFacil_Agenda.png", width: 27%),
    caption: [Mockup de la aplicacion Medifacil la parte de Agenda]
  )

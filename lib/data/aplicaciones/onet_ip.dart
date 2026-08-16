import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del O*NET IP (sí/no).
const List<OpcionRespuesta> _opcionesIp = [
  OpcionRespuesta(etiqueta: 'No', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí', valor: 1),
];

/// Bandas referenciales de cada escala RIASEC (0-5).
const List<RangoPuntuacion> _bandasEscala = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 0,
    maximo: 5,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte; se interpreta por el perfil.',
    descriptiva: true,
  ),
];

/// O*NET Interest Profiler (Mini-IP, 30 ítems; Departamento de Trabajo
/// de EE. UU.).
///
/// Explora los intereses vocacionales según el modelo RIASEC de Holland.
/// El perfil resultante (las escalas más altas) orienta hacia las áreas
/// ocupacionales de interés.
const InstrumentoAplicable onetIpAplicable = InstrumentoAplicable(
  id: 'onet-ip',
  sigla: 'O*NET IP',
  titulo: 'Inventario de Intereses de O*NET (Mini-IP)',
  instrucciones: 'Indique si le gustaría realizar cada actividad.',
  preguntas: [
    Pregunta(texto: 'Construir gabinetes de cocina', opciones: _opcionesIp),
    Pregunta(texto: 'Reparar electrodomésticos', opciones: _opcionesIp),
    Pregunta(texto: 'Colocar ladrillos o azulejos', opciones: _opcionesIp),
    Pregunta(texto: 'Ensamblar partes electrónicas', opciones: _opcionesIp),
    Pregunta(texto: 'Manejar un camión', opciones: _opcionesIp),
    Pregunta(texto: 'Estudiar los viajes espaciales', opciones: _opcionesIp),
    Pregunta(
        texto: 'Estudiar la estructura del cuerpo humano',
        opciones: _opcionesIp),
    Pregunta(
        texto: 'Trabajar en un laboratorio de biología', opciones: _opcionesIp),
    Pregunta(
        texto: 'Investigar sobre plantas o animales', opciones: _opcionesIp),
    Pregunta(
        texto: 'Estudiar las causas de los terremotos', opciones: _opcionesIp),
    Pregunta(texto: 'Escribir una obra de teatro', opciones: _opcionesIp),
    Pregunta(texto: 'Tocar un instrumento musical', opciones: _opcionesIp),
    Pregunta(texto: 'Pintar cuadros', opciones: _opcionesIp),
    Pregunta(
        texto: 'Crear efectos especiales para películas',
        opciones: _opcionesIp),
    Pregunta(texto: 'Componer o arreglar música', opciones: _opcionesIp),
    Pregunta(
        texto: 'Enseñar a los niños a jugar deportes', opciones: _opcionesIp),
    Pregunta(
        texto: 'Dar orientación profesional a las personas',
        opciones: _opcionesIp),
    Pregunta(
        texto:
            'Realizar trabajo voluntario en una organización sin fines de lucro',
        opciones: _opcionesIp),
    Pregunta(
        texto: 'Ayudar a las personas con problemas personales o emocionales',
        opciones: _opcionesIp),
    Pregunta(
        texto: 'Enseñar a alguien una rutina de ejercicios',
        opciones: _opcionesIp),
    Pregunta(texto: 'Gestionar una tienda minorista', opciones: _opcionesIp),
    Pregunta(
        texto: 'Vender mercancía en una tienda departamental',
        opciones: _opcionesIp),
    Pregunta(texto: 'Operar una peluquería o barbería', opciones: _opcionesIp),
    Pregunta(texto: 'Dirigir un pequeño negocio', opciones: _opcionesIp),
    Pregunta(texto: 'Vender casas', opciones: _opcionesIp),
    Pregunta(
        texto: 'Llevar registros de transacciones financieras',
        opciones: _opcionesIp),
    Pregunta(texto: 'Organizar y mantener archivos', opciones: _opcionesIp),
    Pregunta(texto: 'Clasificar y distribuir el correo', opciones: _opcionesIp),
    Pregunta(
        texto: 'Manejar transacciones bancarias de clientes',
        opciones: _opcionesIp),
    Pregunta(texto: 'Trabajar como cajero(a)', opciones: _opcionesIp),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 30,
      etiqueta: 'Ver perfil',
      descripcion: 'Este instrumento se interpreta por el perfil de '
          'intereses RIASEC.',
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
        id: 'realista',
        nombre: 'Realista (R)',
        descripcion: 'Trabajo práctico y manual.',
        indicesPregunta: [0, 1, 2, 3, 4],
        rangos: _bandasEscala),
    SubescalaPuntuacion(
        id: 'investigador',
        nombre: 'Investigador (I)',
        descripcion: 'Analizar e investigar.',
        indicesPregunta: [5, 6, 7, 8, 9],
        rangos: _bandasEscala),
    SubescalaPuntuacion(
        id: 'artistico',
        nombre: 'Artístico (A)',
        descripcion: 'Crear y expresarse.',
        indicesPregunta: [10, 11, 12, 13, 14],
        rangos: _bandasEscala),
    SubescalaPuntuacion(
        id: 'social',
        nombre: 'Social (S)',
        descripcion: 'Ayudar y enseñar.',
        indicesPregunta: [15, 16, 17, 18, 19],
        rangos: _bandasEscala),
    SubescalaPuntuacion(
        id: 'emprendedor',
        nombre: 'Emprendedor (E)',
        descripcion: 'Vender, persuadir y liderar.',
        indicesPregunta: [20, 21, 22, 23, 24],
        rangos: _bandasEscala),
    SubescalaPuntuacion(
        id: 'convencional',
        nombre: 'Convencional (C)',
        descripcion: 'Organizar y sistematizar.',
        indicesPregunta: [25, 26, 27, 28, 29],
        rangos: _bandasEscala),
  ],
  mostrarPuntuacionTotal: false,
  nota: 'El O*NET Interest Profiler se interpreta por perfil: las áreas con '
      'mayor puntuación sugieren los intereses vocacionales dominantes '
      '(modelo RIASEC de Holland). Licencia Creative Commons CC-BY 4.0. '
      'Existe versión en español vía Mi Próximo Paso.',
);

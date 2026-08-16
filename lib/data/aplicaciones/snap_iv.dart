import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del SNAP-IV (frecuencia 0-3).
const List<OpcionRespuesta> _opcionesSnap = [
  OpcionRespuesta(etiqueta: 'Nada', valor: 0),
  OpcionRespuesta(etiqueta: 'Poco', valor: 1),
  OpcionRespuesta(etiqueta: 'Bastante', valor: 2),
  OpcionRespuesta(etiqueta: 'Mucho', valor: 3),
];

/// Bandas de las subescalas de inatención e hiperactividad (0-27).
const List<RangoPuntuacion> _bandasTdah = [
  RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 14,
      etiqueta: 'Bajo',
      descripcion: 'Por debajo del punto de corte (media < 1,67).'),
  RangoPuntuacion(
      nivel: 1,
      minimo: 15,
      maximo: 27,
      etiqueta: 'Sobre el corte',
      descripcion:
          'Puntuación media ≥ 1,67, compatible con sintomatología clínica de TDAH.'),
];

/// Bandas de la subescala de conducta oposicionista (0-24).
const List<RangoPuntuacion> _bandasOposicion = [
  RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 11,
      etiqueta: 'Bajo',
      descripcion: 'Por debajo del punto de corte (media < 1,5).'),
  RangoPuntuacion(
      nivel: 1,
      minimo: 12,
      maximo: 24,
      etiqueta: 'Sobre el corte',
      descripcion:
          'Puntuación media ≥ 1,5, compatible con conducta oposicionista desafiante.'),
];

/// SNAP-IV: Swanson, Nolan y Pelham-IV (versión de cribado de 26 ítems).
///
/// Evalúa síntomas de TDAH (inatención e hiperactividad/impulsividad) y
/// de conducta oposicionista desafiante. Las subescalas se interpretan
/// por su puntuación media (0-3); en la app se muestran las sumas.
const InstrumentoAplicable snapIvAplicable = InstrumentoAplicable(
  id: 'snap-iv',
  sigla: 'SNAP-IV',
  titulo: 'Escala SNAP-IV (versión de cribado)',
  instrucciones: 'Seleccione la opción que mejor describa el comportamiento '
      'del niño(a) durante los últimos 6 meses.',
  preguntas: [
    Pregunta(
        texto:
            'No presta atención a los detalles o comete errores por descuido',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Le cuesta mantener la atención en tareas o juegos',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Parece no escuchar cuando se le habla directamente',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'No sigue las instrucciones y no termina las tareas',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Le cuesta organizar tareas y actividades',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Evita o le disgusta hacer tareas que requieren esfuerzo mental',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Pierde cosas necesarias para las tareas o actividades',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Se distrae fácilmente con estímulos externos',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Es olvidadizo(a) en las actividades diarias',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Mueve en exceso las manos o los pies o se retuerce',
        opciones: _opcionesSnap),
    Pregunta(
        texto:
            'Se levanta del asiento cuando se espera que permanezca sentado(a)',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Corre o trepa en exceso en situaciones inapropiadas',
        opciones: _opcionesSnap),
    Pregunta(
        texto:
            'Tiene dificultad para jugar o participar en actividades tranquilas',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Está en constante movimiento o actúa como si tuviera un motor',
        opciones: _opcionesSnap),
    Pregunta(texto: 'Habla en exceso', opciones: _opcionesSnap),
    Pregunta(
        texto: 'Responde antes de que se complete la pregunta',
        opciones: _opcionesSnap),
    Pregunta(texto: 'Le cuesta esperar su turno', opciones: _opcionesSnap),
    Pregunta(
        texto: 'Interrumpe o se entromete en los asuntos de otros',
        opciones: _opcionesSnap),
    Pregunta(texto: 'Discute con adultos', opciones: _opcionesSnap),
    Pregunta(
        texto:
            'Desafía activamente o se niega a cumplir las peticiones de los adultos',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Molesta a otras personas a propósito', opciones: _opcionesSnap),
    Pregunta(
        texto: 'Culpa a otros por sus errores o mal comportamiento',
        opciones: _opcionesSnap),
    Pregunta(
        texto: 'Es susceptible o se molesta fácilmente',
        opciones: _opcionesSnap),
    Pregunta(texto: 'Es colérico(a) o resentido(a)', opciones: _opcionesSnap),
    Pregunta(texto: 'Es rencoroso(a) o vengativo(a)', opciones: _opcionesSnap),
    Pregunta(texto: 'Es malicioso(a) o cruel', opciones: _opcionesSnap),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 78,
      etiqueta: 'Ver subescalas',
      descripcion: 'Este instrumento se interpreta por subescalas.',
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'inatencion',
      nombre: 'Inatención',
      descripcion: 'Suma de los 9 ítems de inatención (0-27). El punto de '
          'corte clínico es una media ≥ 1,67 (suma ≥ 15).',
      indicesPregunta: [0, 1, 2, 3, 4, 5, 6, 7, 8],
      rangos: _bandasTdah,
    ),
    SubescalaPuntuacion(
      id: 'hiperactividad',
      nombre: 'Hiperactividad/impulsividad',
      descripcion: 'Suma de los 9 ítems de hiperactividad e impulsividad '
          '(0-27). El punto de corte clínico es una media ≥ 1,67 '
          '(suma ≥ 15).',
      indicesPregunta: [9, 10, 11, 12, 13, 14, 15, 16, 17],
      rangos: _bandasTdah,
    ),
    SubescalaPuntuacion(
      id: 'oposicion',
      nombre: 'Conducta oposicionista',
      descripcion: 'Suma de los 8 ítems de conducta oposicionista '
          'desafiante (0-24). El punto de corte clínico es una media '
          '≥ 1,5 (suma ≥ 12).',
      indicesPregunta: [18, 19, 20, 21, 22, 23, 24, 25],
      rangos: _bandasOposicion,
    ),
  ],
  mostrarPuntuacionTotal: false,
  nota: 'El SNAP-IV es una herramienta de cribado, no un diagnóstico. '
      'El punto de corte se aplica a la puntuación media de cada '
      'subescala (0-3). Libre uso clínico.',
);

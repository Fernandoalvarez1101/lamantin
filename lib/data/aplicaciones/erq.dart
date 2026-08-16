import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del ERQ (acuerdo 1-7).
const List<OpcionRespuesta> _opcionesErq = [
  OpcionRespuesta(etiqueta: 'Totalmente en desacuerdo', valor: 1),
  OpcionRespuesta(etiqueta: 'En desacuerdo', valor: 2),
  OpcionRespuesta(etiqueta: 'Ligeramente en desacuerdo', valor: 3),
  OpcionRespuesta(etiqueta: 'Neutro', valor: 4),
  OpcionRespuesta(etiqueta: 'Ligeramente de acuerdo', valor: 5),
  OpcionRespuesta(etiqueta: 'De acuerdo', valor: 6),
  OpcionRespuesta(etiqueta: 'Totalmente de acuerdo', valor: 7),
];

/// Bandas descriptivas de la reevaluación cognitiva (6-42).
const List<RangoPuntuacion> _bandasReevaluacion = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 6,
    maximo: 42,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte normativos publicados.',
    descriptiva: true,
  ),
];

/// Bandas descriptivas de la supresión expresiva (4-28).
const List<RangoPuntuacion> _bandasSupresion = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 4,
    maximo: 28,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte normativos publicados.',
    descriptiva: true,
  ),
];

/// ERQ: Emotion Regulation Questionnaire (Gross y John, 2003).
///
/// Mide dos estrategias de regulación emocional: reevaluación cognitiva
/// (6 ítems) y supresión expresiva (4 ítems).
const InstrumentoAplicable erqAplicable = InstrumentoAplicable(
  id: 'erq',
  sigla: 'ERQ',
  titulo: 'Cuestionario de Regulación Emocional',
  instrucciones: 'Indique su grado de acuerdo con cada afirmación.',
  preguntas: [
    Pregunta(
        texto:
            'Cuando quiero sentir más emociones positivas (como alegría o diversión), cambio lo que estoy pensando',
        opciones: _opcionesErq),
    Pregunta(
        texto: 'Mantengo mis emociones para mí mismo(a)',
        opciones: _opcionesErq),
    Pregunta(
        texto:
            'Cuando quiero sentir menos emociones negativas (como tristeza o enojo), cambio lo que estoy pensando',
        opciones: _opcionesErq),
    Pregunta(
        texto:
            'Cuando estoy sintiendo emociones positivas, tengo cuidado de no expresarlas',
        opciones: _opcionesErq),
    Pregunta(
        texto:
            'Cuando estoy ante una situación estresante, me hago pensar en ella de una manera que me ayuda a mantener la calma',
        opciones: _opcionesErq),
    Pregunta(
        texto: 'Controlo mis emociones al no expresarlas',
        opciones: _opcionesErq),
    Pregunta(
        texto:
            'Cuando quiero sentir más emociones positivas, cambio mi manera de pensar sobre la situación',
        opciones: _opcionesErq),
    Pregunta(
        texto:
            'Cambio mi manera de pensar sobre la situación para influir en lo que siento',
        opciones: _opcionesErq),
    Pregunta(
        texto:
            'Cuando estoy sintiendo emociones negativas, me aseguro de no expresarlas',
        opciones: _opcionesErq),
    Pregunta(
        texto:
            'Cuando quiero sentir menos emociones negativas, cambio mi manera de pensar sobre la situación',
        opciones: _opcionesErq),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 10,
      maximo: 70,
      etiqueta: 'Ver subescalas',
      descripcion: 'Este instrumento se interpreta por subescalas.',
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'reevaluacion',
      nombre: 'Reevaluación cognitiva',
      descripcion: 'Estrategia asociada a mayor bienestar emocional.',
      indicesPregunta: [0, 2, 4, 6, 7, 9],
      rangos: _bandasReevaluacion,
    ),
    SubescalaPuntuacion(
      id: 'supresion',
      nombre: 'Supresión expresiva',
      descripcion: 'Estrategia asociada a mayor malestar si es el estilo '
          'predominante.',
      indicesPregunta: [1, 3, 5, 8],
      rangos: _bandasSupresion,
    ),
  ],
  mostrarPuntuacionTotal: false,
  nota: 'El ERQ es una medida descriptiva de estrategias de regulación '
      'emocional, sin puntos de corte clínicos. Las bandas mostradas son '
      'referenciales. Libre uso en investigación (cita del autor).',
);

import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del GBJWS (acuerdo 1-6).
const List<OpcionRespuesta> _opcionesGbjws = [
  OpcionRespuesta(etiqueta: 'Totalmente en desacuerdo', valor: 1),
  OpcionRespuesta(etiqueta: 'En desacuerdo', valor: 2),
  OpcionRespuesta(etiqueta: 'Ligeramente en desacuerdo', valor: 3),
  OpcionRespuesta(etiqueta: 'Ligeramente de acuerdo', valor: 4),
  OpcionRespuesta(etiqueta: 'De acuerdo', valor: 5),
  OpcionRespuesta(etiqueta: 'Totalmente de acuerdo', valor: 6),
];

/// GBJWS: Escala de Creencia Global en un Mundo Justo (Lipkus, 1991).
///
/// Mide la creencia de que el mundo es un lugar justo donde las personas
/// reciben lo que merecen. Rango de 7 a 42; a mayor puntuación, mayor
/// creencia en un mundo justo.
const InstrumentoAplicable gbjwsAplicable = InstrumentoAplicable(
  id: 'gbjws',
  sigla: 'GBJWS',
  titulo: 'Escala de Creencia Global en un Mundo Justo',
  instrucciones: 'Indique su grado de acuerdo con cada afirmación.',
  preguntas: [
    Pregunta(
      texto: 'Siento que el mundo es básicamente justo',
      opciones: _opcionesGbjws,
    ),
    Pregunta(
      texto: 'Siento que las personas obtienen lo que merecen tener',
      opciones: _opcionesGbjws,
    ),
    Pregunta(
      texto: 'Siento que el esfuerzo de una persona es reconocido y '
          'recompensado',
      opciones: _opcionesGbjws,
    ),
    Pregunta(
      texto: 'Siento que las personas se ganan las recompensas y los castigos '
          'que reciben',
      opciones: _opcionesGbjws,
    ),
    Pregunta(
      texto: 'Siento que las personas que sufren desgracias se lo han buscado '
          'ellas mismas',
      opciones: _opcionesGbjws,
    ),
    Pregunta(
      texto: 'Siento que las recompensas y los castigos se dan de forma justa',
      opciones: _opcionesGbjws,
    ),
    Pregunta(
      texto: 'Básicamente siento que el mundo es un lugar justo',
      opciones: _opcionesGbjws,
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 7,
      maximo: 42,
      etiqueta: 'Descriptivo',
      descripcion: 'Sin puntos de corte normativos publicados.',
      descriptiva: true,
    ),
  ],
  nota: 'El GBJWS es una medida descriptiva de la creencia en un mundo '
      'justo; no tiene puntos de corte clínicos, así que se interpreta por '
      'comparación con normas locales. Una puntuación alta puede funcionar '
      'como factor protector (confianza, planificación a largo plazo) o como '
      'distorsión que culpabiliza a quien sufre. Uso en investigación con '
      'cita de Lipkus (1991).',
);

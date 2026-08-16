import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// SBQ-R: Suicidal Behaviors Questionnaire-Revised (Osman et al., 2001).
///
/// Evalúa la historia de pensamientos e intentos suicidas y el riesgo
/// actual. Puntuación total de 3 a 18; el punto de corte es ≥ 7
/// (población general) u ≥ 8 (población clínica).
const InstrumentoAplicable sbqRAplicable = InstrumentoAplicable(
  id: 'sbq-r',
  sigla: 'SBQ-R',
  titulo: 'Cuestionario de Conductas Suicidas-Revisado',
  instrucciones: 'Responda las siguientes preguntas sobre pensamientos y '
      'conductas suicidas.',
  preguntas: [
    Pregunta(
      texto: '¿Alguna vez ha pensado o intentado suicidarse?',
      opciones: [
        OpcionRespuesta(etiqueta: 'Nunca', valor: 1),
        OpcionRespuesta(etiqueta: 'Fue solo un pensamiento pasajero', valor: 2),
        OpcionRespuesta(
            etiqueta: 'He tenido pensamientos al menos una vez', valor: 3),
        OpcionRespuesta(
            etiqueta:
                'He tenido pensamientos de suicidio o he intentado suicidarme',
            valor: 4),
      ],
    ),
    Pregunta(
      texto: '¿Con qué frecuencia ha tenido pensamientos de suicidio en los '
          'últimos 12 meses?',
      opciones: [
        OpcionRespuesta(etiqueta: 'Nunca', valor: 1),
        OpcionRespuesta(etiqueta: 'Rara vez (1 vez)', valor: 2),
        OpcionRespuesta(etiqueta: 'A veces (2 veces)', valor: 3),
        OpcionRespuesta(etiqueta: 'A menudo (3-4 veces)', valor: 4),
        OpcionRespuesta(etiqueta: 'Muy a menudo (5 o más veces)', valor: 5),
      ],
    ),
    Pregunta(
      texto: '¿Alguna vez le ha dicho a alguien que pensaba suicidarse o que '
          'podría hacerlo?',
      opciones: [
        OpcionRespuesta(etiqueta: 'No', valor: 1),
        OpcionRespuesta(etiqueta: 'Sí, una vez', valor: 2),
        OpcionRespuesta(etiqueta: 'Sí, más de una vez', valor: 3),
      ],
    ),
    Pregunta(
      texto: '¿Qué tan probable es que intente suicidarse algún día?',
      opciones: [
        OpcionRespuesta(etiqueta: 'Nunca', valor: 0),
        OpcionRespuesta(etiqueta: 'Ninguna posibilidad', valor: 1),
        OpcionRespuesta(etiqueta: 'Bastante improbable', valor: 2),
        OpcionRespuesta(etiqueta: 'Improbable', valor: 3),
        OpcionRespuesta(etiqueta: 'Probable', valor: 4),
        OpcionRespuesta(etiqueta: 'Bastante probable', valor: 5),
        OpcionRespuesta(etiqueta: 'Muy probable', valor: 6),
      ],
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 3,
      maximo: 6,
      etiqueta: 'Bajo',
      descripcion: 'Riesgo bajo según el punto de corte (≥ 7).',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 7,
      maximo: 18,
      etiqueta: 'Riesgo presente',
      descripcion: 'Puntuación igual o superior al punto de corte. Se '
          'recomienda una evaluación clínica del riesgo de suicidio.',
    ),
  ],
  alertas: [
    AlertaPregunta(
      numeroPregunta: 1,
      valorMinimo: 3,
      mensaje: 'Se reporta historia de pensamientos o intentos suicidas. '
          'Valorar el riesgo en la entrevista clínica.',
    ),
    AlertaPregunta(
      numeroPregunta: 4,
      valorMinimo: 4,
      mensaje: 'La probabilidad percibida de intentar suicidarse es alta. '
          'Considere intervención de crisis.',
    ),
  ],
  nota: 'El SBQ-R es una herramienta de cribado, no un diagnóstico. '
      'Puntos de corte: ≥ 7 en población general y ≥ 8 en población '
      'clínica.',
);

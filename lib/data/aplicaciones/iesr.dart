import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del IES-R (afectación 0-4).
const List<OpcionRespuesta> _opcionesIesr = [
  OpcionRespuesta(etiqueta: 'Nada', valor: 0),
  OpcionRespuesta(etiqueta: 'Un poco', valor: 1),
  OpcionRespuesta(etiqueta: 'Moderadamente', valor: 2),
  OpcionRespuesta(etiqueta: 'Bastante', valor: 3),
  OpcionRespuesta(etiqueta: 'Extremadamente', valor: 4),
];

/// IES-R: Escala de Impacto del Evento-Revisada (Weiss y Marmar, 1997).
///
/// Mide la respuesta subjetiva a un evento traumático en tres dimensiones:
/// intrusión, evitación e hiperactivación.
const InstrumentoAplicable iesrAplicable = InstrumentoAplicable(
  id: 'ies-r',
  sigla: 'IES-R',
  titulo: 'Escala de Impacto del Evento-Revisada',
  instrucciones: 'Las siguientes afirmaciones se refieren a cómo se ha '
      'sentido durante los últimos 7 días en relación con el evento '
      'estresante. Indique cuánto le ha afectado cada una.',
  preguntas: [
    Pregunta(
        texto:
            'Cualquier cosa que me lo recordaba me provocaba sentimientos relacionados con lo ocurrido',
        opciones: _opcionesIesr),
    Pregunta(
        texto: 'Tenía dificultad para conciliar el sueño o para mantenerlo',
        opciones: _opcionesIesr),
    Pregunta(
        texto: 'Otras cosas me hacían pensar en lo ocurrido',
        opciones: _opcionesIesr),
    Pregunta(
        texto: 'Me sentía irritado(a) o enfadado(a)', opciones: _opcionesIesr),
    Pregunta(
        texto: 'Evitaba dejarme alterar cuando pensaba en ello o lo recordaba',
        opciones: _opcionesIesr),
    Pregunta(
        texto: 'Pensaba en ello aunque no quería', opciones: _opcionesIesr),
    Pregunta(
        texto:
            'Tenía la sensación de que no había ocurrido o de que no era real',
        opciones: _opcionesIesr),
    Pregunta(
        texto: 'Me mantenía alejado(a) de las cosas que me lo recordaban',
        opciones: _opcionesIesr),
    Pregunta(
        texto: 'Imágenes de lo ocurrido irrumpían en mi mente',
        opciones: _opcionesIesr),
    Pregunta(
        texto: 'Estaba sobresaltado(a) y me asustaba con facilidad',
        opciones: _opcionesIesr),
    Pregunta(texto: 'Intentaba no pensar en ello', opciones: _opcionesIesr),
    Pregunta(
        texto:
            'Era consciente de que me quedaban muchas emociones sin resolver, pero no hacía nada al respecto',
        opciones: _opcionesIesr),
    Pregunta(
        texto: 'Mis sentimientos sobre ello estaban como adormecidos',
        opciones: _opcionesIesr),
    Pregunta(
        texto:
            'Me daba cuenta de que actuaba o me sentía como si estuviera de nuevo en aquella situación',
        opciones: _opcionesIesr),
    Pregunta(
        texto: 'Tenía dificultad para conciliar el sueño',
        opciones: _opcionesIesr),
    Pregunta(
        texto:
            'Me invadían oleadas de sentimientos fuertes relacionadas con lo ocurrido',
        opciones: _opcionesIesr),
    Pregunta(texto: 'Intentaba sacarlo de mi memoria', opciones: _opcionesIesr),
    Pregunta(
        texto: 'Tenía dificultad para concentrarme', opciones: _opcionesIesr),
    Pregunta(
        texto:
            'Los recuerdos me producían reacciones físicas (sudoración, palpitaciones, dificultad para respirar)',
        opciones: _opcionesIesr),
    Pregunta(texto: 'Soñaba con ello', opciones: _opcionesIesr),
    Pregunta(texto: 'Me sentía alerta o en guardia', opciones: _opcionesIesr),
    Pregunta(texto: 'Intentaba no hablar de ello', opciones: _opcionesIesr),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 23,
      etiqueta: 'Bajo',
      descripcion: 'Respuesta al evento dentro de lo esperable.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 24,
      maximo: 32,
      etiqueta: 'Moderado',
      descripcion: 'Respuesta clínicamente significativa. Se recomienda '
          'evaluación clínica.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 33,
      maximo: 88,
      etiqueta: 'Alto',
      descripcion: 'Probable TEPT. La puntuación ≥ 33 es el punto de corte '
          'habitual; se recomienda evaluación clínica estructurada.',
    ),
  ],
  nota: 'El IES-R es una herramienta de cribado, no un diagnóstico. '
      'La puntuación va de 0 a 88. Evalúa la respuesta al evento durante '
      'los últimos 7 días.',
);

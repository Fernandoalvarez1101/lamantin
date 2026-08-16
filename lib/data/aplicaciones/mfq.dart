import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del MFQ (frecuencia 0-2).
const List<OpcionRespuesta> _opcionesMfq = [
  OpcionRespuesta(etiqueta: 'No es cierto', valor: 0),
  OpcionRespuesta(etiqueta: 'A veces', valor: 1),
  OpcionRespuesta(etiqueta: 'Cierto', valor: 2),
];

/// MFQ: Mood and Feelings Questionnaire, versión corta
/// (Angold y Costello, 1987).
///
/// Evalúa síntomas depresivos en niños y adolescentes durante las últimas
/// 2 semanas.
const InstrumentoAplicable mfqAplicable = InstrumentoAplicable(
  id: 'mfq',
  sigla: 'MFQ',
  titulo: 'Cuestionario de Estado de Ánimo y Sentimientos (versión corta)',
  instrucciones: 'Durante las últimas 2 semanas, ¿qué tan cierto ha sido '
      'para ti cada enunciado?',
  preguntas: [
    Pregunta(texto: 'Me sentí desgraciado(a) o triste', opciones: _opcionesMfq),
    Pregunta(texto: 'No disfruté nada en absoluto', opciones: _opcionesMfq),
    Pregunta(
        texto: 'Me sentí tan cansado(a) que no hacía nada',
        opciones: _opcionesMfq),
    Pregunta(texto: 'Estaba muy inquieto(a)', opciones: _opcionesMfq),
    Pregunta(texto: 'Sentí que ya no era bueno(a)', opciones: _opcionesMfq),
    Pregunta(texto: 'Lloré mucho', opciones: _opcionesMfq),
    Pregunta(
        texto: 'Me costó pensar con claridad o concentrarme',
        opciones: _opcionesMfq),
    Pregunta(texto: 'Me odié a mí mismo(a)', opciones: _opcionesMfq),
    Pregunta(texto: 'Sentí que era una mala persona', opciones: _opcionesMfq),
    Pregunta(texto: 'Me sentí solo(a)', opciones: _opcionesMfq),
    Pregunta(
        texto: 'Pensé que nadie me quería de verdad', opciones: _opcionesMfq),
    Pregunta(
        texto: 'Pensé que nunca podría ser tan bueno(a) como otros niños/as',
        opciones: _opcionesMfq),
    Pregunta(texto: 'Sentí que hacía todo mal', opciones: _opcionesMfq),
  ],
  rangos: [
    RangoPuntuacion(
        nivel: 0,
        minimo: 0,
        maximo: 7,
        etiqueta: 'Bajo',
        descripcion: 'Sin indicadores clínicamente significativos.'),
    RangoPuntuacion(
        nivel: 1,
        minimo: 8,
        maximo: 12,
        etiqueta: 'Posible',
        descripcion:
            'Posible depresión. El punto de corte habitual del autoinforme es ≥ 8.'),
    RangoPuntuacion(
        nivel: 2,
        minimo: 13,
        maximo: 26,
        etiqueta: 'Probable',
        descripcion: 'Probable depresión. Se recomienda evaluación clínica.'),
  ],
  nota: 'El MFQ es una herramienta de cribado, no un diagnóstico. '
      'Los puntos de corte difieren por informante: autoinforme ≥ 8 y '
      'reporte de padres ≥ 12.',
);

import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta de la Zung SDS (frecuencia 1-4).
const List<OpcionRespuesta> _opcionesZung = [
  OpcionRespuesta(etiqueta: 'Rara vez o nunca', valor: 1),
  OpcionRespuesta(etiqueta: 'Algunas veces', valor: 2),
  OpcionRespuesta(etiqueta: 'Con bastante frecuencia', valor: 3),
  OpcionRespuesta(etiqueta: 'Casi siempre o siempre', valor: 4),
];

/// Zung SDS: Escala de Autoevaluación de la Depresión de Zung (1965).
///
/// Evalúa la frecuencia de síntomas depresivos. Los ítems formulados en
/// positivo (2, 5, 6, 11, 12, 14, 16, 17, 18 y 20) se puntúan invertidos.
const InstrumentoAplicable zungSdsAplicable = InstrumentoAplicable(
  id: 'zung-sds',
  sigla: 'Zung SDS',
  titulo: 'Escala de Autoevaluación de la Depresión de Zung',
  instrucciones: 'Indique con qué frecuencia se ha sentido de la siguiente '
      'manera durante los últimos días.',
  preguntas: [
    Pregunta(texto: 'Me siento triste y deprimido(a)', opciones: _opcionesZung),
    Pregunta(
        texto: 'Por las mañanas me siento mejor',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Tengo crisis de llanto o ganas de llorar',
        opciones: _opcionesZung),
    Pregunta(texto: 'Duermo mal por las noches', opciones: _opcionesZung),
    Pregunta(
        texto: 'Como igual que antes',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Todavía disfruto de las relaciones sexuales',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(texto: 'Noto que estoy perdiendo peso', opciones: _opcionesZung),
    Pregunta(texto: 'Sufro de estreñimiento', opciones: _opcionesZung),
    Pregunta(
        texto: 'Mi corazón late más rápido de lo normal',
        opciones: _opcionesZung),
    Pregunta(texto: 'Me canso sin motivo', opciones: _opcionesZung),
    Pregunta(
        texto: 'Tengo la mente tan despejada como antes',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Me es fácil hacer las cosas que hacía antes',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Estoy inquieto(a) y no puedo quedarme quieto(a)',
        opciones: _opcionesZung),
    Pregunta(
        texto: 'Tengo esperanza en el futuro',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Estoy más irritable de lo habitual', opciones: _opcionesZung),
    Pregunta(
        texto: 'Me es fácil tomar decisiones',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Siento que soy útil y que me necesitan',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Mi vida es bastante plena',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Siento que los demás estarían mejor si yo muriera',
        opciones: _opcionesZung),
    Pregunta(
        texto: 'Todavía disfruto de las cosas que solía disfrutar',
        opciones: _opcionesZung,
        invertida: true),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 20,
      maximo: 44,
      etiqueta: 'Normal',
      descripcion: 'Dentro del rango normal.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 45,
      maximo: 59,
      etiqueta: 'Leve',
      descripcion: 'Depresión leve.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 60,
      maximo: 69,
      etiqueta: 'Moderada',
      descripcion: 'Depresión moderada.',
    ),
    RangoPuntuacion(
      nivel: 3,
      minimo: 70,
      maximo: 80,
      etiqueta: 'Grave',
      descripcion: 'Depresión grave.',
    ),
  ],
  alertas: [
    AlertaPregunta(
      numeroPregunta: 19,
      valorMinimo: 2,
      mensaje: 'Se registró una respuesta positiva en el ítem 19 '
          '("siento que los demás estarían mejor si yo muriera"). Realice '
          'una evaluación inmediata del riesgo de suicidio.',
    ),
  ],
  nota: 'La Zung SDS es una herramienta de cribado, no un diagnóstico. '
      'La puntuación va de 20 a 80. Las bandas (20-44 normal, 45-59 leve, '
      '60-69 moderada, 70-80 grave) siguen el índice publicado por el '
      'autor: Zung, W. W. K. (1965). A self-rating depression scale. '
      'Archives of General Psychiatry, 12, 63-70. Los ítems 2, 5, 6, 11, '
      '12, 14, 16, 17, 18 y 20 se puntúan de forma invertida.',
);

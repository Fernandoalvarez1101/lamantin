import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta de la Zung SAS (frecuencia 1-4).
const List<OpcionRespuesta> _opcionesZung = [
  OpcionRespuesta(etiqueta: 'Rara vez o nunca', valor: 1),
  OpcionRespuesta(etiqueta: 'Algunas veces', valor: 2),
  OpcionRespuesta(etiqueta: 'Con bastante frecuencia', valor: 3),
  OpcionRespuesta(etiqueta: 'Casi siempre o siempre', valor: 4),
];

/// Zung SAS: Escala de Autoevaluación de la Ansiedad de Zung (1971).
///
/// Evalúa la frecuencia de síntomas de ansiedad. Los ítems formulados en
/// positivo (5, 9, 13, 17 y 19) se puntúan de forma invertida.
const InstrumentoAplicable zungSasAplicable = InstrumentoAplicable(
  id: 'zung-sas',
  sigla: 'Zung SAS',
  titulo: 'Escala de Autoevaluación de la Ansiedad de Zung',
  instrucciones: 'Indique con qué frecuencia se ha sentido de la siguiente '
      'manera durante los últimos días.',
  preguntas: [
    Pregunta(
        texto: 'Me siento más nervioso(a) y ansioso(a) que de costumbre',
        opciones: _opcionesZung),
    Pregunta(texto: 'Siento miedo sin razón', opciones: _opcionesZung),
    Pregunta(
        texto: 'Me altero o me siento asustado(a) con facilidad',
        opciones: _opcionesZung),
    Pregunta(
        texto: 'Siento que me estoy despedazando y que voy a pedazos',
        opciones: _opcionesZung),
    Pregunta(
        texto: 'Me siento bien y siento que todo está bien',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Me tiemblan los brazos y las piernas', opciones: _opcionesZung),
    Pregunta(
        texto: 'Me molestan dolores de cabeza, cuello y espalda',
        opciones: _opcionesZung),
    Pregunta(
        texto: 'Me siento débil y me canso fácilmente',
        opciones: _opcionesZung),
    Pregunta(
        texto:
            'Me siento tranquilo(a) y puedo permanecer sentado(a) con facilidad',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Siento que mi corazón late rápido', opciones: _opcionesZung),
    Pregunta(texto: 'Siento mareos', opciones: _opcionesZung),
    Pregunta(
        texto: 'Me desmayo o siento que voy a desmayarme',
        opciones: _opcionesZung),
    Pregunta(
        texto: 'Puedo respirar fácilmente',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto:
            'Se me adormecen o me hormiguean los dedos de las manos y los pies',
        opciones: _opcionesZung),
    Pregunta(
        texto: 'Sufro dolores de estómago o indigestión',
        opciones: _opcionesZung),
    Pregunta(
        texto: 'Orino con más frecuencia de lo normal',
        opciones: _opcionesZung),
    Pregunta(
        texto: 'Por lo general, mis manos están secas y calientes',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(
        texto: 'Siento bochornos o calor en la cara', opciones: _opcionesZung),
    Pregunta(
        texto: 'Me duermo fácilmente y descanso bien por la noche',
        opciones: _opcionesZung,
        invertida: true),
    Pregunta(texto: 'Tengo pesadillas', opciones: _opcionesZung),
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
      etiqueta: 'Leve a moderada',
      descripcion: 'Ansiedad leve a moderada.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 60,
      maximo: 74,
      etiqueta: 'Marcada a severa',
      descripcion: 'Ansiedad marcada a severa.',
    ),
    RangoPuntuacion(
      nivel: 3,
      minimo: 75,
      maximo: 80,
      etiqueta: 'Extrema',
      descripcion: 'Ansiedad extrema. Requiere valoración clínica inmediata.',
    ),
  ],
  nota: 'La Zung SAS es una herramienta de cribado, no un diagnóstico. '
      'La puntuación va de 20 a 80. Los ítems 5, 9, 13, 17 y 19 se '
      'puntúan de forma invertida.',
);

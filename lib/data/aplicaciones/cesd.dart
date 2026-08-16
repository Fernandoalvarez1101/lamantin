import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta de la CES-D (frecuencia en la última semana).
const List<OpcionRespuesta> _opcionesCesd = [
  OpcionRespuesta(etiqueta: 'Rara vez o nunca (menos de 1 día)', valor: 0),
  OpcionRespuesta(etiqueta: 'Alguna vez (1-2 días)', valor: 1),
  OpcionRespuesta(etiqueta: 'Frecuentemente (3-4 días)', valor: 2),
  OpcionRespuesta(
    etiqueta: 'La mayor parte del tiempo (5-7 días)',
    valor: 3,
  ),
];

/// CES-D: Center for Epidemiologic Studies Depression Scale (Radloff, 1977).
///
/// Cribado de síntomas depresivos durante la última semana. Los ítems
/// formulados en positivo (4, 8, 12 y 16) se puntúan de forma invertida.
const InstrumentoAplicable cesdAplicable = InstrumentoAplicable(
  id: 'ces-d',
  sigla: 'CES-D',
  titulo: 'Escala de Depresión del Centro de Estudios Epidemiológicos',
  instrucciones: 'Durante la última semana, indique con qué frecuencia ha '
      'sentido o le han ocurrido las siguientes situaciones.',
  preguntas: [
    Pregunta(
        texto: 'Me molestaron cosas que usualmente no me molestan',
        opciones: _opcionesCesd),
    Pregunta(
        texto: 'No tenía ganas de comer; tenía mal apetito',
        opciones: _opcionesCesd),
    Pregunta(
        texto:
            'Sentía que no podía quitarme la tristeza, aun con la ayuda de mi familia o amigos',
        opciones: _opcionesCesd),
    Pregunta(
        texto: 'Sentía que yo era tan bueno(a) como cualquier otra persona',
        opciones: _opcionesCesd,
        invertida: true),
    Pregunta(
        texto: 'Tenía dificultad para concentrarme en lo que hacía',
        opciones: _opcionesCesd),
    Pregunta(texto: 'Me sentía deprimido(a)', opciones: _opcionesCesd),
    Pregunta(
        texto: 'Sentía que todo lo que hacía era un esfuerzo',
        opciones: _opcionesCesd),
    Pregunta(
        texto: 'Me sentía esperanzado(a) sobre el futuro',
        opciones: _opcionesCesd,
        invertida: true),
    Pregunta(
        texto: 'Pensé que mi vida había sido un fracaso',
        opciones: _opcionesCesd),
    Pregunta(texto: 'Me sentía con miedo', opciones: _opcionesCesd),
    Pregunta(texto: 'Mi sueño era inquieto', opciones: _opcionesCesd),
    Pregunta(
        texto: 'Me sentía feliz', opciones: _opcionesCesd, invertida: true),
    Pregunta(texto: 'Hablaba menos de lo usual', opciones: _opcionesCesd),
    Pregunta(texto: 'Me sentía solo(a)', opciones: _opcionesCesd),
    Pregunta(texto: 'Las personas no me eran amables', opciones: _opcionesCesd),
    Pregunta(
        texto: 'Disfruté de la vida', opciones: _opcionesCesd, invertida: true),
    Pregunta(texto: 'Tuve crisis de llanto', opciones: _opcionesCesd),
    Pregunta(texto: 'Me sentía triste', opciones: _opcionesCesd),
    Pregunta(
        texto: 'Sentía que no le caía bien a la gente',
        opciones: _opcionesCesd),
    Pregunta(texto: 'No tenía ánimo', opciones: _opcionesCesd),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 15,
      etiqueta: 'Bajo',
      descripcion: 'Por debajo del punto de corte clínico.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 16,
      maximo: 60,
      etiqueta: 'Síntomas clínicamente significativos',
      descripcion: 'Puntuación ≥ 16: síntomas depresivos clínicamente '
          'significativos. Se recomienda evaluación clínica.',
    ),
  ],
  nota: 'La CES-D es una herramienta de cribado, no un diagnóstico. '
      'El punto de corte publicado es ≥ 16 (Radloff, L. S. (1977). The '
      'CES-D Scale. Applied Psychological Measurement, 1(3), 385-401). '
      'Los ítems 4, 8, 12 y 16 se puntúan de forma invertida.',
);

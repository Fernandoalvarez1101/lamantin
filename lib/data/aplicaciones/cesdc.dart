import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta de la CES-DC (frecuencia en la última semana).
const List<OpcionRespuesta> _opcionesCesdc = [
  OpcionRespuesta(etiqueta: 'Nada', valor: 0),
  OpcionRespuesta(etiqueta: 'Un poco', valor: 1),
  OpcionRespuesta(etiqueta: 'Algunas veces', valor: 2),
  OpcionRespuesta(etiqueta: 'Muchas veces', valor: 3),
];

/// CES-DC: Center for Epidemiologic Studies Depression Scale for Children
/// (Weissman et al., 1980).
///
/// Adaptación de la CES-D para niños y adolescentes. Los ítems 4, 8, 12 y
/// 16 se puntúan de forma invertida.
const InstrumentoAplicable cesdcAplicable = InstrumentoAplicable(
  id: 'ces-dc',
  sigla: 'CES-DC',
  titulo: 'Escala de Depresión del Centro de Estudios Epidemiológicos '
      '(para niños)',
  instrucciones: 'Durante la última semana, indica con qué frecuencia has '
      'sentido o te han ocurrido las siguientes situaciones.',
  preguntas: [
    Pregunta(
        texto: 'Me molestaron cosas que usualmente no me molestan',
        opciones: _opcionesCesdc),
    Pregunta(
        texto: 'No tenía ganas de comer; tenía mal apetito',
        opciones: _opcionesCesdc),
    Pregunta(
        texto:
            'Sentía que no podía quitarme la tristeza, aun con la ayuda de mi familia o amigos',
        opciones: _opcionesCesdc),
    Pregunta(
        texto: 'Sentía que yo era tan bueno(a) como cualquier otra persona',
        opciones: _opcionesCesdc,
        invertida: true),
    Pregunta(
        texto: 'Tenía dificultad para concentrarme en lo que hacía',
        opciones: _opcionesCesdc),
    Pregunta(texto: 'Me sentía deprimido(a)', opciones: _opcionesCesdc),
    Pregunta(
        texto: 'Sentía que todo lo que hacía era un esfuerzo',
        opciones: _opcionesCesdc),
    Pregunta(
        texto: 'Me sentía esperanzado(a) sobre el futuro',
        opciones: _opcionesCesdc,
        invertida: true),
    Pregunta(
        texto: 'Pensé que mi vida había sido un fracaso',
        opciones: _opcionesCesdc),
    Pregunta(texto: 'Me sentía con miedo', opciones: _opcionesCesdc),
    Pregunta(texto: 'Mi sueño era inquieto', opciones: _opcionesCesdc),
    Pregunta(
        texto: 'Me sentía feliz', opciones: _opcionesCesdc, invertida: true),
    Pregunta(texto: 'Hablaba menos de lo usual', opciones: _opcionesCesdc),
    Pregunta(texto: 'Me sentía solo(a)', opciones: _opcionesCesdc),
    Pregunta(
        texto: 'Las personas no me eran amables', opciones: _opcionesCesdc),
    Pregunta(
        texto: 'Disfruté de la vida',
        opciones: _opcionesCesdc,
        invertida: true),
    Pregunta(texto: 'Tuve crisis de llanto', opciones: _opcionesCesdc),
    Pregunta(texto: 'Me sentía triste', opciones: _opcionesCesdc),
    Pregunta(
        texto: 'Sentía que no le caía bien a la gente',
        opciones: _opcionesCesdc),
    Pregunta(texto: 'No tenía ánimo', opciones: _opcionesCesdc),
  ],
  rangos: [
    RangoPuntuacion(
        nivel: 0,
        minimo: 0,
        maximo: 14,
        etiqueta: 'Sin síntomas',
        descripcion: 'Por debajo del punto de corte clínico.'),
    RangoPuntuacion(
        nivel: 1,
        minimo: 15,
        maximo: 60,
        etiqueta: 'Síntomas clínicamente significativos',
        descripcion:
            'Puntuación ≥ 15: síntomas depresivos clínicamente significativos. Se recomienda evaluación clínica.'),
  ],
  alertas: [],
  nota: 'La CES-DC es una herramienta de cribado, no un diagnóstico. '
      'El punto de corte habitual es ≥ 15 (Weissman et al., 1980). '
      'Los ítems 4, 8, 12 y 16 se puntúan de forma invertida.',
);

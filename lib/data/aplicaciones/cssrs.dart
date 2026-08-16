import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del cribado C-SSRS (sí/no).
const List<OpcionRespuesta> _opcionesSiNo = [
  OpcionRespuesta(etiqueta: 'No', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí', valor: 1),
];

/// C-SSRS: Columbia-Suicide Severity Rating Scale (Posner et al., 2011).
///
/// Cribado de ideación y conducta suicida del Protocolo de Columbia.
/// Cualquier respuesta positiva requiere una evaluación clínica
/// inmediata del riesgo.
const InstrumentoAplicable cSsrsAplicable = InstrumentoAplicable(
  id: 'c-ssrs',
  sigla: 'C-SSRS',
  titulo: 'Escala de Severidad del Suicidio de Columbia',
  instrucciones: 'Realice las siguientes preguntas sobre pensamientos y '
      'conductas relacionadas con el suicidio.',
  preguntas: [
    Pregunta(
        texto:
            '¿Ha deseado estar muerto(a) o deseado poder dormirse y no despertar?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Ha tenido pensamientos reales y activos de quitarse la vida?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Ha pensado en cómo podría suicidarse?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Ha tenido la intención de actuar sobre estos pensamientos?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto:
            '¿Ha empezado a hacer algo para prepararse para suicidarse (p. ej., juntar pastillas, conseguir un arma, escribir una nota)?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Ha hecho algún intento de suicidio?', opciones: _opcionesSiNo),
  ],
  rangos: [
    RangoPuntuacion(
        nivel: 0,
        minimo: 0,
        maximo: 0,
        etiqueta: 'Sin riesgo reportado',
        descripcion: 'No se reportan pensamientos ni conductas suicidas.'),
    RangoPuntuacion(
        nivel: 1,
        minimo: 1,
        maximo: 2,
        etiqueta: 'Riesgo presente',
        descripcion:
            'Presencia de ideación suicida. Evaluar la intensidad, frecuencia y el plan.'),
    RangoPuntuacion(
        nivel: 2,
        minimo: 3,
        maximo: 6,
        etiqueta: 'Riesgo alto',
        descripcion:
            'Múltiples indicadores de riesgo. Intervención clínica inmediata.'),
  ],
  alertas: [
    AlertaPregunta(
        numeroPregunta: 1,
        valorMinimo: 1,
        mensaje:
            'Se reportó deseo de estar muerto(a). Valorar el riesgo de suicidio.'),
    AlertaPregunta(
        numeroPregunta: 2,
        valorMinimo: 1,
        mensaje:
            'Se reportaron pensamientos activos de quitarse la vida. Valorar intensidad, frecuencia y plan.'),
    AlertaPregunta(
        numeroPregunta: 3,
        valorMinimo: 1,
        mensaje: 'Se reportó un método o plan de suicidio. Riesgo elevado.'),
    AlertaPregunta(
        numeroPregunta: 4,
        valorMinimo: 1,
        mensaje:
            'Se reportó intención de actuar. Riesgo elevado: considere intervención de crisis.'),
    AlertaPregunta(
        numeroPregunta: 5,
        valorMinimo: 1,
        mensaje:
            'Se reportó conducta preparatoria para el suicidio. Intervención inmediata.'),
    AlertaPregunta(
        numeroPregunta: 6,
        valorMinimo: 1,
        mensaje:
            'Se reportó un intento de suicidio. Asegure la seguridad y valore hospitalización.'),
  ],
  nota: 'Adaptación del cribado del Protocolo de Columbia. El instrumento '
      'completo es una entrevista estructurada que requiere registro y '
      'entrenamiento en cssrs.columbia.edu. Ante cualquier respuesta '
      'positiva, active el protocolo de riesgo de su institución.',
);

import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del BAI (malestar 0-3).
const List<OpcionRespuesta> _opcionesBai = [
  OpcionRespuesta(etiqueta: 'En absoluto', valor: 0),
  OpcionRespuesta(etiqueta: 'Levemente', valor: 1),
  OpcionRespuesta(
    etiqueta: 'Moderadamente (es desagradable, pero puedo soportarlo)',
    valor: 2,
  ),
  OpcionRespuesta(
    etiqueta: 'Gravemente (casi no puedo soportarlo)',
    valor: 3,
  ),
];

/// BAI: Inventario de Ansiedad de Beck (Beck, Epstein, Brown y Steer, 1988).
///
/// Mide la gravedad de los síntomas de ansiedad (somáticos, cognitivos y
/// emocionales) durante la última semana. Rango de 0 a 63; a mayor
/// puntuación, mayor gravedad.
const InstrumentoAplicable baiAplicable = InstrumentoAplicable(
  id: 'bai',
  sigla: 'BAI',
  titulo: 'Inventario de Ansiedad de Beck',
  instrucciones: 'Indique cuánto le ha molestado cada síntoma durante la '
      'última semana, incluido el día de hoy.',
  preguntas: [
    Pregunta(texto: 'Entumecimiento u hormigueo', opciones: _opcionesBai),
    Pregunta(texto: 'Sensación de calor', opciones: _opcionesBai),
    Pregunta(
      texto: 'Temblor en las piernas',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Incapacidad para relajarse',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Miedo a que ocurra lo peor',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Mareo o aturdimiento',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Palpitaciones o aceleración del corazón',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Sensación de inestabilidad',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Estar aterrorizado(a)',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Nerviosismo',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Sensación de atragantamiento',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Manos temblorosas',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Cuerpo tembloroso o agitado',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Miedo a perder el control',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Dificultad para respirar',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Miedo a morir',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Sentirse asustado(a)',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Indigestión o molestias abdominales',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Sensación de desmayo',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Rubor facial (sofocos)',
      opciones: _opcionesBai,
    ),
    Pregunta(
      texto: 'Sudoración (no debida al calor)',
      opciones: _opcionesBai,
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 7,
      etiqueta: 'Mínima',
      descripcion: 'Ansiedad mínima o ausente.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 8,
      maximo: 15,
      etiqueta: 'Leve',
      descripcion: 'Ansiedad leve.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 16,
      maximo: 25,
      etiqueta: 'Moderada',
      descripcion: 'Ansiedad moderada. Se recomienda una evaluación clínica '
          'más detallada del perfil de síntomas.',
    ),
    RangoPuntuacion(
      nivel: 3,
      minimo: 26,
      maximo: 63,
      etiqueta: 'Grave',
      descripcion: 'Ansiedad grave. Se recomienda valorar intervención y '
          'seguimiento estrecho.',
    ),
  ],
  nota: 'El BAI es una medida de cribado y de gravedad sintomática, no un '
      'diagnóstico. Los ítems somáticos pueden elevarse por condiciones '
      'médicas, por lo que conviene contrastarlos con la exploración clínica. '
      'En población mexicana se reporta un alfa de Cronbach de .83. '
      'Instrumento con copyright (Pearson): el uso clínico requiere licencia '
      'vigente del profesional.',
);

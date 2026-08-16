import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del SPIN (molestia 0-4).
const List<OpcionRespuesta> _opcionesSpin = [
  OpcionRespuesta(etiqueta: 'Nada en absoluto', valor: 0),
  OpcionRespuesta(etiqueta: 'Un poco', valor: 1),
  OpcionRespuesta(etiqueta: 'Algo', valor: 2),
  OpcionRespuesta(etiqueta: 'Mucho', valor: 3),
  OpcionRespuesta(etiqueta: 'Extremadamente', valor: 4),
];

/// SPIN: Social Phobia Inventory (Connor et al., 2000).
///
/// Cribado y medición de la gravedad de la fobia social.
const InstrumentoAplicable spinAplicable = InstrumentoAplicable(
  id: 'spin',
  sigla: 'SPIN',
  titulo: 'Inventario de Fobia Social',
  instrucciones: 'Durante la última semana, ¿cuánto le han molestado los '
      'siguientes problemas?',
  preguntas: [
    Pregunta(
        texto: 'Tengo miedo de la gente con autoridad',
        opciones: _opcionesSpin),
    Pregunta(
        texto: 'Me molesta sonrojarme delante de la gente',
        opciones: _opcionesSpin),
    Pregunta(
        texto: 'Las fiestas y actos sociales me dan miedo',
        opciones: _opcionesSpin),
    Pregunta(
        texto: 'Evito hablar con gente desconocida', opciones: _opcionesSpin),
    Pregunta(
        texto: 'Me da mucho miedo que me critiquen', opciones: _opcionesSpin),
    Pregunta(
        texto:
            'Evito hacer cosas o hablar con la gente por miedo a que me dé vergüenza',
        opciones: _opcionesSpin),
    Pregunta(
        texto: 'Sudar delante de la gente me molesta', opciones: _opcionesSpin),
    Pregunta(texto: 'Evito ir a fiestas', opciones: _opcionesSpin),
    Pregunta(
        texto: 'Evito actividades en las que soy el centro de atención',
        opciones: _opcionesSpin),
    Pregunta(
        texto: 'Conversar con desconocidos me da miedo',
        opciones: _opcionesSpin),
    Pregunta(texto: 'Evito hablar en público', opciones: _opcionesSpin),
    Pregunta(
        texto: 'Haría cualquier cosa para evitar que me critiquen',
        opciones: _opcionesSpin),
    Pregunta(
        texto:
            'Las palpitaciones (corazón acelerado) me molestan delante de la gente',
        opciones: _opcionesSpin),
    Pregunta(
        texto: 'Tengo miedo de hacer cosas cuando podría cometer errores',
        opciones: _opcionesSpin),
    Pregunta(
        texto: 'Sentir vergüenza me resulta horrible', opciones: _opcionesSpin),
    Pregunta(
        texto: 'Evito hablar con cualquier persona con autoridad',
        opciones: _opcionesSpin),
    Pregunta(
        texto: 'Me da miedo temblar delante de los demás',
        opciones: _opcionesSpin),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 18,
      etiqueta: 'Bajo',
      descripcion: 'Sin indicadores clínicamente significativos de fobia '
          'social.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 19,
      maximo: 40,
      etiqueta: 'Probable fobia social',
      descripcion: 'La puntuación ≥ 19 sugiere un probable trastorno de '
          'ansiedad social. Se recomienda evaluación clínica.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 41,
      maximo: 68,
      etiqueta: 'Severa',
      descripcion: 'Sintomatología de ansiedad social severa.',
    ),
  ],
  nota: 'El SPIN es una herramienta de cribado, no un diagnóstico. '
      'El punto de corte habitual es ≥ 19.',
);

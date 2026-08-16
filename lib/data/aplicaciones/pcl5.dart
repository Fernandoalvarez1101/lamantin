import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del PCL-5 (molestia 0-4).
const List<OpcionRespuesta> _opcionesPcl5 = [
  OpcionRespuesta(etiqueta: 'Nada', valor: 0),
  OpcionRespuesta(etiqueta: 'Un poco', valor: 1),
  OpcionRespuesta(etiqueta: 'Moderadamente', valor: 2),
  OpcionRespuesta(etiqueta: 'Bastante', valor: 3),
  OpcionRespuesta(etiqueta: 'Extremadamente', valor: 4),
];

/// PCL-5: Lista de Síntomas de TEPT para el DSM-5
/// (Weathers et al., 2013; National Center for PTSD).
///
/// Cribado y medición de la gravedad de los síntomas de TEPT. Dominio
/// público; la traducción al español se solicita al VA.
const InstrumentoAplicable pcl5Aplicable = InstrumentoAplicable(
  id: 'pcl-5',
  sigla: 'PCL-5',
  titulo: 'Lista de Síntomas de TEPT para el DSM-5',
  instrucciones: 'A continuación hay una lista de problemas que las personas '
      'a veces presentan como reacción ante experiencias muy estresantes. '
      'Durante el último mes, ¿cuánto le ha molestado cada problema?',
  preguntas: [
    Pregunta(
        texto:
            'Recuerdos repetidos, perturbadores y no deseados de la experiencia estresante',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Sueños perturbadores y repetidos sobre la experiencia estresante',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Sentir o actuar de repente como si la experiencia estresante estuviera ocurriendo de nuevo (como si la estuviera reviviendo)',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Sentirse muy alterado(a) cuando algo le recordaba la experiencia estresante',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Reacciones físicas fuertes cuando algo le recordaba la experiencia estresante (p. ej., corazón acelerado, dificultad para respirar, sudoración)',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Evitar recuerdos, pensamientos o sentimientos relacionados con la experiencia estresante',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Evitar recordatorios externos de la experiencia estresante (p. ej., personas, lugares, conversaciones, actividades, objetos o situaciones)',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Dificultad para recordar partes importantes de la experiencia estresante',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Sentimientos negativos fuertes hacia usted mismo(a) u otras personas (p. ej., miedo, ira, culpa, vergüenza)',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Culparse a sí mismo(a) por la experiencia estresante o por lo que ocurrió como resultado de ella',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Sentimientos negativos fuertes como miedo, horror, ira, culpa o vergüenza',
        opciones: _opcionesPcl5),
    Pregunta(
        texto: 'Pérdida de interés en actividades que antes disfrutaba',
        opciones: _opcionesPcl5),
    Pregunta(
        texto: 'Sentirse distante o apartado(a) de otras personas',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Dificultad para experimentar sentimientos positivos (p. ej., incapacidad de sentir felicidad o cariño por las personas cercanas)',
        opciones: _opcionesPcl5),
    Pregunta(
        texto:
            'Comportamiento irritable, arrebatos de ira o comportamiento agresivo',
        opciones: _opcionesPcl5),
    Pregunta(
        texto: 'Correr riesgos o hacer cosas que podrían ponerle en peligro',
        opciones: _opcionesPcl5),
    Pregunta(
        texto: 'Estar "sobrealerta", vigilante o en guardia',
        opciones: _opcionesPcl5),
    Pregunta(
        texto: 'Sentirse sobresaltado(a) o asustarse fácilmente',
        opciones: _opcionesPcl5),
    Pregunta(texto: 'Dificultad para concentrarse', opciones: _opcionesPcl5),
    Pregunta(
        texto: 'Dificultad para conciliar o mantener el sueño',
        opciones: _opcionesPcl5),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 32,
      etiqueta: 'Bajo',
      descripcion: 'Sin indicadores de TEPT clínicamente significativos.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 33,
      maximo: 49,
      etiqueta: 'Moderado',
      descripcion: 'La puntuación ≥ 33 sugiere un probable TEPT. Se '
          'recomienda evaluación clínica estructurada.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 50,
      maximo: 80,
      etiqueta: 'Severo',
      descripcion: 'Sintomatología de TEPT severa que requiere valoración '
          'clínica preferente.',
    ),
  ],
  nota: 'El PCL-5 es una herramienta de cribado, no un diagnóstico. '
      'El National Center for PTSD (VA) sugiere un punto de corte de '
      '31-33; el más utilizado es ≥ 33. Instrumento de dominio público '
      '(National Center for PTSD, VA); la traducción oficial al español '
      'se solicita al centro.',
);

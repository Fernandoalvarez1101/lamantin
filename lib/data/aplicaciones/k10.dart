import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del K10 (frecuencia 1-5).
const List<OpcionRespuesta> _opcionesK10 = [
  OpcionRespuesta(etiqueta: 'Nunca', valor: 1),
  OpcionRespuesta(etiqueta: 'Casi nunca', valor: 2),
  OpcionRespuesta(etiqueta: 'A veces', valor: 3),
  OpcionRespuesta(etiqueta: 'Casi siempre', valor: 4),
  OpcionRespuesta(etiqueta: 'Siempre', valor: 5),
];

/// K10: Escala de Malestar Psicológico de Kessler (Kessler et al., 2002).
///
/// Cribado de malestar psicológico no específico en las últimas 4
/// semanas. Dominio público.
const InstrumentoAplicable k10Aplicable = InstrumentoAplicable(
  id: 'k10',
  sigla: 'K10',
  titulo: 'Escala de Malestar Psicológico de Kessler',
  instrucciones: 'Durante las últimas 4 semanas, ¿con qué frecuencia…',
  preguntas: [
    Pregunta(
        texto: 'Se sintió cansado(a) sin motivo aparente',
        opciones: _opcionesK10),
    Pregunta(texto: 'Se sintió nervioso(a)', opciones: _opcionesK10),
    Pregunta(
        texto: 'Se sintió tan nervioso(a) que nada podía calmarlo(a)',
        opciones: _opcionesK10),
    Pregunta(texto: 'Se sintió sin esperanza', opciones: _opcionesK10),
    Pregunta(
        texto: 'Se sintió inquieto(a) o intranquilo(a)',
        opciones: _opcionesK10),
    Pregunta(
        texto: 'Se sintió tan inquieto(a) que no podía quedarse quieto(a)',
        opciones: _opcionesK10),
    Pregunta(texto: 'Se sintió deprimido(a)', opciones: _opcionesK10),
    Pregunta(
        texto: 'Se sintió tan deprimido(a) que nada podía animarlo(a)',
        opciones: _opcionesK10),
    Pregunta(texto: 'Sintió que todo era un esfuerzo', opciones: _opcionesK10),
    Pregunta(texto: 'Se sintió sin valor', opciones: _opcionesK10),
  ],
  rangos: [
    RangoPuntuacion(
        nivel: 0,
        minimo: 10,
        maximo: 19,
        etiqueta: 'Bajo',
        descripcion: 'Malestar psicológico bajo o ausente.'),
    RangoPuntuacion(
        nivel: 1,
        minimo: 20,
        maximo: 24,
        etiqueta: 'Leve',
        descripcion: 'Malestar psicológico leve.'),
    RangoPuntuacion(
        nivel: 2,
        minimo: 25,
        maximo: 29,
        etiqueta: 'Moderado',
        descripcion: 'Malestar psicológico moderado.'),
    RangoPuntuacion(
        nivel: 3,
        minimo: 30,
        maximo: 50,
        etiqueta: 'Alto',
        descripcion:
            'Malestar psicológico alto. Se recomienda evaluación clínica.'),
  ],
  nota: 'El K10 es una herramienta de cribado, no un diagnóstico. '
      'Las bandas de malestar (bajo/leve/moderado/alto) son las publicadas '
      'en: Andrews, G., & Slade, T. (2001). Interpreting scores on the '
      'Kessler Psychological Distress Scale (K10). Australian and New '
      'Zealand Journal of Public Health, 25(6), 494-497. Instrumento de '
      'dominio público.',
);

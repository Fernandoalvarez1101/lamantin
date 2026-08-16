import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones del ISI para gravedad (ítems 1-3).
const List<OpcionRespuesta> _opcionesGravedad = [
  OpcionRespuesta(etiqueta: 'Ninguna', valor: 0),
  OpcionRespuesta(etiqueta: 'Leve', valor: 1),
  OpcionRespuesta(etiqueta: 'Moderada', valor: 2),
  OpcionRespuesta(etiqueta: 'Severa', valor: 3),
  OpcionRespuesta(etiqueta: 'Muy severa', valor: 4),
];

/// Opciones del ISI para satisfacción (ítem 4).
const List<OpcionRespuesta> _opcionesSatisfaccion = [
  OpcionRespuesta(etiqueta: 'Muy satisfecho', valor: 0),
  OpcionRespuesta(etiqueta: 'Satisfecho', valor: 1),
  OpcionRespuesta(etiqueta: 'Neutro', valor: 2),
  OpcionRespuesta(etiqueta: 'Insatisfecho', valor: 3),
  OpcionRespuesta(etiqueta: 'Muy insatisfecho', valor: 4),
];

/// Opciones del ISI para interferencia/preocupación (ítems 5-7).
const List<OpcionRespuesta> _opcionesInterferencia = [
  OpcionRespuesta(etiqueta: 'Nada', valor: 0),
  OpcionRespuesta(etiqueta: 'Un poco', valor: 1),
  OpcionRespuesta(etiqueta: 'Algo', valor: 2),
  OpcionRespuesta(etiqueta: 'Mucho', valor: 3),
  OpcionRespuesta(etiqueta: 'Muchísimo', valor: 4),
];

/// ISI: Índice de Severidad de Insomnio (Morin, 1993).
///
/// Evalúa la gravedad del insomnio, su impacto diurno y la percepción
/// del problema en el último mes.
const InstrumentoAplicable isiAplicable = InstrumentoAplicable(
  id: 'isi',
  sigla: 'ISI',
  titulo: 'Índice de Severidad de Insomnio',
  instrucciones: 'Responda sobre su sueño durante el último mes.',
  preguntas: [
    Pregunta(
        texto: 'Dificultad para conciliar el sueño',
        opciones: _opcionesGravedad),
    Pregunta(
        texto: 'Dificultad para mantenerse dormido(a)',
        opciones: _opcionesGravedad),
    Pregunta(
        texto: 'Problemas para despertarse demasiado temprano',
        opciones: _opcionesGravedad),
    Pregunta(
        texto: '¿Qué tan satisfecho(a) está con su patrón de sueño actual?',
        opciones: _opcionesSatisfaccion),
    Pregunta(
        texto:
            '¿Qué tan notorio es su problema de sueño para otras personas, en cuanto a deterioro de la calidad de vida?',
        opciones: _opcionesInterferencia),
    Pregunta(
        texto: '¿Qué tan preocupado(a) está usted por su problema de sueño?',
        opciones: _opcionesInterferencia),
    Pregunta(
        texto:
            '¿Qué tanto interfiere su problema de sueño con su funcionamiento diario (fatiga, concentración, memoria, ánimo, etc.)?',
        opciones: _opcionesInterferencia),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 7,
      etiqueta: 'No significativo',
      descripcion: 'Sin insomnio clínicamente significativo.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 8,
      maximo: 14,
      etiqueta: 'Subumbral',
      descripcion: 'Insomnio subumbral (por debajo del umbral clínico).',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 15,
      maximo: 21,
      etiqueta: 'Moderado',
      descripcion: 'Insomnio moderado (gravedad clínica).',
    ),
    RangoPuntuacion(
      nivel: 3,
      minimo: 22,
      maximo: 28,
      etiqueta: 'Severo',
      descripcion: 'Insomnio severo (gravedad clínica).',
    ),
  ],
  nota: 'El ISI es una herramienta de cribado, no un diagnóstico. '
      'El punto de corte habitual es ≥ 15 para insomnio clínico. '
      'Libre uso clínico con permiso del autor (Morin).',
);

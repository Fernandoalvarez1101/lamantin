import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// EPDS: Escala de Depresión Postnatal de Edimburgo
/// (Cox, Holden y Sagovsky, 1987).
///
/// Cribado de depresión en el embarazo y el posparto. Cada ítem tiene
/// sus propias opciones de respuesta y valores 0-3. El ítem 10 evalúa
/// ideación de autolesión.
const InstrumentoAplicable epdsAplicable = InstrumentoAplicable(
  id: 'epds',
  sigla: 'EPDS',
  titulo: 'Escala de Depresión Postnatal de Edimburgo',
  instrucciones: 'Como usted se encuentra embarazada o ha tenido un bebé '
      'recientemente, queremos saber cómo se siente. Marque la respuesta '
      'que más se acerca a cómo se ha sentido en los últimos 7 días.',
  preguntas: [
    Pregunta(
      texto: 'He sido capaz de reír y ver el lado divertido de las cosas',
      opciones: [
        OpcionRespuesta(etiqueta: 'Tanto como siempre', valor: 0),
        OpcionRespuesta(etiqueta: 'No tanto como antes', valor: 1),
        OpcionRespuesta(etiqueta: 'Mucho menos que antes', valor: 2),
        OpcionRespuesta(etiqueta: 'No, nada', valor: 3),
      ],
    ),
    Pregunta(
      texto: 'He mirado el futuro con placer',
      opciones: [
        OpcionRespuesta(etiqueta: 'Tanto como siempre', valor: 0),
        OpcionRespuesta(etiqueta: 'Algo menos que antes', valor: 1),
        OpcionRespuesta(etiqueta: 'Definitivamente menos que antes', valor: 2),
        OpcionRespuesta(etiqueta: 'Casi nunca', valor: 3),
      ],
    ),
    Pregunta(
      texto: 'Me he culpado innecesariamente cuando las cosas marchaban mal',
      opciones: [
        OpcionRespuesta(etiqueta: 'No, nunca', valor: 0),
        OpcionRespuesta(etiqueta: 'Casi nunca', valor: 1),
        OpcionRespuesta(etiqueta: 'Sí, a veces', valor: 2),
        OpcionRespuesta(
          etiqueta: 'Sí, la mayor parte de las veces',
          valor: 3,
        ),
      ],
    ),
    Pregunta(
      texto: 'He estado ansiosa o preocupada sin motivo',
      opciones: [
        OpcionRespuesta(etiqueta: 'No, en absoluto', valor: 0),
        OpcionRespuesta(etiqueta: 'Casi nunca', valor: 1),
        OpcionRespuesta(etiqueta: 'Sí, a veces', valor: 2),
        OpcionRespuesta(etiqueta: 'Sí, muy a menudo', valor: 3),
      ],
    ),
    Pregunta(
      texto: 'He sentido miedo o pánico sin motivo',
      opciones: [
        OpcionRespuesta(etiqueta: 'No, en absoluto', valor: 0),
        OpcionRespuesta(etiqueta: 'Casi nunca', valor: 1),
        OpcionRespuesta(etiqueta: 'Sí, a veces', valor: 2),
        OpcionRespuesta(etiqueta: 'Sí, muy a menudo', valor: 3),
      ],
    ),
    Pregunta(
      texto: 'Las cosas me han sobrepasado',
      opciones: [
        OpcionRespuesta(
            etiqueta: 'No, he podido afrontarlas como siempre', valor: 0),
        OpcionRespuesta(
            etiqueta: 'No, generalmente he podido afrontarlas', valor: 1),
        OpcionRespuesta(
            etiqueta: 'Sí, a veces no las he afrontado tan bien como siempre',
            valor: 2),
        OpcionRespuesta(
            etiqueta: 'Sí, la mayoría de las veces no he podido afrontarlas',
            valor: 3),
      ],
    ),
    Pregunta(
      texto:
          'Me he sentido tan desdichada que he tenido dificultades para dormir',
      opciones: [
        OpcionRespuesta(etiqueta: 'No, en absoluto', valor: 0),
        OpcionRespuesta(etiqueta: 'Casi nunca', valor: 1),
        OpcionRespuesta(etiqueta: 'Sí, a veces', valor: 2),
        OpcionRespuesta(
          etiqueta: 'Sí, la mayor parte de las veces',
          valor: 3,
        ),
      ],
    ),
    Pregunta(
      texto: 'Me he sentido triste o desgraciada',
      opciones: [
        OpcionRespuesta(etiqueta: 'No, en absoluto', valor: 0),
        OpcionRespuesta(etiqueta: 'Casi nunca', valor: 1),
        OpcionRespuesta(etiqueta: 'Sí, a veces', valor: 2),
        OpcionRespuesta(
          etiqueta: 'Sí, la mayor parte de las veces',
          valor: 3,
        ),
      ],
    ),
    Pregunta(
      texto: 'Me he sentido tan desdichada que he estado llorando',
      opciones: [
        OpcionRespuesta(etiqueta: 'No, nunca', valor: 0),
        OpcionRespuesta(etiqueta: 'Casi nunca', valor: 1),
        OpcionRespuesta(etiqueta: 'Sí, a veces', valor: 2),
        OpcionRespuesta(
          etiqueta: 'Sí, la mayor parte de las veces',
          valor: 3,
        ),
      ],
    ),
    Pregunta(
      texto: 'Se me ha ocurrido la idea de hacerme daño',
      opciones: [
        OpcionRespuesta(etiqueta: 'No, nunca', valor: 0),
        OpcionRespuesta(etiqueta: 'Casi nunca', valor: 1),
        OpcionRespuesta(etiqueta: 'A veces', valor: 2),
        OpcionRespuesta(etiqueta: 'Sí, a menudo', valor: 3),
      ],
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 9,
      etiqueta: 'Baja',
      descripcion: 'Baja probabilidad de depresión.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 10,
      maximo: 12,
      etiqueta: 'Posible',
      descripcion: 'Síntomas posibles de depresión. Se recomienda una '
          'evaluación clínica detallada.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 13,
      maximo: 30,
      etiqueta: 'Probable',
      descripcion: 'Probable depresión. Se recomienda valoración clínica '
          'y seguimiento cercano.',
    ),
  ],
  alertas: [
    AlertaPregunta(
      numeroPregunta: 10,
      valorMinimo: 1,
      mensaje: 'Se registró una respuesta positiva en el ítem 10 '
          '(idea de hacerse daño). Realice una evaluación inmediata del '
          'riesgo de autolesión siguiendo el protocolo clínico.',
    ),
  ],
  nota: 'La EPDS es una herramienta de cribado, no un diagnóstico. '
      'El punto de corte habitual es ≥ 10. Validada en español por '
      'García-Esteve y colaboradores (2003).',
);

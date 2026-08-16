import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones del AUDIT para frecuencia de consumo (pregunta 1).
const List<OpcionRespuesta> _opcionesFrecuencia = [
  OpcionRespuesta(etiqueta: 'Nunca', valor: 0),
  OpcionRespuesta(etiqueta: 'Una vez al mes o menos', valor: 1),
  OpcionRespuesta(etiqueta: '2 a 4 veces al mes', valor: 2),
  OpcionRespuesta(etiqueta: '2 a 3 veces por semana', valor: 3),
  OpcionRespuesta(etiqueta: '4 o más veces a la semana', valor: 4),
];

/// Opciones del AUDIT para número de consumiciones (pregunta 2).
const List<OpcionRespuesta> _opcionesCantidad = [
  OpcionRespuesta(etiqueta: '1 o 2', valor: 0),
  OpcionRespuesta(etiqueta: '3 o 4', valor: 1),
  OpcionRespuesta(etiqueta: '5 o 6', valor: 2),
  OpcionRespuesta(etiqueta: '7 a 9', valor: 3),
  OpcionRespuesta(etiqueta: '10 o más', valor: 4),
];

/// Opciones del AUDIT para frecuencia (preguntas 3-5).
const List<OpcionRespuesta> _opcionesFrecuenciaAlta = [
  OpcionRespuesta(etiqueta: 'Nunca', valor: 0),
  OpcionRespuesta(etiqueta: 'Menos de una vez al mes', valor: 1),
  OpcionRespuesta(etiqueta: 'Mensualmente', valor: 2),
  OpcionRespuesta(etiqueta: 'Semanalmente', valor: 3),
  OpcionRespuesta(etiqueta: 'A diario o casi a diario', valor: 4),
];

/// Opciones del AUDIT para preguntas de consecuencias (6-10).
const List<OpcionRespuesta> _opcionesConsecuencias = [
  OpcionRespuesta(etiqueta: 'No', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí, pero no en el último año', valor: 2),
  OpcionRespuesta(etiqueta: 'Sí, en el último año', valor: 4),
];

/// AUDIT: Test de Identificación de Trastornos por Consumo de Alcohol
/// (OMS / Babor et al., 2001).
///
/// Identifica consumo de riesgo, consumo perjudicial y posible
/// dependencia en el último año.
const InstrumentoAplicable auditAplicable = InstrumentoAplicable(
  id: 'audit',
  sigla: 'AUDIT',
  titulo: 'Test de Identificación de Trastornos por Consumo de Alcohol',
  instrucciones: 'Responda sobre su consumo de bebidas alcohólicas durante '
      'el último año.',
  preguntas: [
    Pregunta(
        texto: '¿Con qué frecuencia consume alguna bebida alcohólica?',
        opciones: _opcionesFrecuencia),
    Pregunta(
        texto:
            '¿Cuántas consumiciones de bebidas alcohólicas suele realizar en un día normal de consumo?',
        opciones: _opcionesCantidad),
    Pregunta(
        texto:
            '¿Con qué frecuencia toma 6 o más bebidas alcohólicas en un solo día?',
        opciones: _opcionesFrecuenciaAlta),
    Pregunta(
        texto:
            '¿Con qué frecuencia, en el curso del último año, ha sido incapaz de dejar de beber una vez había empezado?',
        opciones: _opcionesFrecuenciaAlta),
    Pregunta(
        texto:
            '¿Con qué frecuencia, en el curso del último año, no pudo hacer lo que se esperaba de usted porque había bebido?',
        opciones: _opcionesFrecuenciaAlta),
    Pregunta(
        texto:
            '¿Con qué frecuencia, en el curso del último año, ha necesitado beber en ayunas para recuperarse después de haber bebido mucho el día anterior?',
        opciones: _opcionesFrecuenciaAlta),
    Pregunta(
        texto:
            '¿Con qué frecuencia, en el curso del último año, ha tenido remordimientos o sentimientos de culpa después de haber bebido?',
        opciones: _opcionesFrecuenciaAlta),
    Pregunta(
        texto:
            '¿Con qué frecuencia, en el curso del último año, no ha podido recordar lo que sucedió la noche anterior porque había estado bebiendo?',
        opciones: _opcionesFrecuenciaAlta),
    Pregunta(
        texto:
            '¿Usted o alguna otra persona ha resultado herida porque usted había bebido?',
        opciones: _opcionesConsecuencias),
    Pregunta(
        texto:
            '¿Algún familiar, amigo, médico o profesional de la salud ha mostrado preocupación por su consumo de bebidas alcohólicas o le ha sugerido que deje de beber?',
        opciones: _opcionesConsecuencias),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 7,
      etiqueta: 'Bajo riesgo',
      descripcion: 'Consumo de bajo riesgo según la OMS.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 8,
      maximo: 15,
      etiqueta: 'Riesgo',
      descripcion: 'Consumo de riesgo (peligroso). Se recomienda una '
          'intervención breve.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 16,
      maximo: 19,
      etiqueta: 'Consumo perjudicial',
      descripcion: 'Consumo perjudicial. Se recomienda intervención '
          'breve y seguimiento.',
    ),
    RangoPuntuacion(
      nivel: 3,
      minimo: 20,
      maximo: 40,
      etiqueta: 'Posible dependencia',
      descripcion: 'Posible dependencia del alcohol. Se recomienda una '
          'evaluación especializada.',
    ),
  ],
  nota: 'El AUDIT es una herramienta de cribado, no un diagnóstico. '
      'El manual de la OMS está disponible en español. Los ítems 9 y 10 '
      'puntúan 0, 2 o 4.',
);

import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones del ASSIST para frecuencia (pesos del manual de la OMS).
const List<OpcionRespuesta> _opcionesFrecuencia = [
  OpcionRespuesta(etiqueta: 'Nunca', valor: 0),
  OpcionRespuesta(etiqueta: 'Una o dos veces', valor: 2),
  OpcionRespuesta(etiqueta: 'Mensualmente', valor: 3),
  OpcionRespuesta(etiqueta: 'Semanalmente', valor: 4),
  OpcionRespuesta(etiqueta: 'A diario o casi a diario', valor: 6),
];

/// Opciones del ASSIST para intensidad de problemas (pesos 0/3/4/5/6).
const List<OpcionRespuesta> _opcionesProblemas = [
  OpcionRespuesta(etiqueta: 'Nunca', valor: 0),
  OpcionRespuesta(etiqueta: 'Una o dos veces', valor: 3),
  OpcionRespuesta(etiqueta: 'Mensualmente', valor: 4),
  OpcionRespuesta(etiqueta: 'Semanalmente', valor: 5),
  OpcionRespuesta(etiqueta: 'A diario o casi a diario', valor: 6),
];

/// Opciones del ASSIST para preocupación de terceros e intentos de control.
const List<OpcionRespuesta> _opcionesPreocupacion = [
  OpcionRespuesta(etiqueta: 'No, nunca', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí, en los últimos 3 meses', valor: 6),
  OpcionRespuesta(etiqueta: 'Sí, pero no en los últimos 3 meses', valor: 3),
];

/// ASSIST v3.0: Test de Detección de Consumo de Alcohol, Tabaco y
/// Sustancias (OMS, 2002). Ejemplo de aplicación para el alcohol.
///
/// La puntuación (Q2-Q7) sigue el manual de la OMS: 0-3 riesgo bajo,
/// 4-26 riesgo moderado, ≥27 riesgo alto. Se administra por cada
/// sustancia reportada.
const InstrumentoAplicable assistAplicable = InstrumentoAplicable(
  id: 'assist-v3',
  sigla: 'ASSIST v3.0',
  titulo: 'Test de Detección de Consumo de Alcohol, Tabaco y Sustancias',
  instrucciones: 'A continuación se preguntará sobre su consumo de alcohol. '
      'El mismo bloque se repetiría para cada sustancia reportada.',
  preguntas: [
    Pregunta(
        texto:
            'Durante los últimos 3 meses, ¿con qué frecuencia ha consumido bebidas alcohólicas?',
        opciones: _opcionesFrecuencia),
    Pregunta(
        texto:
            'Durante los últimos 3 meses, ¿con qué frecuencia ha tenido un fuerte deseo o ansias de consumir alcohol?',
        opciones: _opcionesProblemas),
    Pregunta(
        texto:
            'Durante los últimos 3 meses, ¿con qué frecuencia el consumo de alcohol le ha causado problemas de salud, sociales, legales o económicos?',
        opciones: _opcionesProblemas),
    Pregunta(
        texto:
            'Durante los últimos 3 meses, ¿con qué frecuencia ha dejado de hacer lo que normalmente se esperaba de usted por consumir alcohol?',
        opciones: _opcionesProblemas),
    Pregunta(
        texto:
            '¿Alguna persona (familiar, amigo, médico u otro profesional) ha expresado preocupación por su consumo de alcohol?',
        opciones: _opcionesPreocupacion),
    Pregunta(
        texto:
            '¿Ha intentado alguna vez controlar, reducir o dejar de consumir alcohol?',
        opciones: _opcionesPreocupacion),
  ],
  preguntasComplementarias: [
    Pregunta(
      texto: '¿Con qué frecuencia ha consumido bebidas alcohólicas en su vida?',
      opciones: _opcionesFrecuencia,
    ),
    Pregunta(
      texto: '¿Ha consumido alguna vez alguna droga por vía inyectada?',
      opciones: _opcionesPreocupacion,
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 3,
      etiqueta: 'Riesgo bajo',
      descripcion: 'Consumo de bajo riesgo. Se recomienda información '
          'breve sobre los riesgos.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 4,
      maximo: 26,
      etiqueta: 'Riesgo moderado',
      descripcion: 'Consumo de riesgo moderado. Se recomienda una '
          'intervención breve.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 27,
      maximo: 36,
      etiqueta: 'Riesgo alto',
      descripcion: 'Consumo de alto riesgo. Se recomienda derivación a '
          'evaluación y tratamiento especializado.',
    ),
  ],
  nota: 'El ASSIST se administra por cada sustancia reportada; este '
      'ejemplo corresponde al alcohol (pesos del manual de la OMS). '
      'La pregunta 8 (vía inyectada), si es positiva, requiere atención '
      'inmediata (riesgo de transmisión de VIH/hepatitis).',
);

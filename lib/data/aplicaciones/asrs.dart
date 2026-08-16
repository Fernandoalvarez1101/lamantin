import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del ASRS (frecuencia 0-4).
const List<OpcionRespuesta> _opcionesAsrs = [
  OpcionRespuesta(etiqueta: 'Nunca', valor: 0),
  OpcionRespuesta(etiqueta: 'Rara vez', valor: 1),
  OpcionRespuesta(etiqueta: 'A veces', valor: 2),
  OpcionRespuesta(etiqueta: 'Con frecuencia', valor: 3),
  OpcionRespuesta(etiqueta: 'Muy a menudo', valor: 4),
];

/// ASRS v1.1: Adult ADHD Self-Report Scale (Kessler et al., 2005; OMS).
///
/// Cribado de síntomas de TDAH en adultos. La parte A (6 ítems) es el
/// cribado: se considera positivo si al menos 4 de los 6 ítems alcanzan
/// su umbral. La parte B (12 ítems) aporta información complementaria.
const InstrumentoAplicable asrsAplicable = InstrumentoAplicable(
  id: 'asrs-v1-1',
  sigla: 'ASRS v1.1',
  titulo: 'Escala de Autoreporte de TDAH en Adultos v1.1',
  instrucciones: 'Indique con qué frecuencia le han ocurrido las siguientes '
      'situaciones en los últimos 6 meses.',
  preguntas: [
    Pregunta(
        texto:
            '¿Con qué frecuencia comete errores por descuido cuando tiene que trabajar en un proyecto aburrido o difícil?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia le resulta difícil mantener la atención cuando está haciendo un trabajo aburrido o repetitivo?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia tiene dificultad para concentrarse en lo que la gente le dice, incluso cuando le hablan directamente?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia deja un proyecto a medias después de haber empezado?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia le resulta difícil hacer las cosas en orden cuando tiene que hacer algo que requiere organización?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia evita o retrasa empezar algo que requiere mucho pensamiento?',
        opciones: _opcionesAsrs),
  ],
  preguntasComplementarias: [
    Pregunta(
        texto:
            '¿Con qué frecuencia se retuerce o retuerce las manos o los pies cuando tiene que estar sentado(a) durante mucho tiempo?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia se siente demasiado activo(a) y obligado(a) a hacer cosas, como si lo(a) impulsara un motor?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia se distrae cuando está en medio de una actividad?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia tiene dificultad para calmarse y relajarse después de una actividad?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia se siente "en marcha" o "con un motor adentro"?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia se descubre hablando cuando otros todavía están hablando?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia tiende a terminar las frases de otras personas antes de que ellos terminen de hablar?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia tiene dificultad para esperar su turno en situaciones que requieren orden?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto: '¿Con qué frecuencia interrumpe a otros cuando están ocupados?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto: '¿Con qué frecuencia se siente inquieto(a) o agitado(a)?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia tiene dificultad para hacer las cosas en su tiempo libre?',
        opciones: _opcionesAsrs),
    Pregunta(
        texto:
            '¿Con qué frecuencia tiene dificultad para estar quieto(a) cuando está sentado(a) durante mucho tiempo?',
        opciones: _opcionesAsrs),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 3,
      etiqueta: 'Negativo',
      descripcion: 'Menos de 4 ítems de la parte A por encima del umbral.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 4,
      maximo: 6,
      etiqueta: 'Positivo',
      descripcion: '4 o más ítems de la parte A por encima del umbral. '
          'Cribado positivo: se recomienda una evaluación clínica completa.',
    ),
  ],
  calcularPuntuacionPersonalizada: _contarPositivosParteA,
  nota: 'El ASRS v1.1 es una herramienta de cribado, no un diagnóstico. '
      'La parte A se considera positiva si ≥ 4 de 6 ítems superan su '
      'umbral (ítems 1-3: «con frecuencia» o más; ítems 4-6: «a veces» o '
      'más). La parte B es complementaria. Libre uso (OMS).',
);

/// Cuenta los ítems de la parte A que superan su umbral (0-6).
int _contarPositivosParteA(List<int> respuestas) {
  var positivos = 0;
  for (var i = 0; i < 6; i++) {
    final umbral = i < 3 ? 3 : 2;
    if (respuestas[i] >= umbral) positivos++;
  }
  return positivos;
}

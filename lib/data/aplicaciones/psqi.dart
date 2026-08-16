import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones del PSQI para frecuencia (0-3).
const List<OpcionRespuesta> _opcionesFrecuencia = [
  OpcionRespuesta(etiqueta: 'Ninguna', valor: 0),
  OpcionRespuesta(etiqueta: 'Menos de una vez a la semana', valor: 1),
  OpcionRespuesta(etiqueta: 'Una o dos veces a la semana', valor: 2),
  OpcionRespuesta(etiqueta: 'Tres o más veces a la semana', valor: 3),
];

/// PSQI: Índice de Calidad de Sueño de Pittsburgh (Buysse et al., 1989).
///
/// Valora la calidad del sueño del último mes mediante 7 componentes
/// (cada uno de 0 a 3) que se suman en una puntuación global de 0 a 21.
/// La puntuación global no es una suma lineal de los ítems, por lo que
/// usa un calculador personalizado.
const InstrumentoAplicable psqiAplicable = InstrumentoAplicable(
  id: 'psqi',
  sigla: 'PSQI',
  titulo: 'Índice de Calidad de Sueño de Pittsburgh',
  instrucciones: 'Las siguientes preguntas se refieren a sus hábitos de '
      'sueño durante el último mes.',
  preguntas: [
    Pregunta(
      texto:
          'Durante el último mes, ¿cómo calificaría en general la calidad de su sueño?',
      opciones: [
        OpcionRespuesta(etiqueta: 'Muy buena', valor: 0),
        OpcionRespuesta(etiqueta: 'Bastante buena', valor: 1),
        OpcionRespuesta(etiqueta: 'Bastante mala', valor: 2),
        OpcionRespuesta(etiqueta: 'Muy mala', valor: 3),
      ],
    ),
    Pregunta(
      texto:
          '¿Cuánto tiempo tarda normalmente en quedarse dormido(a) cada noche?',
      opciones: [
        OpcionRespuesta(etiqueta: '0 a 15 minutos', valor: 0),
        OpcionRespuesta(etiqueta: '16 a 30 minutos', valor: 1),
        OpcionRespuesta(etiqueta: '31 a 60 minutos', valor: 2),
        OpcionRespuesta(etiqueta: 'Más de 60 minutos', valor: 3),
      ],
    ),
    Pregunta(
        texto:
            '¿Con qué frecuencia tuvo problemas para dormir por no poder conciliar el sueño en 30 minutos?',
        opciones: _opcionesFrecuencia),
    Pregunta(
      texto: '¿Cuántas horas durmió en promedio cada noche?',
      opciones: [
        OpcionRespuesta(etiqueta: 'Más de 7 horas', valor: 0),
        OpcionRespuesta(etiqueta: 'Entre 6 y 7 horas', valor: 1),
        OpcionRespuesta(etiqueta: 'Entre 5 y 6 horas', valor: 2),
        OpcionRespuesta(etiqueta: 'Menos de 5 horas', valor: 3),
      ],
    ),
    Pregunta(
      texto: '¿Qué porcentaje del tiempo que pasó en la cama durmió?',
      opciones: [
        OpcionRespuesta(etiqueta: '85% o más', valor: 0),
        OpcionRespuesta(etiqueta: 'Entre 75% y 84%', valor: 1),
        OpcionRespuesta(etiqueta: 'Entre 65% y 74%', valor: 2),
        OpcionRespuesta(etiqueta: 'Menos de 65%', valor: 3),
      ],
    ),
    Pregunta(
        texto: 'Despertarse a mitad de la noche o de madrugada',
        opciones: _opcionesFrecuencia),
    Pregunta(
        texto: 'Tener que levantarse para ir al baño',
        opciones: _opcionesFrecuencia),
    Pregunta(
        texto: 'No poder respirar con comodidad',
        opciones: _opcionesFrecuencia),
    Pregunta(
        texto: 'Toser o roncar ruidosamente', opciones: _opcionesFrecuencia),
    Pregunta(texto: 'Sentir demasiado frío', opciones: _opcionesFrecuencia),
    Pregunta(texto: 'Sentir demasiado calor', opciones: _opcionesFrecuencia),
    Pregunta(texto: 'Tener pesadillas', opciones: _opcionesFrecuencia),
    Pregunta(texto: 'Sentir dolor', opciones: _opcionesFrecuencia),
    Pregunta(
        texto: 'Otras razones que le impidieron dormir bien',
        opciones: _opcionesFrecuencia),
    Pregunta(
        texto:
            '¿Con qué frecuencia tomó medicación (recetada o de venta libre) para ayudarle a dormir?',
        opciones: _opcionesFrecuencia),
    Pregunta(
        texto:
            '¿Con qué frecuencia tuvo problemas para mantenerse despierto(a) mientras manejaba, comía o realizaba alguna actividad social?',
        opciones: _opcionesFrecuencia),
    Pregunta(
      texto:
          'Durante el último mes, ¿cuánto problema ha tenido para mantener el entusiasmo por hacer las cosas?',
      opciones: [
        OpcionRespuesta(etiqueta: 'Nada', valor: 0),
        OpcionRespuesta(etiqueta: 'Solo un poco', valor: 1),
        OpcionRespuesta(etiqueta: 'Algo', valor: 2),
        OpcionRespuesta(etiqueta: 'Mucho', valor: 3),
      ],
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 5,
      etiqueta: 'Buena calidad',
      descripcion: 'Buena calidad de sueño.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 6,
      maximo: 21,
      etiqueta: 'Mala calidad',
      descripcion: 'Mala calidad de sueño (puntuación global > 5). '
          'Se recomienda una evaluación más profunda.',
    ),
  ],
  calcularPuntuacionPersonalizada: _puntuacionPsqi,
  nota: 'El PSQI es una herramienta de cribado, no un diagnóstico. '
      'La puntuación global > 5 indica mala calidad de sueño. El '
      'componente de eficiencia se captura con las categorías estándar '
      'de la puntuación oficial.',
);

/// Calcula la puntuación global del PSQI (suma de los 7 componentes).
int _puntuacionPsqi(List<int> r) {
  // Componente 1: calidad subjetiva del sueño.
  final c1 = r[0];

  // Componente 2: latencia (minutos + frecuencia en 30 minutos).
  final latencia = r[1] + r[2];
  final c2 = latencia == 0 ? 0 : (latencia <= 2 ? 1 : (latencia <= 4 ? 2 : 3));

  // Componente 3: duración del sueño.
  final c3 = r[3];

  // Componente 4: eficiencia del sueño (categorías estándar).
  final c4 = r[4];

  // Componente 5: perturbaciones del sueño (suma de 9 ítems).
  final disturbios = r.sublist(5, 14).fold(0, (a, b) => a + b);
  final c5 =
      disturbios == 0 ? 0 : (disturbios <= 9 ? 1 : (disturbios <= 18 ? 2 : 3));

  // Componente 6: uso de medicación para dormir.
  final c6 = r[14];

  // Componente 7: disfunción diurna (despierto durante el día + ánimo).
  final disfuncion = r[15] + r[16];
  final c7 =
      disfuncion == 0 ? 0 : (disfuncion <= 2 ? 1 : (disfuncion <= 4 ? 2 : 3));

  return c1 + c2 + c3 + c4 + c5 + c6 + c7;
}

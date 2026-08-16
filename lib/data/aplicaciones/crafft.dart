import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del CRAFFT (sí/no).
const List<OpcionRespuesta> _opcionesSiNo = [
  OpcionRespuesta(etiqueta: 'No', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí', valor: 1),
];

/// CRAFFT: cribado de consumo de riesgo en adolescentes (Knight et al.,
/// 1999). Las siglas corresponden a Car, Relax, Alone, Forget, Friends,
/// Trouble.
const InstrumentoAplicable crafftAplicable = InstrumentoAplicable(
  id: 'crafft',
  sigla: 'CRAFFT',
  titulo: 'Cuestionario CRAFFT',
  instrucciones: 'Las siguientes preguntas se refieren a su consumo de '
      'alcohol y drogas.',
  preguntas: [
    Pregunta(
        texto:
            '¿Has viajado alguna vez en un automóvil conducido por ti u otra persona que estuviera bajo los efectos del alcohol o las drogas?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto:
            '¿Consumes alcohol o drogas para relajarte, sentirte mejor contigo mismo(a) o encajar en un grupo?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Consumes alcohol o drogas estando solo(a)?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto:
            '¿Olvidas las cosas que hiciste cuando consumías alcohol o drogas?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto:
            '¿Tu familia o amigos te dicen que deberías reducir el consumo de alcohol o drogas?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Te has metido en problemas por consumir alcohol o drogas?',
        opciones: _opcionesSiNo),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 1,
      etiqueta: 'Bajo riesgo',
      descripcion: 'Bajo riesgo de consumo problemático.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 2,
      maximo: 6,
      etiqueta: 'Riesgo alto',
      descripcion: 'Dos o más respuestas positivas indican un riesgo '
          'alto y requieren una evaluación más profunda.',
    ),
  ],
  nota: 'El CRAFFT es un cribado para adolescentes y jóvenes (≤ 21 años), '
      'no un diagnóstico. El punto de corte habitual es ≥ 2. Existe la '
      'versión actualizada CRAFFT 2.1.',
);

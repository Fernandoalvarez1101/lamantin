import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del DAR-5 (frecuencia 0-4).
const List<OpcionRespuesta> _opcionesDar5 = [
  OpcionRespuesta(etiqueta: 'Nada', valor: 0),
  OpcionRespuesta(etiqueta: 'Un poco', valor: 1),
  OpcionRespuesta(etiqueta: 'Moderadamente', valor: 2),
  OpcionRespuesta(etiqueta: 'Bastante', valor: 3),
  OpcionRespuesta(etiqueta: 'Extremadamente', valor: 4),
];

/// DAR-5: Dimensions of Anger Reactions-5 (Forbes et al., 2014).
///
/// Evalúa la gravedad de la ira, especialmente la ira posterior a
/// experiencias traumáticas. Instrumento de dominio público.
const InstrumentoAplicable dar5Aplicable = InstrumentoAplicable(
  id: 'dar-5',
  sigla: 'DAR-5',
  titulo: 'Dimensiones de Reacciones de Ira-5',
  instrucciones: 'Durante el último mes, indique con qué frecuencia se ha '
      'sentido de la siguiente manera.',
  preguntas: [
    Pregunta(
        texto: 'Me encontré enfadándome con personas o situaciones',
        opciones: _opcionesDar5),
    Pregunta(
        texto: 'Cuando me enfadaba, me enfadaba de verdad',
        opciones: _opcionesDar5),
    Pregunta(
        texto: 'Cuando me enfadaba, quería gritar a alguien o golpear algo',
        opciones: _opcionesDar5),
    Pregunta(
        texto: 'Cuando me enfadaba, decía o hacía cosas que luego lamentaba',
        opciones: _opcionesDar5),
    Pregunta(
        texto:
            'Cuando me enfadaba, permanecía enfadado(a) durante mucho tiempo',
        opciones: _opcionesDar5),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 11,
      etiqueta: 'Baja',
      descripcion: 'Nivel de ira dentro de lo esperable.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 12,
      maximo: 20,
      etiqueta: 'Clínicamente significativa',
      descripcion: 'La puntuación ≥ 12 sugiere un nivel de ira '
          'clínicamente significativo. Se recomienda evaluación clínica.',
    ),
  ],
  nota: 'El DAR-5 es una herramienta de cribado, no un diagnóstico. '
      'El punto de corte habitual es ≥ 12. Instrumento de dominio público.',
);

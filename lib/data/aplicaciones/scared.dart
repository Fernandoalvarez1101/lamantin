import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del SCARED (0-2).
const List<OpcionRespuesta> _opcionesScared = [
  OpcionRespuesta(etiqueta: 'No es cierto', valor: 0),
  OpcionRespuesta(etiqueta: 'A veces o algo cierto', valor: 1),
  OpcionRespuesta(etiqueta: 'Cierto o muy cierto', valor: 2),
];

/// SCARED: Screen for Child Anxiety Related Emotional Disorders
/// (Birmaher et al., 1997).
///
/// Cribado de síntomas de ansiedad en niños y adolescentes. La puntuación
/// total ≥ 25 sugiere un probable trastorno de ansiedad. Las subescalas
/// siguen la estructura de 5 factores de Birmaher.
const InstrumentoAplicable scaredAplicable = InstrumentoAplicable(
  id: 'scared',
  sigla: 'SCARED',
  titulo: 'Cribado de Trastornos Emocionales Relacionados con la Ansiedad '
      'Infantil',
  instrucciones: 'Seleccione la opción que mejor describa cómo se ha sentido '
      'el niño(a).',
  preguntas: [
    Pregunta(
        texto: 'Cuando me da miedo algo, me cuesta respirar',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Me dan dolores de cabeza cuando estoy en la escuela',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'No me gusta estar con gente que no conozco bien',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Me asusto si duermo fuera de casa', opciones: _opcionesScared),
    Pregunta(
        texto: 'Me preocupa que a otras personas no les caiga bien',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Cuando me da miedo algo, siento que me voy a desmayar',
        opciones: _opcionesScared),
    Pregunta(texto: 'Soy nervioso(a)', opciones: _opcionesScared),
    Pregunta(
        texto: 'Sigo a mi madre o a mi padre a donde quiera que vayan',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'La gente me dice que me veo nervioso(a)',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Me siento nervioso(a) con la gente que no conozco bien',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Me dan dolores de estómago en la escuela',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Cuando me da miedo algo, siento que me estoy volviendo loco(a)',
        opciones: _opcionesScared),
    Pregunta(texto: 'Me preocupa dormir solo(a)', opciones: _opcionesScared),
    Pregunta(
        texto: 'Me preocupa ser tan bueno(a) como otros niños(as)',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Cuando me da miedo algo, siento que las cosas no son reales',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Tengo pesadillas de que algo malo les pasa a mis padres',
        opciones: _opcionesScared),
    Pregunta(texto: 'Me preocupa ir a la escuela', opciones: _opcionesScared),
    Pregunta(
        texto: 'Cuando me da miedo algo, mi corazón late rápido',
        opciones: _opcionesScared),
    Pregunta(texto: 'Me tiembla el cuerpo', opciones: _opcionesScared),
    Pregunta(
        texto: 'Tengo pesadillas de que algo malo me pasa a mí',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Me preocupa que las cosas me salgan bien',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Cuando me da miedo algo, sudo mucho',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Soy una persona que se preocupa', opciones: _opcionesScared),
    Pregunta(
        texto: 'Me da mucho miedo sin razón alguna', opciones: _opcionesScared),
    Pregunta(
        texto: 'Tengo miedo de estar solo(a) en la casa',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Me cuesta hablar con gente nueva', opciones: _opcionesScared),
    Pregunta(
        texto: 'Me preocupan las cosas que me pasan',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Cuando me da miedo algo, siento que me ahogo',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'La gente me dice que me preocupo demasiado',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'No me gusta estar lejos de mi familia',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Tengo miedo de tener ataques de ansiedad (o de pánico)',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Me preocupa que algo malo les pueda pasar a mis padres',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Soy tímido(a) con la gente que no conozco bien',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Me preocupa lo que va a pasar en el futuro',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Cuando me da miedo algo, siento ganas de vomitar',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Me preocupa qué tan bien hago las cosas',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Tengo miedo de ir a la escuela', opciones: _opcionesScared),
    Pregunta(
        texto: 'Me preocupo por cosas que ya han pasado',
        opciones: _opcionesScared),
    Pregunta(
        texto: 'Cuando me da miedo algo, me siento mareado(a)',
        opciones: _opcionesScared),
    Pregunta(
        texto:
            'Me siento nervioso(a) cuando estoy con otros niños o adultos y tengo que hacer algo mientras me observan',
        opciones: _opcionesScared),
    Pregunta(
        texto:
            'Me siento nervioso(a) cuando voy a fiestas, bailes o lugares donde habrá gente que no conozco bien',
        opciones: _opcionesScared),
  ],
  rangos: [
    RangoPuntuacion(
        nivel: 0,
        minimo: 0,
        maximo: 24,
        etiqueta: 'Bajo',
        descripcion: 'Por debajo del punto de corte clínico.'),
    RangoPuntuacion(
        nivel: 1,
        minimo: 25,
        maximo: 40,
        etiqueta: 'Moderado',
        descripcion:
            'La puntuación ≥ 25 sugiere un probable trastorno de ansiedad. Se recomienda evaluación clínica.'),
    RangoPuntuacion(
        nivel: 2,
        minimo: 41,
        maximo: 82,
        etiqueta: 'Alto',
        descripcion:
            'Sintomatología ansiosa alta. Se recomienda valoración clínica.'),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'panico',
      nombre: 'Pánico/somático',
      descripcion: 'Síntomas de pánico y somáticos (0-26).',
      indicesPregunta: [0, 5, 8, 11, 14, 17, 18, 21, 27, 30, 34, 38, 40],
      rangos: [
        RangoPuntuacion(
          nivel: 0,
          minimo: 0,
          maximo: 26,
          etiqueta: 'Descriptivo',
          descripcion: 'Sin puntos de corte normativos publicados.',
          descriptiva: true,
        ),
      ],
    ),
    SubescalaPuntuacion(
      id: 'generalizada',
      nombre: 'Ansiedad generalizada',
      descripcion: 'Preocupación excesiva (0-18).',
      indicesPregunta: [4, 6, 13, 20, 22, 23, 28, 33, 37],
      rangos: [
        RangoPuntuacion(
          nivel: 0,
          minimo: 0,
          maximo: 18,
          etiqueta: 'Descriptivo',
          descripcion: 'Sin puntos de corte normativos publicados.',
          descriptiva: true,
        ),
      ],
    ),
    SubescalaPuntuacion(
      id: 'separacion',
      nombre: 'Ansiedad de separación',
      descripcion: 'Miedo a la separación (0-16).',
      indicesPregunta: [3, 7, 12, 15, 19, 24, 29, 31],
      rangos: [
        RangoPuntuacion(
          nivel: 0,
          minimo: 0,
          maximo: 16,
          etiqueta: 'Descriptivo',
          descripcion: 'Sin puntos de corte normativos publicados.',
          descriptiva: true,
        ),
      ],
    ),
    SubescalaPuntuacion(
      id: 'social',
      nombre: 'Ansiedad social',
      descripcion: 'Miedo en situaciones sociales (0-14).',
      indicesPregunta: [2, 9, 25, 26, 32, 35, 39],
      rangos: [
        RangoPuntuacion(
          nivel: 0,
          minimo: 0,
          maximo: 14,
          etiqueta: 'Descriptivo',
          descripcion: 'Sin puntos de corte normativos publicados.',
          descriptiva: true,
        ),
      ],
    ),
    SubescalaPuntuacion(
      id: 'escolar',
      nombre: 'Fobia escolar',
      descripcion: 'Miedo o evitación de la escuela (0-8).',
      indicesPregunta: [16, 36, 1, 10],
      rangos: [
        RangoPuntuacion(
          nivel: 0,
          minimo: 0,
          maximo: 8,
          etiqueta: 'Descriptivo',
          descripcion: 'Sin puntos de corte normativos publicados.',
          descriptiva: true,
        ),
      ],
    ),
  ],
  nota: 'El SCARED es una herramienta de cribado, no un diagnóstico. '
      'El punto de corte total es ≥ 25. Las subescalas se muestran de forma '
      'descriptiva (sin cortes publicados); la estructura de factores sigue '
      'a Birmaher y colaboradores (1997). Libre uso clínico e '
      'investigación.',
);

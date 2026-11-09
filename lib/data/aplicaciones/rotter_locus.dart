import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Consigna que se repite en cada par de la escala de Rotter.
const String _consignaPar =
    '¿Con cuál de las dos afirmaciones está más de acuerdo?';

/// Escala de Locus de Control de Rotter (1966).
///
/// Consta de 29 pares de afirmaciones en elección forzada; 6 pares son de
/// relleno y no se puntúan. En los 23 pares restantes se otorga 1 punto a la
/// alternativa externa y 0 a la interna, de modo que el total va de 0 a 23 y
/// una puntuación mayor indica mayor externalidad (atribuir los resultados a
/// la suerte, el destino o el poder de otros).
///
/// Los pares de relleno usan valores 0 y 1 solo para que la pantalla de
/// aplicación distinga la alternativa elegida; al estar marcados como
/// `puntuable: false` no suman al total.
const InstrumentoAplicable rotterLocusAplicable = InstrumentoAplicable(
  id: 'rotter-locus',
  sigla: 'Rotter I-E',
  titulo: 'Escala de Locus de Control de Rotter',
  instrucciones: 'Elija de cada par la afirmación con la que esté más de '
      'acuerdo. Si no está de acuerdo con ninguna, elija la que le resulte '
      'menos objetable.',
  preguntas: [
    // 1 · Relleno
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Los niños se meten en problemas porque sus padres '
              'los castigan demasiado',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) El problema con la mayoría de los niños hoy en día '
              'es que sus padres son demasiado permisivos',
          valor: 1,
        ),
      ],
      puntuable: false,
    ),
    // 2
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Muchas de las cosas infelices de la vida de las '
              'personas se deben en parte a la mala suerte',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Las desgracias de las personas son resultado de los '
              'errores que cometen',
          valor: 0,
        ),
      ],
    ),
    // 3
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Una de las principales razones por las que hay '
              'guerras es que las personas no se interesan lo suficiente en '
              'la política',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Siempre habrá guerras, por mucho que las personas '
              'intenten evitarlas',
          valor: 1,
        ),
      ],
    ),
    // 4
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) A la larga, las personas reciben el respeto que '
              'merecen en este mundo',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Por desgracia, el valor de una persona a menudo pasa '
              'desapercibido por mucho que se esfuerce',
          valor: 1,
        ),
      ],
    ),
    // 5
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) La idea de que los profesores son injustos con los '
              'estudiantes es un absurdo',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) La mayoría de los estudiantes no se da cuenta de '
              'hasta qué punto sus calificaciones dependen de hechos '
              'accidentales',
          valor: 1,
        ),
      ],
    ),
    // 6
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Sin las oportunidades adecuadas no se puede ser un '
              'líder eficaz',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Las personas capaces que no llegan a ser líderes no '
              'han aprovechado sus oportunidades',
          valor: 0,
        ),
      ],
    ),
    // 7
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Por mucho que uno se esfuerce, hay personas a las '
              'que simplemente no les caes bien',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Las personas que no logran caer bien a los demás no '
              'saben cómo relacionarse',
          valor: 0,
        ),
      ],
    ),
    // 8 · Relleno
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) La herencia desempeña el papel principal en la '
              'determinación de la personalidad',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Son las experiencias de la vida las que determinan '
              'cómo es una persona',
          valor: 1,
        ),
      ],
      puntuable: false,
    ),
    // 9
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) A menudo he comprobado que lo que tiene que pasar, '
              'pasa',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Confiar en el destino nunca me ha funcionado tan bien '
              'como decidir y tomar un curso de acción definido',
          valor: 0,
        ),
      ],
    ),
    // 10
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) En el caso del estudiante bien preparado, rara vez '
              'existe un examen injusto',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Muchas veces las preguntas de los exámenes no tienen '
              'relación con el curso, así que estudiar resulta realmente '
              'inútil',
          valor: 1,
        ),
      ],
    ),
    // 11
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Tener éxito es cuestión de trabajo duro; la suerte '
              'tiene poco o nada que ver',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Conseguir un buen empleo depende principalmente de '
              'estar en el lugar adecuado en el momento adecuado',
          valor: 1,
        ),
      ],
    ),
    // 12
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) El ciudadano promedio puede influir en las decisiones '
              'del gobierno',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Este mundo lo dirigen unas pocas personas con poder y '
              'el ciudadano de a pie poco puede hacer al respecto',
          valor: 1,
        ),
      ],
    ),
    // 13
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Cuando hago planes, estoy casi seguro de que puedo '
              'llevarlos a cabo',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) No siempre es prudente planificar con tanta '
              'antelación, porque muchas cosas terminan dependiendo de la '
              'buena o mala fortuna',
          valor: 1,
        ),
      ],
    ),
    // 14 · Relleno
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Hay personas que simplemente no tienen nada bueno',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Todo el mundo tiene algo bueno',
          valor: 1,
        ),
      ],
      puntuable: false,
    ),
    // 15
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) En mi caso, conseguir lo que quiero tiene poco o nada '
              'que ver con la suerte',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Muchas veces podríamos decidir qué hacer lanzando una '
              'moneda al aire',
          valor: 1,
        ),
      ],
    ),
    // 16
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Quién llega a ser jefe suele depender de quién tuvo '
              'la suerte de estar primero en el lugar adecuado',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Lograr que las personas hagan lo correcto depende de '
              'la capacidad; la suerte tiene poco o nada que ver',
          valor: 0,
        ),
      ],
    ),
    // 17
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) En lo que respecta a los asuntos mundiales, la '
              'mayoría somos víctimas de fuerzas que no podemos entender ni '
              'controlar',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Participando activamente en la política y en los '
              'asuntos sociales, las personas pueden controlar los '
              'acontecimientos mundiales',
          valor: 0,
        ),
      ],
    ),
    // 18
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) La mayoría de la gente no se da cuenta de hasta qué '
              'punto su vida está controlada por hechos accidentales',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Realmente no existe eso que llamamos «suerte»',
          valor: 0,
        ),
      ],
    ),
    // 19 · Relleno
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Uno siempre debería estar dispuesto a reconocer sus '
              'errores',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Normalmente es mejor ocultar los propios errores',
          valor: 1,
        ),
      ],
      puntuable: false,
    ),
    // 20
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Es difícil saber si una persona te aprecia realmente',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) La cantidad de amigos que tienes depende de lo '
              'agradable que seas',
          valor: 0,
        ),
      ],
    ),
    // 21
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) A la larga, las cosas malas que nos pasan se '
              'compensan con las buenas',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) La mayoría de las desgracias son resultado de la '
              'falta de capacidad, la ignorancia, la pereza o las tres cosas',
          valor: 0,
        ),
      ],
    ),
    // 22
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Con suficiente esfuerzo podemos acabar con la '
              'corrupción política',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Es difícil que las personas tengan mucho control '
              'sobre lo que hacen los políticos en el cargo',
          valor: 1,
        ),
      ],
    ),
    // 23
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) A veces no entiendo cómo los profesores llegan a las '
              'calificaciones que ponen',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Existe una relación directa entre lo mucho que '
              'estudio y las calificaciones que obtengo',
          valor: 0,
        ),
      ],
    ),
    // 24 · Relleno
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Un buen líder espera que las personas decidan por sí '
              'mismas lo que deben hacer',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Un buen líder deja claro a todos cuáles son sus '
              'tareas',
          valor: 1,
        ),
      ],
      puntuable: false,
    ),
    // 25
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Muchas veces siento que tengo poca influencia sobre '
              'las cosas que me pasan',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Me resulta imposible creer que el azar o la suerte '
              'desempeñen un papel importante en mi vida',
          valor: 0,
        ),
      ],
    ),
    // 26
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Las personas están solas porque no intentan ser '
              'amables',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) No vale la pena esforzarse demasiado por agradar a '
              'los demás: si les caes bien, les caes bien',
          valor: 1,
        ),
      ],
    ),
    // 27 · Relleno
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Se da demasiada importancia al deporte en la '
              'enseñanza media',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) Los deportes de equipo son una excelente forma de '
              'formar carácter',
          valor: 1,
        ),
      ],
      puntuable: false,
    ),
    // 28
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) Lo que me pasa es consecuencia de lo que yo hago',
          valor: 0,
        ),
        OpcionRespuesta(
          etiqueta: 'B) A veces siento que no tengo suficiente control sobre '
              'el rumbo que toma mi vida',
          valor: 1,
        ),
      ],
    ),
    // 29
    Pregunta(
      texto: _consignaPar,
      opciones: [
        OpcionRespuesta(
          etiqueta: 'A) La mayoría de las veces no entiendo por qué los '
              'políticos se comportan como se comportan',
          valor: 1,
        ),
        OpcionRespuesta(
          etiqueta: 'B) A la larga, la gente es responsable de un mal '
              'gobierno, tanto a nivel nacional como local',
          valor: 0,
        ),
      ],
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 23,
      etiqueta: 'Descriptivo',
      descripcion: 'Sin puntos de corte normativos publicados: la escala se '
          'interpreta por comparación con normas locales.',
      descriptiva: true,
    ),
  ],
  nota: 'La escala tiene 23 ítems puntuables y 6 de relleno (1, 8, 14, 19, '
      '24 y 27), que se presentan para reducir el sesgo de respuesta y no '
      'suman. Una puntuación mayor indica mayor externalidad; Rotter propuso '
      'interpretar la escala con medianas muestrales, no con puntos de corte '
      'fijos. Uso en investigación con cita de Rotter (1966).',
);

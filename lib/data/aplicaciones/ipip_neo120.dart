import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Escala Likert 1-5 con las anclas originales del IPIP.
const List<OpcionRespuesta> _opcionesLikert = [
  OpcionRespuesta(etiqueta: 'Very inaccurate', valor: 1),
  OpcionRespuesta(etiqueta: 'Moderately inaccurate', valor: 2),
  OpcionRespuesta(etiqueta: 'Neither accurate nor inaccurate', valor: 3),
  OpcionRespuesta(etiqueta: 'Moderately accurate', valor: 4),
  OpcionRespuesta(etiqueta: 'Very accurate', valor: 5),
];

/// Rango descriptivo del total (sin normas publicadas).
const RangoPuntuacion _descriptivoTotal = RangoPuntuacion(
  nivel: 0,
  minimo: 120,
  maximo: 600,
  etiqueta: 'Descriptivo',
  descripcion: 'Sin puntos de corte normativos publicados.',
  descriptiva: true,
);

/// Rango descriptivo de cada faceta (4 ítems, 4-20).
const List<RangoPuntuacion> _descriptivoFaceta = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 4,
    maximo: 20,
    etiqueta: 'Descriptivo',
    descripcion: 'Faceta de 4 ítems (rango 4-20), sin normas publicadas.',
    descriptiva: true,
  ),
];

/// Rango descriptivo de cada dominio (24 ítems, 24-120).
const List<RangoPuntuacion> _descriptivoDominio = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 24,
    maximo: 120,
    etiqueta: 'Descriptivo',
    descripcion: 'Dominio de 24 ítems (rango 24-120), sin normas publicadas.',
    descriptiva: true,
  ),
];

/// IPIP-NEO-120 (Johnson, 2014): 120 ítems en inglés, 30 facetas y 5
/// dominios, de dominio público (ipip.ori.org).
///
/// Los ítems son los originales del IPIP en inglés. Se puntúa en modo
/// descriptivo (sin normas categóricas publicadas).
const InstrumentoAplicable ipipNeo120Aplicable = InstrumentoAplicable(
  id: 'ipip-neo-120',
  sigla: 'IPIP-NEO-120',
  titulo: 'International Personality Item Pool - NEO-120',
  instrucciones: 'Describe yourself as you generally are now, not as you '
      'wish to be in the future. Describe yourself as you honestly see '
      'yourself, in relation to other people you know of the same sex and '
      'roughly your same age. Rate how accurately each statement describes '
      'you.',
  preguntas: [
    // ── Neuroticismo · Extraversión · Apertura · Amabilidad ·
    //    Responsabilidad (ciclos de 5, facetas 1-6) ─────────────
    Pregunta(texto: "Worry about things", opciones: _opcionesLikert),
    Pregunta(texto: "Make friends easily", opciones: _opcionesLikert),
    Pregunta(texto: "Have a vivid imagination", opciones: _opcionesLikert),
    Pregunta(texto: "Trust others", opciones: _opcionesLikert),
    Pregunta(texto: "Complete tasks successfully", opciones: _opcionesLikert),
    Pregunta(texto: "Get angry easily", opciones: _opcionesLikert),
    Pregunta(texto: "Love large parties", opciones: _opcionesLikert),
    Pregunta(
        texto: "Believe in the importance of art", opciones: _opcionesLikert),
    Pregunta(
        texto: "Use others for my own ends",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Like to tidy up", opciones: _opcionesLikert),
    Pregunta(texto: "Often feel blue", opciones: _opcionesLikert),
    Pregunta(texto: "Take charge", opciones: _opcionesLikert),
    Pregunta(
        texto: "Experience my emotions intensely", opciones: _opcionesLikert),
    Pregunta(texto: "Love to help others", opciones: _opcionesLikert),
    Pregunta(texto: "Keep my promises", opciones: _opcionesLikert),
    Pregunta(
        texto: "Find it difficult to approach others", opciones: _opcionesLikert),
    Pregunta(texto: "Am always busy", opciones: _opcionesLikert),
    Pregunta(texto: "Prefer variety to routine", opciones: _opcionesLikert),
    Pregunta(
        texto: "Love a good fight", opciones: _opcionesLikert, invertida: true),
    Pregunta(texto: "Work hard", opciones: _opcionesLikert),
    Pregunta(texto: "Go on binges", opciones: _opcionesLikert),
    Pregunta(texto: "Love excitement", opciones: _opcionesLikert),
    Pregunta(
        texto: "Love to read challenging material", opciones: _opcionesLikert),
    Pregunta(
        texto: "Believe that I am better than others",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Am always prepared", opciones: _opcionesLikert),
    Pregunta(texto: "Panic easily", opciones: _opcionesLikert),
    Pregunta(texto: "Radiate joy", opciones: _opcionesLikert),
    Pregunta(
        texto: "Tend to vote for liberal political candidates",
        opciones: _opcionesLikert),
    Pregunta(texto: "Sympathize with the homeless", opciones: _opcionesLikert),
    Pregunta(
        texto: "Jump into things without thinking",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Fear for the worst", opciones: _opcionesLikert),
    Pregunta(
        texto: "Feel comfortable around people", opciones: _opcionesLikert),
    Pregunta(
        texto: "Enjoy wild flights of fantasy", opciones: _opcionesLikert),
    Pregunta(
        texto: "Believe that others have good intentions",
        opciones: _opcionesLikert),
    Pregunta(texto: "Excel in what I do", opciones: _opcionesLikert),
    Pregunta(texto: "Get irritated easily", opciones: _opcionesLikert),
    Pregunta(
        texto: "Talk to a lot of different people at parties",
        opciones: _opcionesLikert),
    Pregunta(
        texto: "See beauty in things that others might not notice",
        opciones: _opcionesLikert),
    Pregunta(
        texto: "Cheat to get ahead", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Often forget to put things back in their proper place",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Dislike myself", opciones: _opcionesLikert),
    Pregunta(texto: "Try to lead others", opciones: _opcionesLikert),
    Pregunta(texto: "Feel others' emotions", opciones: _opcionesLikert),
    Pregunta(texto: "Am concerned about others", opciones: _opcionesLikert),
    Pregunta(texto: "Tell the truth", opciones: _opcionesLikert),
    Pregunta(
        texto: "Am afraid to draw attention to myself", opciones: _opcionesLikert),
    Pregunta(texto: "Am always on the go", opciones: _opcionesLikert),
    Pregunta(
        texto: "Prefer to stick with things that I know",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Yell at people", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Do more than what's expected of me", opciones: _opcionesLikert),
    Pregunta(
        texto: "Rarely overindulge",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Seek adventure", opciones: _opcionesLikert),
    Pregunta(
        texto: "Avoid philosophical discussions",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Think highly of myself",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Carry out my plans", opciones: _opcionesLikert),
    Pregunta(
        texto: "Become overwhelmed by events", opciones: _opcionesLikert),
    Pregunta(texto: "Have a lot of fun", opciones: _opcionesLikert),
    Pregunta(
        texto: "Believe that there is no absolute right or wrong",
        opciones: _opcionesLikert),
    Pregunta(
        texto: "Feel sympathy for those who are worse off than myself",
        opciones: _opcionesLikert),
    Pregunta(
        texto: "Make rash decisions",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Am afraid of many things", opciones: _opcionesLikert),
    Pregunta(
        texto: "Avoid contacts with others",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Love to daydream", opciones: _opcionesLikert),
    Pregunta(texto: "Trust what people say", opciones: _opcionesLikert),
    Pregunta(texto: "Handle tasks smoothly", opciones: _opcionesLikert),
    Pregunta(texto: "Lose my temper", opciones: _opcionesLikert),
    Pregunta(
        texto: "Prefer to be alone", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Do not like poetry",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Take advantage of others",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Leave a mess in my room",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Am often down in the dumps", opciones: _opcionesLikert),
    Pregunta(texto: "Take control of things", opciones: _opcionesLikert),
    Pregunta(
        texto: "Rarely notice my emotional reactions",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Am indifferent to the feelings of others",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Break rules", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Only feel comfortable with friends", opciones: _opcionesLikert),
    Pregunta(texto: "Do a lot in my spare time", opciones: _opcionesLikert),
    Pregunta(
        texto: "Dislike changes", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Insult people", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Do just enough work to get by",
        opciones: _opcionesLikert,
        invertida: true),

    Pregunta(
        texto: "Easily resist temptations",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Enjoy being reckless", opciones: _opcionesLikert),
    Pregunta(
        texto: "Have difficulty understanding abstract ideas",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Have a high opinion of myself",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Waste my time", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Feel that I'm unable to deal with things",
        opciones: _opcionesLikert),
    Pregunta(texto: "Love life", opciones: _opcionesLikert),
    Pregunta(
        texto: "Tend to vote for conservative political candidates",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Am not interested in other people's problems",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Rush into things", opciones: _opcionesLikert, invertida: true),
    Pregunta(texto: "Get stressed out easily", opciones: _opcionesLikert),
    Pregunta(
        texto: "Keep others at a distance",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Like to get lost in thought", opciones: _opcionesLikert),
    Pregunta(
        texto: "Distrust people", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Know how to get things done", opciones: _opcionesLikert),
    Pregunta(
        texto: "Am not easily annoyed",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Avoid crowds", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Do not enjoy going to art museums",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Obstruct others' plans",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Leave my belongings around",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Feel comfortable with myself",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Wait for others to lead the way",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Don't understand people who get emotional",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Take no time for others",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Break my promises", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Am not bothered by difficult social situations",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Like to take it easy",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Am attached to conventional ways",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Get back at others", opciones: _opcionesLikert, invertida: true),
    Pregunta(
        texto: "Put little time and effort into my work",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Am able to control my cravings",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(texto: "Act wild and crazy", opciones: _opcionesLikert),
    Pregunta(
        texto: "Am not interested in theoretical discussions",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Boast about my virtues",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Have difficulty starting tasks",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Remain calm under pressure",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Look at the bright side of life", opciones: _opcionesLikert),
    Pregunta(
        texto: "Believe that we should be tough on crime",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Try not to think about the needy",
        opciones: _opcionesLikert,
        invertida: true),
    Pregunta(
        texto: "Act without thinking",
        opciones: _opcionesLikert,
        invertida: true),
  ],
  rangos: [_descriptivoTotal],
  mostrarPuntuacionTotal: false,

  subescalas: [
    // ── Facetas de Neuroticismo ─────────────────────────────────
    SubescalaPuntuacion(
      id: 'n1',
      nombre: 'Ansiedad',
      descripcion: 'Tendencia a preocuparse y sentir tensión.',
      indicesPregunta: [0, 30, 60, 90],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'n2',
      nombre: 'Ira',
      descripcion: 'Facilidad para irritarse y enojarse.',
      indicesPregunta: [5, 35, 65, 95],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'n3',
      nombre: 'Depresión',
      descripcion: 'Tendencia a sentirse triste o desanimado.',
      indicesPregunta: [10, 40, 70, 100],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'n4',
      nombre: 'Autoconciencia',
      descripcion: 'Timidez e incomodidad en situaciones sociales.',
      indicesPregunta: [15, 45, 75, 105],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'n5',
      nombre: 'Inmoderación',
      descripcion: 'Dificultad para controlar impulsos y deseos.',
      indicesPregunta: [20, 50, 80, 110],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'n6',
      nombre: 'Vulnerabilidad',
      descripcion: 'Sensibilidad al estrés y baja tolerancia a la presión.',
      indicesPregunta: [25, 55, 85, 115],
      rangos: _descriptivoFaceta,
    ),
    // ── Facetas de Extraversión ─────────────────────────────────
    SubescalaPuntuacion(
      id: 'e1',
      nombre: 'Cordialidad',
      descripcion: 'Calidez e interés genuino por los demás.',
      indicesPregunta: [1, 31, 61, 91],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'e2',
      nombre: 'Gregarismo',
      descripcion: 'Disfrute de la compañía y las reuniones.',
      indicesPregunta: [6, 36, 66, 96],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'e3',
      nombre: 'Asertividad',
      descripcion: 'Iniciativa y dominio en situaciones sociales.',
      indicesPregunta: [11, 41, 71, 101],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'e4',
      nombre: 'Nivel de actividad',
      descripcion: 'Energía y ritmo de vida activo.',
      indicesPregunta: [16, 46, 76, 106],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'e5',
      nombre: 'Búsqueda de emociones',
      descripcion: 'Necesidad de estímulo, novedad y emoción.',
      indicesPregunta: [21, 51, 81, 111],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'e6',
      nombre: 'Alegría',
      descripcion: 'Emocionalidad positiva y entusiasmo.',
      indicesPregunta: [26, 56, 86, 116],
      rangos: _descriptivoFaceta,
    ),

    // ── Facetas de Apertura a la experiencia ─────────────────────
    SubescalaPuntuacion(
      id: 'o1',
      nombre: 'Imaginación',
      descripcion: 'Vida interior rica y fantasía.',
      indicesPregunta: [2, 32, 62, 92],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'o2',
      nombre: 'Interés artístico',
      descripcion: 'Aprecio por la estética y el arte.',
      indicesPregunta: [7, 37, 67, 97],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'o3',
      nombre: 'Emotividad',
      descripcion: 'Intensidad con que se viven las emociones.',
      indicesPregunta: [12, 42, 72, 102],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'o4',
      nombre: 'Audacia',
      descripcion: 'Apertura a la novedad y la variedad.',
      indicesPregunta: [17, 47, 77, 107],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'o5',
      nombre: 'Intelecto',
      descripcion: 'Interés por ideas y conceptos abstractos.',
      indicesPregunta: [22, 52, 82, 112],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'o6',
      nombre: 'Liberalismo',
      descripcion: 'Actitud abierta frente a valores y cambios.',
      indicesPregunta: [27, 57, 87, 117],
      rangos: _descriptivoFaceta,
    ),
    // ── Facetas de Amabilidad ────────────────────────────────────
    SubescalaPuntuacion(
      id: 'a1',
      nombre: 'Confianza',
      descripcion: 'Asumir buenas intenciones en los demás.',
      indicesPregunta: [3, 33, 63, 93],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'a2',
      nombre: 'Moralidad',
      descripcion: 'Honestidad y rechazo a manipular a otros.',
      indicesPregunta: [8, 38, 68, 98],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'a3',
      nombre: 'Altruismo',
      descripcion: 'Preocupación genuina por ayudar.',
      indicesPregunta: [13, 43, 73, 103],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'a4',
      nombre: 'Cooperación',
      descripcion: 'Evitar el conflicto y cooperar con otros.',
      indicesPregunta: [18, 48, 78, 108],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'a5',
      nombre: 'Modestia',
      descripcion: 'Humildad y ausencia de protagonismo.',
      indicesPregunta: [23, 53, 83, 113],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'a6',
      nombre: 'Compasión',
      descripcion: 'Empatía con el sufrimiento ajeno.',
      indicesPregunta: [28, 58, 88, 118],
      rangos: _descriptivoFaceta,
    ),

    // ── Facetas de Responsabilidad ───────────────────────────────
    SubescalaPuntuacion(
      id: 'c1',
      nombre: 'Autoeficacia',
      descripcion: 'Confianza en la propia capacidad para lograr cosas.',
      indicesPregunta: [4, 34, 64, 94],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'c2',
      nombre: 'Orden',
      descripcion: 'Limpieza y organización.',
      indicesPregunta: [9, 39, 69, 99],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'c3',
      nombre: 'Sentido del deber',
      descripcion: 'Cumplimiento de reglas y compromisos.',
      indicesPregunta: [14, 44, 74, 104],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'c4',
      nombre: 'Logro',
      descripcion: 'Esfuerzo orientado a metas y resultados.',
      indicesPregunta: [19, 49, 79, 109],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'c5',
      nombre: 'Autodisciplina',
      descripcion: 'Iniciar y terminar tareas sin dilación.',
      indicesPregunta: [24, 54, 84, 114],
      rangos: _descriptivoFaceta,
    ),
    SubescalaPuntuacion(
      id: 'c6',
      nombre: 'Prudencia',
      descripcion: 'Reflexión antes de actuar.',
      indicesPregunta: [29, 59, 89, 119],
      rangos: _descriptivoFaceta,
    ),
    // ── Dominios (5) ─────────────────────────────────────────────
    SubescalaPuntuacion(
      id: 'neuroticismo',
      nombre: 'Neuroticismo',
      descripcion: 'Tendencia a experimentar emociones negativas '
          '(6 facetas, 24 ítems).',
      indicesPregunta: [
        0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85,
        90, 95, 100, 105, 110, 115,
      ],
      rangos: _descriptivoDominio,
    ),
    SubescalaPuntuacion(
      id: 'extraversion',
      nombre: 'Extraversión',
      descripcion: 'Energía dirigida al mundo social (6 facetas, 24 ítems).',
      indicesPregunta: [
        1, 6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61, 66, 71, 76, 81, 86,
        91, 96, 101, 106, 111, 116,
      ],
      rangos: _descriptivoDominio,
    ),
    SubescalaPuntuacion(
      id: 'apertura',
      nombre: 'Apertura a la experiencia',
      descripcion: 'Curiosidad intelectual y estética (6 facetas, 24 ítems).',
      indicesPregunta: [
        2, 7, 12, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62, 67, 72, 77, 82, 87,
        92, 97, 102, 107, 112, 117,
      ],
      rangos: _descriptivoDominio,
    ),
    SubescalaPuntuacion(
      id: 'amabilidad',
      nombre: 'Amabilidad',
      descripcion: 'Orientación prosocial y cooperativa (6 facetas, 24 ítems).',
      indicesPregunta: [
        3, 8, 13, 18, 23, 28, 33, 38, 43, 48, 53, 58, 63, 68, 73, 78, 83, 88,
        93, 98, 103, 108, 113, 118,
      ],
      rangos: _descriptivoDominio,
    ),
    SubescalaPuntuacion(
      id: 'responsabilidad',
      nombre: 'Responsabilidad',
      descripcion: 'Organización, disciplina y logro (6 facetas, 24 ítems).',
      indicesPregunta: [
        4, 9, 14, 19, 24, 29, 34, 39, 44, 49, 54, 59, 64, 69, 74, 79, 84, 89,
        94, 99, 104, 109, 114, 119,
      ],
      rangos: _descriptivoDominio,
    ),
  ],
  nota: 'Ítems originales del IPIP (International Personality Item Pool), '
      'dominio público (ipip.ori.org). Instrumento en inglés, 4 ítems por '
      'faceta (Johnson, 2014). Sin normas categóricas publicadas: se muestra '
      'en modo descriptivo. Para uso clínico en español se recomienda una '
      'adaptación validada.',
);


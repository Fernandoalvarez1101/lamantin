import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del BFI-44 (acuerdo 1-5).
const List<OpcionRespuesta> _opcionesBfi = [
  OpcionRespuesta(etiqueta: 'Muy en desacuerdo', valor: 1),
  OpcionRespuesta(etiqueta: 'En desacuerdo', valor: 2),
  OpcionRespuesta(etiqueta: 'Ni de acuerdo ni en desacuerdo', valor: 3),
  OpcionRespuesta(etiqueta: 'De acuerdo', valor: 4),
  OpcionRespuesta(etiqueta: 'Muy de acuerdo', valor: 5),
];

/// BFI-44: Big Five Inventory (John, Donahue y Kentle, 1991).
///
/// Mide los cinco grandes factores de la personalidad. Cada factor se
/// puntúa por la suma de sus ítems (algunos de forma invertida).
const InstrumentoAplicable bfi44Aplicable = InstrumentoAplicable(
  id: 'bfi-44',
  sigla: 'BFI-44',
  titulo: 'Inventario de los Cinco Grandes (Big Five Inventory)',
  instrucciones: 'Indique en qué medida cada afirmación le describe.',
  preguntas: [
    Pregunta(texto: 'Es hablador(a)', opciones: _opcionesBfi),
    Pregunta(
        texto: 'Tiende a encontrar defectos en los demás',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(texto: 'Hace un trabajo minucioso', opciones: _opcionesBfi),
    Pregunta(texto: 'Es deprimido(a), melancólico(a)', opciones: _opcionesBfi),
    Pregunta(texto: 'Es original, tiene ideas nuevas', opciones: _opcionesBfi),
    Pregunta(texto: 'Es reservado(a)', opciones: _opcionesBfi, invertida: true),
    Pregunta(
        texto: 'Es servicial y desinteresado(a) con los demás',
        opciones: _opcionesBfi),
    Pregunta(
        texto: 'Puede ser algo descuidado(a)',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(
        texto: 'Es relajado(a), maneja bien el estrés',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(
        texto: 'Es curioso(a) acerca de muchos temas diferentes',
        opciones: _opcionesBfi),
    Pregunta(texto: 'Está lleno(a) de energía', opciones: _opcionesBfi),
    Pregunta(
        texto: 'Inicia peleas con los demás',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(texto: 'Es un trabajador(a) de confianza', opciones: _opcionesBfi),
    Pregunta(texto: 'Puede estar tenso(a)', opciones: _opcionesBfi),
    Pregunta(
        texto: 'Es ingenioso(a), piensa profundamente', opciones: _opcionesBfi),
    Pregunta(texto: 'Genera mucho entusiasmo', opciones: _opcionesBfi),
    Pregunta(texto: 'Tiene una naturaleza indulgente', opciones: _opcionesBfi),
    Pregunta(
        texto: 'Tiende a ser desorganizado(a)',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(texto: 'Se preocupa mucho', opciones: _opcionesBfi),
    Pregunta(texto: 'Tiene una imaginación activa', opciones: _opcionesBfi),
    Pregunta(
        texto: 'Tiende a ser callado(a)',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(texto: 'Generalmente es confiado(a)', opciones: _opcionesBfi),
    Pregunta(
        texto: 'Tiende a ser perezoso(a)',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(
        texto: 'Es emocionalmente estable, no se altera fácilmente',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(texto: 'Es inventivo(a)', opciones: _opcionesBfi),
    Pregunta(texto: 'Tiene una personalidad asertiva', opciones: _opcionesBfi),
    Pregunta(
        texto: 'Puede ser frío(a) y distante',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(
        texto: 'Persevera hasta terminar la tarea', opciones: _opcionesBfi),
    Pregunta(texto: 'Puede ser temperamental', opciones: _opcionesBfi),
    Pregunta(texto: 'Aprecia lo artístico y lo bello', opciones: _opcionesBfi),
    Pregunta(
        texto: 'A veces es tímido(a), inhibido(a)',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(
        texto: 'Es considerado(a) y amable con casi todos',
        opciones: _opcionesBfi),
    Pregunta(texto: 'Hace las cosas con eficiencia', opciones: _opcionesBfi),
    Pregunta(
        texto: 'Se mantiene tranquilo(a) en situaciones tensas',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(
        texto: 'Prefiere el trabajo rutinario',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(texto: 'Es extrovertido(a), sociable', opciones: _opcionesBfi),
    Pregunta(
        texto: 'A veces es grosero(a) con los demás',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(texto: 'Hace planes y los sigue', opciones: _opcionesBfi),
    Pregunta(texto: 'Se pone nervioso(a) fácilmente', opciones: _opcionesBfi),
    Pregunta(
        texto: 'Le gusta reflexionar y jugar con las ideas',
        opciones: _opcionesBfi),
    Pregunta(
        texto: 'Tiene pocos intereses artísticos',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(texto: 'Le gusta cooperar con los demás', opciones: _opcionesBfi),
    Pregunta(
        texto: 'Se distrae fácilmente',
        opciones: _opcionesBfi,
        invertida: true),
    Pregunta(
        texto: 'Es sofisticado(a) en el arte, la música o la literatura',
        opciones: _opcionesBfi),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 44,
      maximo: 220,
      etiqueta: 'Ver factores',
      descripcion: 'Este instrumento se interpreta por factores.',
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'extraversion',
      nombre: 'Extraversión',
      descripcion: 'Sociabilidad, energía y asertividad (8 ítems, rango 8-40).',
      indicesPregunta: [0, 5, 10, 15, 20, 25, 30, 35],
      rangos: [
        RangoPuntuacion(
          nivel: 0,
          minimo: 8,
          maximo: 40,
          etiqueta: 'Descriptivo',
          descripcion: 'Sin puntos de corte normativos publicados.',
          descriptiva: true,
        ),
      ],
    ),
    SubescalaPuntuacion(
      id: 'amabilidad',
      nombre: 'Amabilidad',
      descripcion: 'Confianza, altruismo y cooperación (9 ítems, rango 9-45).',
      indicesPregunta: [1, 6, 11, 16, 21, 26, 31, 36, 41],
      rangos: [
        RangoPuntuacion(
          nivel: 0,
          minimo: 9,
          maximo: 45,
          etiqueta: 'Descriptivo',
          descripcion: 'Sin puntos de corte normativos publicados.',
          descriptiva: true,
        ),
      ],
    ),
    SubescalaPuntuacion(
      id: 'responsabilidad',
      nombre: 'Responsabilidad',
      descripcion: 'Orden, perseverancia y motivación de logro (9 ítems, '
          'rango 9-45).',
      indicesPregunta: [2, 7, 12, 17, 22, 27, 32, 37, 42],
      rangos: [
        RangoPuntuacion(
          nivel: 0,
          minimo: 9,
          maximo: 45,
          etiqueta: 'Descriptivo',
          descripcion: 'Sin puntos de corte normativos publicados.',
          descriptiva: true,
        ),
      ],
    ),
    SubescalaPuntuacion(
      id: 'neuroticismo',
      nombre: 'Neuroticismo',
      descripcion: 'Tendencia a emociones negativas (8 ítems, rango 8-40).',
      indicesPregunta: [3, 8, 13, 18, 23, 28, 33, 38],
      rangos: [
        RangoPuntuacion(
          nivel: 0,
          minimo: 8,
          maximo: 40,
          etiqueta: 'Descriptivo',
          descripcion: 'Sin puntos de corte normativos publicados.',
          descriptiva: true,
        ),
      ],
    ),
    SubescalaPuntuacion(
      id: 'apertura',
      nombre: 'Apertura a la experiencia',
      descripcion: 'Curiosidad, imaginación y creatividad (10 ítems, rango '
          '10-50).',
      indicesPregunta: [4, 9, 14, 19, 24, 29, 34, 39, 40, 43],
      rangos: [
        RangoPuntuacion(
          nivel: 0,
          minimo: 10,
          maximo: 50,
          etiqueta: 'Descriptivo',
          descripcion: 'Sin puntos de corte normativos publicados.',
          descriptiva: true,
        ),
      ],
    ),
  ],
  mostrarPuntuacionTotal: false,
  nota: 'El BFI-44 mide rasgos disposicionales de la personalidad, NO es un '
      'instrumento diagnóstico. No existen puntos de corte publicados por '
      'sus autores; el instrumento se interpreta por comparación con '
      'distribuciones normativas, no por posición en el rango teórico. '
      'Un autoinforme único no establece un perfil estable: se requieren '
      'múltiples fuentes y tiempo para caracterizar la personalidad. '
      'Los puntajes se muestran como bruto, rango de escala y media por '
      'ítem, sin etiqueta categórica. Libre uso no comercial.',
);

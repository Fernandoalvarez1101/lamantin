import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del IUS-12 (1-5).
const List<OpcionRespuesta> _opcionesIus = [
  OpcionRespuesta(etiqueta: 'Nada característica de mí', valor: 1),
  OpcionRespuesta(etiqueta: 'Algo característica de mí', valor: 2),
  OpcionRespuesta(etiqueta: 'Moderadamente característica de mí', valor: 3),
  OpcionRespuesta(etiqueta: 'Muy característica de mí', valor: 4),
  OpcionRespuesta(etiqueta: 'Totalmente característica de mí', valor: 5),
];

/// Bandas descriptivas de la ansiedad prospectiva (7-35).
const List<RangoPuntuacion> _bandasProspectiva = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 7,
    maximo: 35,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte normativos publicados.',
    descriptiva: true,
  ),
];

/// Bandas descriptivas de la ansiedad inhibitoria (5-25).
const List<RangoPuntuacion> _bandasInhibitoria = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 5,
    maximo: 25,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte normativos publicados.',
    descriptiva: true,
  ),
];

/// IUS-12: Escala de Intolerancia a la Incertidumbre, versión abreviada
/// (Carleton, Norton y Asmundson, 2007).
///
/// Mide la incapacidad de tolerar situaciones ambiguas o impredecibles con
/// dos subescalas: ansiedad prospectiva (7 ítems) y ansiedad inhibitoria
/// (5 ítems). Rango total de 12 a 60; a mayor puntuación, mayor intolerancia.
const InstrumentoAplicable ius12Aplicable = InstrumentoAplicable(
  id: 'ius-12',
  sigla: 'IUS-12',
  titulo: 'Escala de Intolerancia a la Incertidumbre (versión abreviada)',
  instrucciones: 'Indique en qué medida cada afirmación es característica '
      'de usted.',
  preguntas: [
    Pregunta(
      texto: 'Los acontecimientos imprevistos me alteran enormemente',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto: 'Me frustra no tener toda la información que necesito',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto: 'La incertidumbre me impide disfrutar plenamente de la vida',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto:
          'Uno debería mirar siempre hacia delante para evitar las sorpresas',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto: 'Un pequeño acontecimiento imprevisto puede echarlo todo a '
          'perder, incluso con la mejor planificación',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto: 'Cuando llega el momento de actuar, la incertidumbre me paraliza',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto: 'Cuando tengo incertidumbre no funciono bien',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto: 'Siempre quiero saber qué me depara el futuro',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto: 'No soporto que me tomen por sorpresa',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto: 'La más mínima duda puede impedirme actuar',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto: 'Debería ser capaz de organizarlo todo con antelación',
      opciones: _opcionesIus,
    ),
    Pregunta(
      texto: 'Debo alejarme de todas las situaciones inciertas',
      opciones: _opcionesIus,
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 12,
      maximo: 60,
      etiqueta: 'Descriptivo',
      descripcion: 'Sin puntos de corte clínicos publicados para la escala '
          'total.',
      descriptiva: true,
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'prospectiva',
      nombre: 'Ansiedad prospectiva',
      descripcion: 'Expectativas negativas ante eventos futuros inciertos.',
      indicesPregunta: [0, 1, 3, 4, 7, 8, 10],
      rangos: _bandasProspectiva,
    ),
    SubescalaPuntuacion(
      id: 'inhibitoria',
      nombre: 'Ansiedad inhibitoria',
      descripcion: 'Parálisis de la acción cuando la situación es ambigua.',
      indicesPregunta: [2, 5, 6, 9, 11],
      rangos: _bandasInhibitoria,
    ),
  ],
  nota: 'El IUS-12 es una medida descriptiva de la intolerancia a la '
      'incertidumbre; no dispone de puntos de corte clínicos validados, por '
      'lo que se interpreta por comparación con normas locales. La versión '
      'en español reporta un alfa de Cronbach de .85. Libre uso en '
      'investigación con cita de los autores.',
);

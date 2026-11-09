import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de la hoja de puntuación: el profesional traslada del informe
/// oficial si la escala alcanza el corte convencional T ≥ 65.
const List<OpcionRespuesta> _opcionesElevacion = [
  OpcionRespuesta(etiqueta: 'No (T < 65)', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí (T ≥ 65)', valor: 1),
];

/// Bandas de cada escala: sin elevación (0) o elevación clínica (1).
const List<RangoPuntuacion> _bandasEscala = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 0,
    maximo: 0,
    etiqueta: 'Sin elevación',
    descripcion: 'La escala no alcanza el corte convencional T ≥ 65.',
  ),
  RangoPuntuacion(
    nivel: 4,
    minimo: 1,
    maximo: 1,
    etiqueta: 'Elevación clínica',
    descripcion: 'Puntuación T ≥ 65: contrastar con el informe oficial y con '
        'el manual antes de interpretar.',
  ),
];

/// MMPI-2: Inventario Multifásico de Personalidad de Minnesota-2
/// (Hathaway y McKinley, University of Minnesota Press, 1989).
///
/// **Hoja de puntuación**, no el instrumento completo: los 567 ítems son
/// propietarios y no se reproducen. El profesional administra la prueba con
/// el material oficial (cuadernillo, plantillas o plataforma licenciada) y
/// aquí registra, escala por escala, si la puntuación T alcanza el corte
/// convencional de 65.
///
/// Cubre las 4 escalas de validez que condicionan la interpretación (L, F, K
/// y la pareja VRIN/TRIN) y las 10 escalas clínicas básicas del perfil
/// estándar. Cada escala es una subescala con su propia banda.
const InstrumentoAplicable mmpi2Aplicable = InstrumentoAplicable(
  id: 'mmpi-2',
  sigla: 'MMPI-2',
  titulo: 'Inventario Multifásico de Personalidad de Minnesota-2 '
      '(hoja de puntuación)',
  instrucciones: 'HOJA DE PUNTUACIÓN ADMINISTRADA POR EL PROFESIONAL. Aplique '
      'el MMPI-2 con el material oficial y su licencia vigente; después '
      'traslade aquí, desde el informe oficial, si cada escala alcanza el '
      'corte convencional T ≥ 65. Lamantin no reproduce los 567 ítems ni '
      'calcula puntuaciones T.',
  preguntas: [
    // ── Escalas de validez ────────────────────────────────────────
    Pregunta(
      texto: 'Escala L (Mentira): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Escala F (Infrecuencia): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Escala K (Corrección): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Escalas VRIN y TRIN: ¿alguna puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    // ── Escalas clínicas básicas ──────────────────────────────────
    Pregunta(
      texto: 'Hs (Hipocondría): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'D (Depresión): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Hy (Histeria): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Pd (Desviación psicopática): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Mf (Masculinidad-Feminidad): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Pa (Paranoia): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Pt (Psicastenia): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Sc (Esquizofrenia): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Ma (Hipomanía): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
    Pregunta(
      texto: 'Si (Introversión social): ¿la puntuación T es ≥ 65?',
      opciones: _opcionesElevacion,
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 14,
      etiqueta: 'Ver subescalas',
      descripcion: 'El perfil se interpreta escala por escala: cada escala se '
          'marca como elevada cuando T ≥ 65.',
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'validez-l',
      nombre: 'L · Mentira',
      descripcion: 'Mide la tendencia a presentarse de forma socialmente '
          'deseable, negando faltas menores.',
      indicesPregunta: [0],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'validez-f',
      nombre: 'F · Infrecuencia',
      descripcion: 'Reúne respuestas poco frecuentes en la población; puede '
          'reflejar exageración de síntomas, confusión o un estilo de '
          'respuesta atípico.',
      indicesPregunta: [1],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'validez-k',
      nombre: 'K · Corrección',
      descripcion: 'Mide defensividad ante la evaluación; se usa además para '
          'corregir algunas escalas clínicas.',
      indicesPregunta: [2],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'validez-vrin-trin',
      nombre: 'VRIN / TRIN · Inconsistencia',
      descripcion: 'Detecta respuestas contestadas al azar (VRIN) y la '
          'tendencia a responder verdadero o falso de forma indiscriminada '
          '(TRIN).',
      indicesPregunta: [3],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'clinica-hs',
      nombre: 'Hs · Hipocondría',
      descripcion: 'Preocupación excesiva por el funcionamiento corporal y '
          'quejas somáticas.',
      indicesPregunta: [4],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'clinica-d',
      nombre: 'D · Depresión',
      descripcion: 'Estado de ánimo disfórico, desánimo, falta de energía y '
          'pesimismo.',
      indicesPregunta: [5],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'clinica-hy',
      nombre: 'Hy · Histeria',
      descripcion: 'Uso de mecanismos de conversión y negación frente al '
          'malestar; búsqueda de atención y apoyo.',
      indicesPregunta: [6],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'clinica-pd',
      nombre: 'Pd · Desviación psicopática',
      descripcion: 'Dificultades con las normas sociales, impulsividad y '
          'conflictos familiares o laborales.',
      indicesPregunta: [7],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'clinica-mf',
      nombre: 'Mf · Masculinidad-Feminidad',
      descripcion: 'Intereses y actitudes de rol de género. Se interpreta de '
          'forma bipolar: una T alta no indica por sí sola psicopatología.',
      indicesPregunta: [8],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'clinica-pa',
      nombre: 'Pa · Paranoia',
      descripcion: 'Suspicacia, hipersensibilidad interpersonal y tendencia a '
          'atribuir el malestar a factores externos.',
      indicesPregunta: [9],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'clinica-pt',
      nombre: 'Pt · Psicastenia',
      descripcion: 'Ansiedad, tensión, dudas repetidas y rasgos '
          'obsesivo-compulsivos.',
      indicesPregunta: [10],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'clinica-sc',
      nombre: 'Sc · Esquizofrenia',
      descripcion: 'Experiencias inusuales, alienación social y '
          'desorganización del pensamiento.',
      indicesPregunta: [11],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'clinica-ma',
      nombre: 'Ma · Hipomanía',
      descripcion: 'Activación, expansividad, energía elevada y baja '
          'tolerancia a la frustración.',
      indicesPregunta: [12],
      rangos: _bandasEscala,
    ),
    SubescalaPuntuacion(
      id: 'clinica-si',
      nombre: 'Si · Introversión social',
      descripcion: 'Retraimiento social y malestar en situaciones grupales. '
          'Se interpreta de forma bipolar.',
      indicesPregunta: [13],
      rangos: _bandasEscala,
    ),
  ],
  alertas: [
    AlertaPregunta(
      numeroPregunta: 2,
      valorMinimo: 1,
      mensaje: 'Escala F elevada (T ≥ 65): respuestas infrecuentes que pueden '
          'reflejar exageración de síntomas, confusión o un estilo de '
          'respuesta atípico. Confirme la validez del protocolo antes de '
          'interpretar el perfil.',
    ),
    AlertaPregunta(
      numeroPregunta: 4,
      valorMinimo: 1,
      mensaje: 'Inconsistencia en las respuestas (VRIN/TRIN ≥ 65): la validez '
          'del protocolo es dudosa, así que el perfil no debe interpretarse '
          'hasta revisarlo con el informe oficial.',
    ),
  ],
  mostrarPuntuacionTotal: false,
  nota: 'Sólo puede aplicarlo personal con la licencia vigente del editor '
      '(Pearson / University of Minnesota Press); el MMPI-2 no es un '
      'instrumento de uso libre. Lamantin no reproduce los 567 ítems ni la '
      'totalidad de las escalas: registra únicamente la hoja de puntuación con '
      'el corte convencional T ≥ 65, que no sustituye el informe oficial ni '
      'el juicio clínico. Existen otras formas (MMPI-2-RF, 338 ítems; MMPI-A, '
      'para adolescentes) con sus propios baremos.',
);

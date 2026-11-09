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

/// Grupo del perfil al que pertenece cada escala.
enum _GrupoEscala {
  validez('Validez'),
  clinica('Clínicas básicas'),
  restructurada('Restructuradas (RC)'),
  psy5('PSY-5'),
  contenido('Contenido'),
  suplementaria('Suplementarias');

  const _GrupoEscala(this.titulo);

  /// Nombre visible del grupo de escalas.
  final String titulo;
}

/// Escala del MMPI-2 que se registra en la hoja de puntuación.
class _EscalaMmpi {
  const _EscalaMmpi(this.sigla, this.nombre, this.grupo, this.descripcion);

  /// Sigla oficial de la escala (p. ej. «Hs»).
  final String sigla;

  /// Nombre de la escala en español.
  final String nombre;

  /// Grupo del perfil al que pertenece.
  final _GrupoEscala grupo;

  /// Qué mide la escala y cómo se lee una T alta.
  final String descripcion;

  /// Etiqueta visible, p. ej. «Hs · Hipocondría».
  String get etiqueta => '$sigla · $nombre';
}

/// Escalas de validez: condicionan si el perfil puede interpretarse.
const List<_EscalaMmpi> _escalasValidez = [
  _EscalaMmpi(
    'L',
    'Mentira',
    _GrupoEscala.validez,
    'Presentación excesivamente favorable: se niegan faltas comunes. Una T '
        'alta sugiere deseabilidad social y puede invalidar el protocolo.',
  ),
  _EscalaMmpi(
    'F',
    'Infrecuencia',
    _GrupoEscala.validez,
    'Respuestas poco frecuentes en la población general; refleja un estilo '
        'de respuesta atípico, exageración de síntomas o confusión.',
  ),
  _EscalaMmpi(
    'K',
    'Corrección',
    _GrupoEscala.validez,
    'Recursos de afrontamiento y defensividad; también corrige otras '
        'escalas clínicas.',
  ),
  _EscalaMmpi(
    'Fb',
    'Infrecuencia posterior',
    _GrupoEscala.validez,
    'Infrecuencia en la segunda mitad del cuadernillo; detecta fatiga, falta '
        'de atención o deterioro durante la prueba.',
  ),
  _EscalaMmpi(
    'Fp',
    'Infrecuencia psicopatológica',
    _GrupoEscala.validez,
    'Respuestas infrecuentes incluso entre personas con psicopatología; '
        'apoya la detección de exageración de síntomas.',
  ),
  _EscalaMmpi(
    'Fs',
    'Infrecuencia somática',
    _GrupoEscala.validez,
    'Quejas somáticas raras o contradictorias; detecta exageración de '
        'síntomas físicos.',
  ),
  _EscalaMmpi(
    'VRIN',
    'Inconsistencia de respuestas variables',
    _GrupoEscala.validez,
    'Pares de ítems de contenido similar contestados de forma '
        'contradictoria; mide respuesta aleatoria o desatenta.',
  ),
  _EscalaMmpi(
    'TRIN',
    'Inconsistencia de respuestas verdadero',
    _GrupoEscala.validez,
    'Tendencia a responder «Verdadero» (o «Falso») de manera '
        'indiscriminada; una T alta invalida la interpretación.',
  ),
];

/// Escalas clínicas básicas del perfil estándar (1 a 0).
const List<_EscalaMmpi> _escalasClinicas = [
  _EscalaMmpi(
    'Hs',
    'Hipocondría',
    _GrupoEscala.clinica,
    'Preocupación por la salud y quejas somáticas difusas, con tendencia a '
        'demandar ayuda médica.',
  ),
  _EscalaMmpi(
    'D',
    'Depresión',
    _GrupoEscala.clinica,
    'Ánimo deprimido, desesperanza, baja energía y falta de interés; se '
        'interpreta también de forma bipolar.',
  ),
  _EscalaMmpi(
    'Hy',
    'Histeria',
    _GrupoEscala.clinica,
    'Uso de mecanismos de conversión y negación del malestar, con búsqueda '
        'de atención y apoyo.',
  ),
  _EscalaMmpi(
    'Pd',
    'Desviación psicopática',
    _GrupoEscala.clinica,
    'Dificultades con las normas sociales, impulsividad y conflictos '
        'familiares o laborales.',
  ),
  _EscalaMmpi(
    'Mf',
    'Masculinidad-Feminidad',
    _GrupoEscala.clinica,
    'Intereses y actitudes de rol de género. Se interpreta de forma bipolar '
        'y según el baremo del sexo.',
  ),
  _EscalaMmpi(
    'Pa',
    'Paranoia',
    _GrupoEscala.clinica,
    'Suspicacia, hipersensibilidad interpersonal y tendencia a atribuir el '
        'malestar a factores externos.',
  ),
  _EscalaMmpi(
    'Pt',
    'Psicastenia',
    _GrupoEscala.clinica,
    'Ansiedad, tensión, dudas repetidas y rasgos obsesivo-compulsivos.',
  ),
  _EscalaMmpi(
    'Sc',
    'Esquizofrenia',
    _GrupoEscala.clinica,
    'Experiencias inusuales, alienación social y desorganización del '
        'pensamiento.',
  ),
  _EscalaMmpi(
    'Ma',
    'Hipomanía',
    _GrupoEscala.clinica,
    'Activación, expansividad, energía elevada y baja tolerancia a la '
        'frustración.',
  ),
  _EscalaMmpi(
    'Si',
    'Introversión social',
    _GrupoEscala.clinica,
    'Retraimiento social y malestar en situaciones grupales. Se interpreta '
        'de forma bipolar.',
  ),
];

/// Escalas de Restructured Clinical (RC): separan el componente general de
/// desmoralización del contenido específico de cada escala clínica.
const List<_EscalaMmpi> _escalasRestructuradas = [
  _EscalaMmpi(
    'RCd',
    'Desmoralización',
    _GrupoEscala.restructurada,
    'Malestar general, infelicidad y baja autoeficacia; funciona como '
        'factor general del resto de escalas RC.',
  ),
  _EscalaMmpi(
    'RC1',
    'Quejas somáticas',
    _GrupoEscala.restructurada,
    'Malestar físico y quejas somáticas, sin los componentes de negación de '
        'la Hs.',
  ),
  _EscalaMmpi(
    'RC2',
    'Emociones negativas internalizadas',
    _GrupoEscala.restructurada,
    'Afecto negativo inespecífico: angustia, preocupación y tensión.',
  ),
  _EscalaMmpi(
    'RC3',
    'Cinismo',
    _GrupoEscala.restructurada,
    'Visión desconfiada y amarga de las personas y de sus motivos.',
  ),
  _EscalaMmpi(
    'RC4',
    'Conducta antisocial',
    _GrupoEscala.restructurada,
    'Conductas transgresoras y conflictos con la autoridad; se lee junto con '
        'la Pd.',
  ),
  _EscalaMmpi(
    'RC6',
    'Ideas de persecución',
    _GrupoEscala.restructurada,
    'Sensación de ser tratado injustamente, vigilado o perjudicado por '
        'otros.',
  ),
  _EscalaMmpi(
    'RC7',
    'Emociones negativas disfuncionales',
    _GrupoEscala.restructurada,
    'Síntomas internalizados específicos: miedos, obsesiones y baja '
        'autoestima.',
  ),
  _EscalaMmpi(
    'RC8',
    'Experiencias perceptuales aberrantes',
    _GrupoEscala.restructurada,
    'Experiencias sensoriales y de pensamiento inusuales, con menos '
        'alienación que la Sc.',
  ),
  _EscalaMmpi(
    'RC9',
    'Activación hipomaníaca',
    _GrupoEscala.restructurada,
    'Activación, impulsividad y búsqueda de sensaciones, sin la euforia de '
        'la Ma.',
  ),
];

/// Escalas PSY-5: los cinco rasgos de personalidad patológica que propone el
/// modelo de cinco factores.
const List<_EscalaMmpi> _escalasPsy5 = [
  _EscalaMmpi(
    'AGGR',
    'Agresividad',
    _GrupoEscala.psy5,
    'Agresividad, dominancia y disposición a intimidar o controlar a otros.',
  ),
  _EscalaMmpi(
    'PSYC',
    'Psicoticismo',
    _GrupoEscala.psy5,
    'Contacto alterado con la realidad y experiencias perceptuales '
        'atípicas.',
  ),
  _EscalaMmpi(
    'DISC',
    'Discontrol impulsivo',
    _GrupoEscala.psy5,
    'Impulsividad, búsqueda de sensaciones y baja conformidad con las '
        'normas.',
  ),
  _EscalaMmpi(
    'NEGE',
    'Neuroticismo',
    _GrupoEscala.psy5,
    'Afecto negativo: ansiedad, preocupación, irritabilidad y '
        'vulnerabilidad al estrés.',
  ),
  _EscalaMmpi(
    'INTR',
    'Introversión',
    _GrupoEscala.psy5,
    'Bajo afecto positivo: escaso disfrute, baja energía y poca '
        'sociabilidad.',
  ),
];

/// Escalas de contenido: agrupan los ítems por el tema que abordan.
const List<_EscalaMmpi> _escalasContenido = [
  _EscalaMmpi(
    'ANX',
    'Ansiedad',
    _GrupoEscala.contenido,
    'Síntomas de ansiedad: tensión, nerviosismo, miedos y quejas somáticas '
        'asociadas.',
  ),
  _EscalaMmpi(
    'FRS',
    'Miedos',
    _GrupoEscala.contenido,
    'Miedos específicos: animales, lugares, situaciones y agua.',
  ),
  _EscalaMmpi(
    'OBS',
    'Obsesividad',
    _GrupoEscala.contenido,
    'Dificultad para tomar decisiones, rumiación y conductas compulsivas.',
  ),
  _EscalaMmpi(
    'DEP',
    'Depresión',
    _GrupoEscala.contenido,
    'Síntomas depresivos: falta de energía, desesperanza y '
        'autodesvalorización.',
  ),
  _EscalaMmpi(
    'HEA',
    'Preocupaciones por la salud',
    _GrupoEscala.contenido,
    'Preocupación por el funcionamiento corporal y miedo a enfermar.',
  ),
  _EscalaMmpi(
    'BIZ',
    'Pensamiento extraño',
    _GrupoEscala.contenido,
    'Experiencias perceptuales y de pensamiento inusuales de tipo '
        'esquizotípico.',
  ),
  _EscalaMmpi(
    'ANG',
    'Ira',
    _GrupoEscala.contenido,
    'Irritabilidad, enojo y pérdida de control de la ira.',
  ),
  _EscalaMmpi(
    'CYN',
    'Cinismo',
    _GrupoEscala.contenido,
    'Actitud desconfiada y despectiva hacia las intenciones de los demás.',
  ),
  _EscalaMmpi(
    'ASP',
    'Conductas antisociales',
    _GrupoEscala.contenido,
    'Historia de conducta antisocial y problemas con la ley en la '
        'adolescencia y la adultez.',
  ),
  _EscalaMmpi(
    'TPA',
    'Problemas de tipo A',
    _GrupoEscala.contenido,
    'Estilo de conducta tipo A: prisa, competitividad, impaciencia y '
        'hostilidad.',
  ),
  _EscalaMmpi(
    'LSE',
    'Autoestima baja',
    _GrupoEscala.contenido,
    'Autoconcepto negativo, inseguridad y falta de confianza en las propias '
        'capacidades.',
  ),
  _EscalaMmpi(
    'SOD',
    'Malestar social',
    _GrupoEscala.contenido,
    'Incomodidad en situaciones sociales y evitación de eventos sociales.',
  ),
  _EscalaMmpi(
    'FAM',
    'Problemas familiares',
    _GrupoEscala.contenido,
    'Conflictos familiares: peleas, falta de apoyo y tensión en el hogar.',
  ),
  _EscalaMmpi(
    'WRK',
    'Interferencia laboral',
    _GrupoEscala.contenido,
    'Dificultades en el trabajo: baja productividad, falta de apoyo y '
        'problemas con compañeros o superiores.',
  ),
  _EscalaMmpi(
    'TRT',
    'Indicadores de problemas de tratamiento',
    _GrupoEscala.contenido,
    'Predisposición a negar problemas y actitud negativa hacia el '
        'tratamiento psicológico.',
  ),
];

/// Escalas suplementarias: perfiles complementarios de ansiedad, recursos,
/// personalidad y adicciones.
const List<_EscalaMmpi> _escalasSuplementarias = [
  _EscalaMmpi(
    'A',
    'Ansiedad',
    _GrupoEscala.suplementaria,
    'Ansiedad generalizada, pánico y estrés postraumático; comparte ítems '
        'con otras escalas de ansiedad.',
  ),
  _EscalaMmpi(
    'R',
    'Represión',
    _GrupoEscala.suplementaria,
    'Estilo represivo: negación de la ansiedad, conformidad y evitación '
        'emocional.',
  ),
  _EscalaMmpi(
    'Es',
    'Fuerza del yo',
    _GrupoEscala.suplementaria,
    'Recursos de afrontamiento y tolerancia al estrés; a mayor T, mejor '
        'pronóstico.',
  ),
  _EscalaMmpi(
    'Do',
    'Dominancia',
    _GrupoEscala.suplementaria,
    'Dominancia, asertividad y capacidad de influir en los demás.',
  ),
  _EscalaMmpi(
    'Re',
    'Responsabilidad social',
    _GrupoEscala.suplementaria,
    'Sentido de responsabilidad social, cooperación y confiabilidad.',
  ),
  _EscalaMmpi(
    'Mt',
    'Inadaptación universitaria',
    _GrupoEscala.suplementaria,
    'Inadaptación y estrés académico en estudiantes universitarios.',
  ),
  _EscalaMmpi(
    'PK',
    'Trastorno de estrés postraumático (Keane)',
    _GrupoEscala.suplementaria,
    'Síntomas de estrés postraumático según la clave de Keane y '
        'colaboradores.',
  ),
  _EscalaMmpi(
    'PS',
    'Trastorno de estrés postraumático (Schlenger)',
    _GrupoEscala.suplementaria,
    'Síntomas de estrés postraumático según la clave de Schlenger y '
        'colaboradores.',
  ),
  _EscalaMmpi(
    'MAC-R',
    'Alcoholismo (MacAndrew revisada)',
    _GrupoEscala.suplementaria,
    'Rasgos de personalidad asociados al abuso de alcohol.',
  ),
  _EscalaMmpi(
    'AAS',
    'Adicción potencial (adultos)',
    _GrupoEscala.suplementaria,
    'Riesgo de abuso de alcohol y otras sustancias en adultos.',
  ),
  _EscalaMmpi(
    'APS',
    'Adicción potencial (adolescentes)',
    _GrupoEscala.suplementaria,
    'Riesgo de abuso de sustancias en población adolescente.',
  ),
  _EscalaMmpi(
    'MDS',
    'Malestar marital',
    _GrupoEscala.suplementaria,
    'Malestar conyugal y dificultades de pareja.',
  ),
  _EscalaMmpi(
    'Ho',
    'Hostilidad',
    _GrupoEscala.suplementaria,
    'Hostilidad, resentimiento y cinismo; vinculada al riesgo '
        'cardiovascular.',
  ),
  _EscalaMmpi(
    'O-H',
    'Sobreactividad',
    _GrupoEscala.suplementaria,
    'Sobreactividad, euforia, baja inhibición y alta activación del ánimo.',
  ),
  _EscalaMmpi(
    'S',
    'Extraversión social',
    _GrupoEscala.suplementaria,
    'Extraversión e implicación social; se interpreta de forma bipolar y es '
        'complementaria de la Si.',
  ),
];

/// Todas las escalas de la hoja de puntuación, en el orden en que se
/// registran: validez, clínicas, RC, PSY-5, contenido y suplementarias.
const List<_EscalaMmpi> _todasLasEscalas = [
  ..._escalasValidez,
  ..._escalasClinicas,
  ..._escalasRestructuradas,
  ..._escalasPsy5,
  ..._escalasContenido,
  ..._escalasSuplementarias,
];

/// Número de ítem (base 1) que registra la escala [sigla].
int _numeroDeEscala(String sigla) =>
    _todasLasEscalas.indexWhere((escala) => escala.sigla == sigla) + 1;

/// MMPI-2: Inventario Multifásico de Personalidad de Minnesota-2
/// (Hathaway y McKinley, University of Minnesota Press, 1989).
///
/// **Hoja de puntuación**, no el instrumento completo: los 567 ítems son
/// propietarios y no se reproducen. El profesional administra la prueba con
/// el material oficial (cuadernillo, plantillas o plataforma licenciada) y
/// aquí registra, escala por escala, si la puntuación T alcanza el corte
/// convencional de 65.
///
/// Cubre las 62 escalas del perfil que se informan en la práctica clínica:
/// 8 de validez (L, F, K, Fb, Fp, Fs, VRIN, TRIN), las 10 clínicas básicas
/// (Hs, D, Hy, Pd, Mf, Pa, Pt, Sc, Ma, Si), las 9 restructuradas (RC), las 5
/// PSY-5, las 15 de contenido y las 15 suplementarias. Cada escala es una
/// subescala con su propia banda.
final InstrumentoAplicable mmpi2Aplicable = InstrumentoAplicable(
  id: 'mmpi-2',
  sigla: 'MMPI-2',
  titulo: 'Inventario Multifásico de Personalidad de Minnesota-2 '
      '(hoja de puntuación)',
  instrucciones: 'HOJA DE PUNTUACIÓN ADMINISTRADA POR EL PROFESIONAL. Aplique '
      'el MMPI-2 con el material oficial y su licencia vigente; después '
      'traslade aquí, desde el informe oficial, si cada escala del perfil '
      'alcanza el corte convencional T ≥ 65. Lamantin no reproduce los 567 '
      'ítems ni calcula puntuaciones T: registra el perfil completo escala '
      'por escala.',
  preguntas: [
    for (final escala in _todasLasEscalas)
      Pregunta(
        texto: '${escala.etiqueta}: ¿la puntuación T es ≥ 65?',
        opciones: _opcionesElevacion,
      ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: _todasLasEscalas.length,
      etiqueta: 'Ver subescalas',
      descripcion: 'El perfil se interpreta escala por escala: cada escala se '
          'marca como elevada cuando T ≥ 65.',
    ),
  ],
  subescalas: [
    for (var i = 0; i < _todasLasEscalas.length; i++)
      SubescalaPuntuacion(
        id: 'escala-${_todasLasEscalas[i].sigla.toLowerCase()}',
        nombre: _todasLasEscalas[i].etiqueta,
        descripcion: '${_todasLasEscalas[i].grupo.titulo} · '
            '${_todasLasEscalas[i].descripcion}',
        indicesPregunta: [i],
        rangos: _bandasEscala,
      ),
  ],
  alertas: [
    AlertaPregunta(
      numeroPregunta: _numeroDeEscala('F'),
      valorMinimo: 1,
      mensaje: 'Escala F elevada (T ≥ 65): respuestas infrecuentes que pueden '
          'reflejar exageración de síntomas, confusión o un estilo de '
          'respuesta atípico. Confirme la validez del protocolo antes de '
          'interpretar el perfil.',
    ),
    AlertaPregunta(
      numeroPregunta: _numeroDeEscala('Fb'),
      valorMinimo: 1,
      mensaje: 'Escala Fb elevada (T ≥ 65): infrecuencia en la segunda mitad '
          'del cuadernillo; puede indicar fatiga, pérdida de atención o '
          'deterioro durante la aplicación. Revise en qué condiciones se '
          'completó la prueba.',
    ),
    AlertaPregunta(
      numeroPregunta: _numeroDeEscala('Fp'),
      valorMinimo: 1,
      mensaje: 'Escala Fp elevada (T ≥ 65): respuestas infrecuentes incluso '
          'entre personas con psicopatología; refuerza la sospecha de '
          'exageración de síntomas.',
    ),
    AlertaPregunta(
      numeroPregunta: _numeroDeEscala('Fs'),
      valorMinimo: 1,
      mensaje: 'Escala Fs elevada (T ≥ 65): quejas somáticas raras o '
          'contradictorias; considere la posibilidad de exageración de '
          'síntomas físicos.',
    ),
    AlertaPregunta(
      numeroPregunta: _numeroDeEscala('VRIN'),
      valorMinimo: 1,
      mensaje: 'Inconsistencia en las respuestas (VRIN ≥ 65): hay respuestas '
          'contradictorias en ítems de contenido similar, así que la validez '
          'del protocolo es dudosa y el perfil no debe interpretarse hasta '
          'revisarlo con el informe oficial.',
    ),
    AlertaPregunta(
      numeroPregunta: _numeroDeEscala('TRIN'),
      valorMinimo: 1,
      mensaje: 'Inconsistencia en las respuestas (TRIN ≥ 65): tendencia a '
          'responder «Verdadero» o «Falso» de forma indiscriminada; la '
          'validez del protocolo es dudosa.',
    ),
  ],
  mostrarPuntuacionTotal: false,
  nota: 'Sólo puede aplicarlo personal con la licencia vigente del editor '
      '(Pearson / University of Minnesota Press); el MMPI-2 no es un '
      'instrumento de uso libre. Lamantin no reproduce los 567 ítems ni '
      'calcula puntuaciones T ni baremos: esta hoja registra el corte T ≥ 65 '
      'de las 62 escalas del perfil para practicar su lectura, y no sustituye '
      'el informe oficial ni el juicio clínico. Quedan fuera las subescalas '
      'de Harris-Lingoes, las subescalas de contenido y las subescalas de Si; '
      'los nombres en español son una traducción orientativa. Existen otras '
      'formas (MMPI-2-RF, 338 ítems; MMPI-A, para adolescentes) con baremos '
      'propios.',
);

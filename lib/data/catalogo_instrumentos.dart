import '../models/categoria_instrumento.dart';
import '../models/instrumento.dart';

/// Catálogo de instrumentos de medición psicológica de uso público
/// disponibles en Lamantin.
///
/// Cada instrumento indica su condición de uso (dominio público, libre uso
/// clínico, etc.). Antes de usar un instrumento, el profesional debe
/// confirmar la licencia vigente con la fuente correspondiente.
const List<Instrumento> catalogoInstrumentos = [
  // ───────────────────────────── DEPRESIÓN ─────────────────────────────
  Instrumento(
    id: 'phq-9',
    nombre: 'Patient Health Questionnaire-9',
    sigla: 'PHQ-9',
    categoria: CategoriaInstrumento.depresion,
    descripcion: 'Evalúa la frecuencia de los 9 síntomas del episodio '
        'depresivo mayor según DSM-5 durante las últimas 2 semanas.',
    autor: 'Kroenke, Spitzer y Williams',
    anio: 2001,
    numeroItems: 9,
    tiempo: '2-3 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Adultos y adolescentes',
    nota: 'Forma parte de la familia de cuestionarios PHQ de Pfizer.',
  ),
  Instrumento(
    id: 'ces-d',
    nombre: 'Center for Epidemiologic Studies Depression Scale',
    sigla: 'CES-D',
    categoria: CategoriaInstrumento.depresion,
    descripcion: 'Mide la frecuencia de síntomas depresivos en la última '
        'semana, con énfasis en el componente afectivo.',
    autor: 'Radloff',
    anio: 1977,
    numeroItems: 20,
    tiempo: '5-10 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Población general',
  ),
  Instrumento(
    id: 'gds-15',
    nombre: 'Escala de Depresión Geriátrica (versión corta)',
    sigla: 'GDS-15',
    categoria: CategoriaInstrumento.depresion,
    descripcion: 'Detección de depresión en adultos mayores con respuesta '
        'sí/no, sencilla de aplicar incluso con deterioro cognitivo leve.',
    autor: 'Yesavage y colaboradores',
    anio: 1982,
    numeroItems: 15,
    tiempo: '5-7 min',
    disponibilidad: 'Libre uso clínico',
    poblacion: 'Adultos mayores',
    nota: 'Existe versión completa de 30 ítems.',
  ),
  Instrumento(
    id: 'epds',
    nombre: 'Escala de Depresión Postnatal de Edimburgo',
    sigla: 'EPDS',
    categoria: CategoriaInstrumento.depresion,
    descripcion: 'Identifica depresión posparto durante la gestación y el '
        'puerperio (hasta 8 semanas tras el parto).',
    autor: 'Cox, Holden y Sagovsky',
    anio: 1987,
    numeroItems: 10,
    tiempo: '3-5 min',
    disponibilidad: 'Libre uso clínico',
    poblacion: 'Embarazadas y puérperas',
    nota: 'Validada en español por García-Esteve y colaboradores (2003).',
  ),
  Instrumento(
    id: 'zung-sds',
    nombre: 'Escala de Autoevaluación de la Depresión de Zung',
    sigla: 'Zung SDS',
    categoria: CategoriaInstrumento.depresion,
    descripcion: 'Evalúa el nivel de depresión mediante síntomas afectivos, '
        'fisiológicos y psicomotores.',
    autor: 'William W. K. Zung',
    anio: 1965,
    numeroItems: 20,
    tiempo: '5-10 min',
    disponibilidad: 'Libre uso',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'cudos',
    nombre: 'Clinically Useful Depression Outcome Scale',
    sigla: 'CUDOS',
    categoria: CategoriaInstrumento.depresion,
    descripcion: 'Evalúa la gravedad de la depresión y el cambio clínico '
        'durante el tratamiento.',
    autor: 'Mark Zimmerman',
    anio: 2004,
    numeroItems: 18,
    tiempo: '5 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Adultos',
  ),

  // ───────────────────────────── ANSIEDAD ─────────────────────────────
  Instrumento(
    id: 'gad-7',
    nombre: 'Generalized Anxiety Disorder-7',
    sigla: 'GAD-7',
    categoria: CategoriaInstrumento.ansiedad,
    descripcion: 'Mide la gravedad de los síntomas de ansiedad generalizada '
        'según DSM-5 durante las últimas 2 semanas.',
    autor: 'Spitzer, Kroenke, Williams y Löwe',
    anio: 2006,
    numeroItems: 7,
    tiempo: '2 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'zung-sas',
    nombre: 'Escala de Autoevaluación de la Ansiedad de Zung',
    sigla: 'Zung SAS',
    categoria: CategoriaInstrumento.ansiedad,
    descripcion: 'Evalúa la frecuencia de síntomas de ansiedad en la última '
        'semana, tanto cognitivos como somáticos.',
    autor: 'William W. K. Zung',
    anio: 1971,
    numeroItems: 20,
    tiempo: '5-10 min',
    disponibilidad: 'Libre uso',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'spin',
    nombre: 'Social Phobia Inventory',
    sigla: 'SPIN',
    categoria: CategoriaInstrumento.ansiedad,
    descripcion: 'Cribado y medición de la gravedad de la fobia social.',
    autor: 'Connor y colaboradores',
    anio: 2000,
    numeroItems: 17,
    tiempo: '5 min',
    disponibilidad: 'Libre uso clínico',
    poblacion: 'Adultos y adolescentes',
  ),
  Instrumento(
    id: 'pswq',
    nombre: 'Penn State Worry Questionnaire',
    sigla: 'PSWQ',
    categoria: CategoriaInstrumento.ansiedad,
    descripcion: 'Mide la tendencia a la preocupación patológica o excesiva '
        '(rasgo), independiente del contenido.',
    autor: 'Meyer, Miller, Metzger y Borkovec',
    anio: 1990,
    numeroItems: 16,
    tiempo: '5 min',
    disponibilidad: 'Libre uso clínico e investigación',
    poblacion: 'Adultos',
  ),

  // ───────────────────────────── ESTRÉS ─────────────────────────────
  Instrumento(
    id: 'pss-10',
    nombre: 'Escala de Estrés Percibido',
    sigla: 'PSS-10',
    categoria: CategoriaInstrumento.estres,
    descripcion: 'Mide el grado en que las situaciones de la vida se valoran '
        'como estresantes en el último mes.',
    autor: 'Cohen, Kamarck y Mermelstein',
    anio: 1983,
    numeroItems: 10,
    tiempo: '5 min',
    disponibilidad: 'Uso en investigación con cita',
    poblacion: 'Adultos',
    nota: 'Instrumento con copyright; su distribución comercial se realiza '
        'a través de Mind Garden. Los ítems se reproducen en la publicación '
        'original y en manuales académicos.',
  ),

  // ───────────────────────────── TRAUMA Y TEPT ─────────────────────────────
  Instrumento(
    id: 'pcl-5',
    nombre: 'PTSD Checklist para DSM-5',
    sigla: 'PCL-5',
    categoria: CategoriaInstrumento.trauma,
    descripcion: 'Cribado y medición de la gravedad de los síntomas de TEPT '
        'según los criterios del DSM-5.',
    autor: 'Weathers y colaboradores (National Center for PTSD)',
    anio: 2013,
    numeroItems: 20,
    tiempo: '5-10 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Adultos',
    nota: 'La traducción al español se solicita al National Center for PTSD.',
  ),
  Instrumento(
    id: 'ies-r',
    nombre: 'Escala de Impacto del Evento-Revisada',
    sigla: 'IES-R',
    categoria: CategoriaInstrumento.trauma,
    descripcion: 'Mide la respuesta subjetiva a un evento traumático en tres '
        'dimensiones: intrusión, evitación e hiperactivación.',
    autor: 'Weiss y Marmar',
    anio: 1997,
    numeroItems: 22,
    tiempo: '5-10 min',
    disponibilidad: 'Libre uso no comercial',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'dar-5',
    nombre: 'Dimensions of Anger Reactions-5',
    sigla: 'DAR-5',
    categoria: CategoriaInstrumento.trauma,
    descripcion: 'Evalúa la gravedad de la ira, especialmente la ira posterior '
        'a experiencias traumáticas.',
    autor: 'Forbes y colaboradores',
    anio: 2014,
    numeroItems: 5,
    tiempo: '2 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Adultos',
  ),

  // ───────────────────────────── VOCACIONAL ─────────────────────────────
  Instrumento(
    id: 'onet-ip',
    nombre: 'O*NET Interest Profiler (Mini-IP / Short Form)',
    sigla: 'O*NET IP',
    categoria: CategoriaInstrumento.vocacional,
    descripcion: 'Explora los intereses vocacionales según el modelo RIASEC '
        'de Holland (Realista, Investigador, Artístico, Social, '
        'Emprendedor, Convencional) y los vincula con ocupaciones.',
    autor: 'Departamento de Trabajo de EE. UU. (O*NET)',
    anio: 1998,
    numeroItems: 30,
    tiempo: '10-20 min',
    disponibilidad: 'Licencia Creative Commons CC-BY 4.0 (gratuito)',
    poblacion: 'Adolescentes y adultos',
    nota: 'Versión en español disponible vía Mi Próximo Paso. La versión '
        'Short Form es de 60 ítems.',
  ),

  // ───────────────────────────── AUTOESTIMA ─────────────────────────────
  Instrumento(
    id: 'rses',
    nombre: 'Escala de Autoestima de Rosenberg',
    sigla: 'RSES',
    categoria: CategoriaInstrumento.autoestima,
    descripcion: 'Mide la autoestima global mediante 5 ítems positivos y 5 '
        'negativos sobre el autovalor y la autoaceptación.',
    autor: 'Morris Rosenberg',
    anio: 1965,
    numeroItems: 10,
    tiempo: '2-3 min',
    disponibilidad: 'Libre uso',
    poblacion: 'Adolescentes y adultos',
  ),

  // ───────────────────────────── SUEÑO ─────────────────────────────
  Instrumento(
    id: 'isi',
    nombre: 'Índice de Severidad de Insomnio',
    sigla: 'ISI',
    categoria: CategoriaInstrumento.sueno,
    descripcion: 'Evalúa la gravedad del insomnio, su impacto diurno y la '
        'percepción del problema en el último mes.',
    autor: 'Charles M. Morin',
    anio: 1993,
    numeroItems: 7,
    tiempo: '3-5 min',
    disponibilidad: 'Libre uso clínico (permiso del autor)',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'psqi',
    nombre: 'Índice de Calidad de Sueño de Pittsburgh',
    sigla: 'PSQI',
    categoria: CategoriaInstrumento.sueno,
    descripcion: 'Valora la calidad del sueño del último mes a través de 7 '
        'componentes (latencia, duración, eficiencia, alteraciones, etc.).',
    autor: 'Buysse y colaboradores',
    anio: 1989,
    numeroItems: 19,
    tiempo: '5-10 min',
    disponibilidad: 'Libre uso clínico e investigación',
    poblacion: 'Adultos',
  ),

  // ───────────────────────────── ADICCIONES ─────────────────────────────
  Instrumento(
    id: 'audit',
    nombre: 'Test de Identificación de Trastornos por Consumo de Alcohol',
    sigla: 'AUDIT',
    categoria: CategoriaInstrumento.adicciones,
    descripcion: 'Identifica consumo de riesgo y perjudicial de alcohol, así '
        'como posible dependencia, en el último año.',
    autor: 'Babor y colaboradores (OMS)',
    anio: 1989,
    numeroItems: 10,
    tiempo: '2-3 min',
    disponibilidad: 'Libre uso (OMS)',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'cage',
    nombre: 'CAGE (Cut-down, Annoyed, Guilty, Eye-opener)',
    sigla: 'CAGE',
    categoria: CategoriaInstrumento.adicciones,
    descripcion: 'Cribado breve de problemas con la bebida mediante 4 '
        'preguntas (consumo, molestia, culpa y consumo matinal).',
    autor: 'John A. Ewing',
    anio: 1984,
    numeroItems: 4,
    tiempo: '<1 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'dast-10',
    nombre: 'Drug Abuse Screening Test-10',
    sigla: 'DAST-10',
    categoria: CategoriaInstrumento.adicciones,
    descripcion: 'Detección del uso problemático de drogas en el último año '
        '(excluye alcohol y tabaco).',
    autor: 'Harvey A. Skinner',
    anio: 1982,
    numeroItems: 10,
    tiempo: '2-3 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'crafft',
    nombre: 'CRAFFT 2.1',
    sigla: 'CRAFFT',
    categoria: CategoriaInstrumento.adicciones,
    descripcion: 'Cribado de consumo de riesgo de alcohol y drogas en '
        'adolescentes y jóvenes.',
    autor: 'Knight y colaboradores',
    anio: 1999,
    numeroItems: 6,
    tiempo: '2 min',
    disponibilidad: 'Libre uso clínico',
    poblacion: 'Adolescentes (≤21 años)',
    nota: 'Existe la versión actualizada CRAFFT 2.1.',
  ),

  // ───────────────────────────── PERSONALIDAD ─────────────────────────────
  Instrumento(
    id: 'bfi-44',
    nombre: 'Big Five Inventory',
    sigla: 'BFI-44',
    categoria: CategoriaInstrumento.personalidad,
    descripcion: 'Mide los cinco grandes factores de la personalidad: '
        'Extraversión, Amabilidad, Responsabilidad, Neuroticismo y '
        'Apertura a la experiencia.',
    autor: 'John, Donahue y Kentle',
    anio: 1991,
    numeroItems: 44,
    tiempo: '5-10 min',
    disponibilidad: 'Libre uso no comercial',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'ipip-neo-120',
    nombre: 'International Personality Item Pool (NEO-120)',
    sigla: 'IPIP-NEO-120',
    categoria: CategoriaInstrumento.personalidad,
    descripcion: 'Mide los cinco grandes factores y 30 facetas de la '
        'personalidad a partir del pool de ítems de dominio público del IPIP.',
    autor: 'Lewis R. Goldberg (IPIP)',
    anio: 1999,
    numeroItems: 120,
    tiempo: '15-20 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Adultos',
    nota: 'Más de 3.000 ítems y 250 escalas disponibles en ipip.ori.org.',
  ),

  // ─────────────────────── BIENESTAR Y CALIDAD DE VIDA ───────────────────────
  Instrumento(
    id: 'swls',
    nombre: 'Escala de Satisfacción con la Vida',
    sigla: 'SWLS',
    categoria: CategoriaInstrumento.bienestar,
    descripcion: 'Evalúa el juicio global de la persona sobre su satisfacción '
        'con la vida.',
    autor: 'Diener, Emmons, Larsen y Griffin',
    anio: 1985,
    numeroItems: 5,
    tiempo: '1-2 min',
    disponibilidad: 'Libre uso no comercial',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'panas',
    nombre: 'Escala de Afecto Positivo y Negativo',
    sigla: 'PANAS',
    categoria: CategoriaInstrumento.bienestar,
    descripcion: 'Mide el afecto positivo y negativo durante la última '
        'semana.',
    autor: 'Watson, Clark y Tellegen',
    anio: 1988,
    numeroItems: 20,
    tiempo: '3-5 min',
    disponibilidad: 'Libre uso no comercial',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'whoqol-bref',
    nombre: 'Cuestionario de Calidad de Vida de la OMS (versión abreviada)',
    sigla: 'WHOQOL-BREF',
    categoria: CategoriaInstrumento.bienestar,
    descripcion: 'Evalúa la calidad de vida percibida en cuatro dominios: '
        'físico, psicológico, relaciones sociales y ambiente.',
    autor: 'Organización Mundial de la Salud',
    anio: 1996,
    numeroItems: 26,
    tiempo: '5-10 min',
    disponibilidad: 'Gratuito con registro en la OMS',
    poblacion: 'Adultos',
  ),

  // ─────────────────────── ATENCIÓN Y CONCENTRACIÓN ───────────────────────
  Instrumento(
    id: 'asrs-v1-1',
    nombre: 'Adult ADHD Self-Report Scale v1.1',
    sigla: 'ASRS v1.1',
    categoria: CategoriaInstrumento.atencion,
    descripcion: 'Cribado de síntomas de TDAH en adultos según los criterios '
        'del DSM-IV-TR. La parte A (6 ítems) funciona como cribado breve.',
    autor: 'Kessler y colaboradores (OMS)',
    anio: 2005,
    numeroItems: 18,
    tiempo: '3-5 min',
    disponibilidad: 'Libre uso (OMS)',
    poblacion: 'Adultos',
    nota: 'Herramienta de cribado; un resultado positivo requiere una '
        'evaluación clínica completa para el diagnóstico.',
  ),

  // ───────────────────────────── SALUD MENTAL GENERAL ─────────────────────────────
  Instrumento(
    id: 'k10',
    nombre: 'Escala de Malestar Psicológico de Kessler',
    sigla: 'K10',
    categoria: CategoriaInstrumento.saludMentalGeneral,
    descripcion: 'Cribado de malestar psicológico no específico en las '
        'últimas 4 semanas (ansiedad y depresión).',
    autor: 'Kessler y colaboradores',
    anio: 2002,
    numeroItems: 10,
    tiempo: '2-3 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'srq-20',
    nombre: 'Self-Reporting Questionnaire',
    sigla: 'SRQ-20',
    categoria: CategoriaInstrumento.saludMentalGeneral,
    descripcion: 'Cribado de trastornos mentales comunes en atención '
        'primaria, con respuesta sí/no.',
    autor: 'Harding y colaboradores (OMS)',
    anio: 1980,
    numeroItems: 20,
    tiempo: '5-10 min',
    disponibilidad: 'Libre uso (OMS)',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'dass-21',
    nombre: 'Escalas de Depresión, Ansiedad y Estrés',
    sigla: 'DASS-21',
    categoria: CategoriaInstrumento.saludMentalGeneral,
    descripcion: 'Mide tres estados emocionales negativos: depresión, '
        'ansiedad y estrés, durante la última semana.',
    autor: 'Lovibond y Lovibond',
    anio: 1995,
    numeroItems: 21,
    tiempo: '5 min',
    disponibilidad: 'Gratuito para uso no comercial (permiso de los autores)',
    poblacion: 'Adultos',
    nota: 'Existe versión completa de 42 ítems.',
  ),

  // ───────────────────────────── RIESGO SUICIDA ─────────────────────────────
  Instrumento(
    id: 'c-ssrs',
    nombre: 'Columbia-Suicide Severity Rating Scale',
    sigla: 'C-SSRS',
    categoria: CategoriaInstrumento.riesgoSuicida,
    descripcion: 'Evalúa la severidad de la ideación y la conducta suicida, '
        'incluyendo intensidad, frecuencia y letalidad de los intentos.',
    autor: 'Posner y colaboradores (Columbia University)',
    anio: 2011,
    numeroItems: 6,
    tiempo: '5-10 min',
    disponibilidad: 'Gratuito; requiere registro en cssrs.columbia.edu',
    poblacion: 'Niños, adolescentes y adultos',
    nota: 'La versión de cribado tiene 6 preguntas. Se recomienda '
        'completar el entrenamiento gratuito del protocolo.',
  ),
  Instrumento(
    id: 'sbq-r',
    nombre: 'Suicidal Behaviors Questionnaire-Revised',
    sigla: 'SBQ-R',
    categoria: CategoriaInstrumento.riesgoSuicida,
    descripcion: 'Evalúa la historia de pensamientos e intentos suicidas y '
        'el riesgo actual en cuatro dimensiones.',
    autor: 'Osman y colaboradores',
    anio: 2001,
    numeroItems: 4,
    tiempo: '1-2 min',
    disponibilidad: 'Libre uso clínico e investigación',
    poblacion: 'Adolescentes y adultos',
  ),

  // ───────────────────────────── INFANTO-JUVENIL ─────────────────────────────
  Instrumento(
    id: 'sdq',
    nombre: 'Cuestionario de Capacidades y Dificultades',
    sigla: 'SDQ',
    categoria: CategoriaInstrumento.infantoJuvenil,
    descripcion: 'Cribado de problemas emocionales, de conducta, '
        'hiperactividad, relación con los compañeros y conducta prosocial.',
    autor: 'Robert Goodman',
    anio: 1997,
    numeroItems: 25,
    tiempo: '5-10 min',
    disponibilidad: 'Gratuito en papel para uso no comercial',
    poblacion: 'Niños y adolescentes (4-17 años)',
    nota: 'Existen versiones para padres y profesores. La versión digital '
        'requiere autorización expresa (youthinmind.com).',
  ),
  Instrumento(
    id: 'scared',
    nombre: 'Screen for Child Anxiety Related Emotional Disorders',
    sigla: 'SCARED',
    categoria: CategoriaInstrumento.infantoJuvenil,
    descripcion: 'Cribado de síntomas de ansiedad (pánico, ansiedad '
        'generalizada, ansiedad de separación, fobia social y fobia escolar).',
    autor: 'Birmaher y colaboradores',
    anio: 1997,
    numeroItems: 41,
    tiempo: '10 min',
    disponibilidad: 'Libre uso clínico e investigación',
    poblacion: 'Niños y adolescentes (8-18 años)',
  ),
  Instrumento(
    id: 'ces-dc',
    nombre: 'Center for Epidemiologic Studies Depression Scale for Children',
    sigla: 'CES-DC',
    categoria: CategoriaInstrumento.infantoJuvenil,
    descripcion: 'Mide la frecuencia de síntomas depresivos en niños y '
        'adolescentes (adaptación de la CES-D).',
    autor: 'Weissman y colaboradores',
    anio: 1980,
    numeroItems: 20,
    tiempo: '5 min',
    disponibilidad: 'Libre uso',
    poblacion: 'Niños y adolescentes (6-17 años)',
  ),
  Instrumento(
    id: 'mfq',
    nombre: 'Mood and Feelings Questionnaire',
    sigla: 'MFQ',
    categoria: CategoriaInstrumento.infantoJuvenil,
    descripcion: 'Evalúa síntomas depresivos en niños y adolescentes a '
        'partir de informes del propio menor y de sus padres.',
    autor: 'Angold y Costello',
    anio: 1987,
    numeroItems: 33,
    tiempo: '5-10 min',
    disponibilidad: 'Libre uso clínico e investigación',
    poblacion: 'Niños y adolescentes (6-17 años)',
    nota: 'Existe versión breve de 13 ítems.',
  ),
  Instrumento(
    id: 'snap-iv',
    nombre: 'Swanson, Nolan y Pelham-IV',
    sigla: 'SNAP-IV',
    categoria: CategoriaInstrumento.infantoJuvenil,
    descripcion: 'Evalúa síntomas de TDAH y de conducta oposicionista '
        'desafiante según los criterios del DSM-IV.',
    autor: 'Swanson y colaboradores',
    anio: 2001,
    numeroItems: 26,
    tiempo: '5-10 min',
    disponibilidad: 'Libre uso clínico',
    poblacion: 'Niños y adolescentes (6-18 años)',
    nota: 'La versión completa tiene 90 ítems; la de cribado, 26.',
  ),

  // ─────────────────────── APOYO SOCIAL Y SOLEDAD ───────────────────────
  Instrumento(
    id: 'ucla-20',
    nombre: 'Escala de Soledad de UCLA (versión 3)',
    sigla: 'UCLA-20',
    categoria: CategoriaInstrumento.apoyoSocialSoledad,
    descripcion: 'Mide la percepción subjetiva de soledad mediante ítems '
        'positivos y negativos sobre las relaciones sociales.',
    autor: 'Daniel W. Russell',
    anio: 1996,
    numeroItems: 20,
    tiempo: '5 min',
    disponibilidad: 'Libre uso en investigación (cita del autor)',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'mspss',
    nombre: 'Escala Multidimensional de Apoyo Social Percibido',
    sigla: 'MSPSS',
    categoria: CategoriaInstrumento.apoyoSocialSoledad,
    descripcion: 'Evalúa el apoyo social percibido de la familia, los amigos '
        'y otras personas significativas.',
    autor: 'Zimet y colaboradores',
    anio: 1988,
    numeroItems: 12,
    tiempo: '2-3 min',
    disponibilidad: 'Gratuito para investigación (cita del autor)',
    poblacion: 'Adolescentes y adultos',
  ),

  // ───────────────────────────── REGULACIÓN EMOCIONAL ─────────────────────────────
  Instrumento(
    id: 'erq',
    nombre: 'Emotion Regulation Questionnaire',
    sigla: 'ERQ',
    categoria: CategoriaInstrumento.regulacionEmocional,
    descripcion: 'Mide el uso de dos estrategias de regulación emocional: '
        'reevaluación cognitiva y supresión expresiva.',
    autor: 'Gross y John',
    anio: 2003,
    numeroItems: 10,
    tiempo: '2-3 min',
    disponibilidad: 'Libre uso en investigación',
    poblacion: 'Adultos',
  ),
  Instrumento(
    id: 'maas',
    nombre: 'Mindful Attention Awareness Scale',
    sigla: 'MAAS',
    categoria: CategoriaInstrumento.regulacionEmocional,
    descripcion: 'Mide la atención y conciencia plena (mindfulness) en la '
        'vida cotidiana.',
    autor: 'Brown y Ryan',
    anio: 2003,
    numeroItems: 15,
    tiempo: '5 min',
    disponibilidad: 'Libre uso en investigación',
    poblacion: 'Adultos',
  ),

  // ───────────────────────────── NEUROCOGNITIVO ─────────────────────────────
  Instrumento(
    id: 'moca',
    nombre: 'Evaluación Cognitiva de Montreal',
    sigla: 'MoCA',
    categoria: CategoriaInstrumento.neurocognitivo,
    descripcion: 'Cribado de deterioro cognitivo leve en 7 dominios: '
        'atención, memoria, lenguaje, visuoconstrucción, funciones '
        'ejecutivas, orientación y cálculo.',
    autor: 'Nasreddine y colaboradores',
    anio: 2005,
    numeroItems: 30,
    tiempo: '10 min',
    disponibilidad: 'Gratuito con registro en mocacognition.com',
    poblacion: 'Adultos (55-85 años)',
    nota: 'La interpretación por dominios requiere el programa oficial de '
        'certificación.',
  ),

  // ─────────────────────── BIENESTAR Y CALIDAD DE VIDA (refuerzo) ───────────────────────
  Instrumento(
    id: 'lot-r',
    nombre: 'Test de Orientación Vital-Revisado',
    sigla: 'LOT-R',
    categoria: CategoriaInstrumento.bienestar,
    descripcion: 'Mide el optimismo disposicional, es decir, las expectativas '
        'positivas generalizadas sobre el futuro.',
    autor: 'Scheier y Carver',
    anio: 1994,
    numeroItems: 10,
    tiempo: '2-3 min',
    disponibilidad: 'Libre uso en investigación (cita del autor)',
    poblacion: 'Adultos',
    nota: '6 ítems se puntúan y 4 actúan como relleno.',
  ),
  Instrumento(
    id: 'escala-florecimiento',
    nombre: 'Escala de Florecimiento (Flourishing Scale)',
    sigla: 'FS',
    categoria: CategoriaInstrumento.bienestar,
    descripcion: 'Mide el bienestar psicológico y social percibido: éxito, '
        'relaciones, propósito y optimismo.',
    autor: 'Diener y colaboradores',
    anio: 2009,
    numeroItems: 8,
    tiempo: '1-2 min',
    disponibilidad: 'Libre uso no comercial',
    poblacion: 'Adultos',
  ),

  // ───────────────────────────── ADICCIONES (refuerzo) ─────────────────────────────
  Instrumento(
    id: 'taps',
    nombre: 'Tobacco, Alcohol, Prescription medication, and other Substance '
        'use Tool',
    sigla: 'TAPS',
    categoria: CategoriaInstrumento.adicciones,
    descripcion: 'Cribado de consumo de tabaco, alcohol, fármacos con '
        'receta y otras sustancias en el último año.',
    autor: 'NIDA / NIAAA',
    anio: 2017,
    numeroItems: 4,
    tiempo: '2-3 min',
    disponibilidad: 'Dominio público',
    poblacion: 'Adultos',
    nota: 'La parte TAPS-2 (9 ítems) profundiza en cada sustancia con '
        'consumo positivo.',
  ),
  Instrumento(
    id: 'assist-v3',
    nombre: 'Test de Detección de Consumo de Alcohol, Tabaco y Sustancias '
        '(Alcohol, Smoking and Substance Involvement Screening Test)',
    sigla: 'ASSIST v3.0',
    categoria: CategoriaInstrumento.adicciones,
    descripcion: 'Detección del consumo de alcohol, tabaco y sustancias, así '
        'como del riesgo asociado, en los últimos 3 meses.',
    autor: 'Organización Mundial de la Salud',
    anio: 2002,
    numeroItems: 8,
    tiempo: '5-10 min',
    disponibilidad: 'Libre uso (OMS)',
    poblacion: 'Adultos',
    nota: 'Se administra por cada sustancia reportada. Incluye la versión '
        'intervención breve (ASSIST-Lite).',
  ),
];

/// Devuelve los instrumentos que pertenecen a la [categoria] indicada.
List<Instrumento> instrumentosDeCategoria(CategoriaInstrumento categoria) {
  return catalogoInstrumentos
      .where((instrumento) => instrumento.categoria == categoria)
      .toList();
}

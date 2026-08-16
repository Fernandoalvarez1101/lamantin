import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones sí/no para los ítems puntuados por el profesional (1/0).
const List<OpcionRespuesta> _opcionesSiNo = [
  OpcionRespuesta(etiqueta: 'No', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí', valor: 1),
];

/// Opciones de la serie de sustracción de 7 (Atención, 0-3 puntos).
const List<OpcionRespuesta> _opcionesSerie7 = [
  OpcionRespuesta(etiqueta: '0-1 correctas', valor: 0),
  OpcionRespuesta(etiqueta: '2-3 correctas', valor: 1),
  OpcionRespuesta(etiqueta: '4 correctas', valor: 2),
  OpcionRespuesta(etiqueta: '5 correctas', valor: 3),
];

/// Rangos descriptivos (sin cortes publicados) de cada dominio.
const List<RangoPuntuacion> _descriptivo5 = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 0,
    maximo: 5,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte publicados por dominio.',
    descriptiva: true,
  ),
];

const List<RangoPuntuacion> _descriptivo3 = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 0,
    maximo: 3,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte publicados por dominio.',
    descriptiva: true,
  ),
];

const List<RangoPuntuacion> _descriptivo6 = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 0,
    maximo: 6,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte publicados por dominio.',
    descriptiva: true,
  ),
];

const List<RangoPuntuacion> _descriptivo2 = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 0,
    maximo: 2,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte publicados por dominio.',
    descriptiva: true,
  ),
];

/// MoCA (Evaluación Cognitiva de Montreal): hoja de puntuación
/// administrada por el profesional.
///
/// No reproduce el material oficial (láminas, palabras, frases): la persona
/// profesional administra la prueba con su protocolo de mocacognition.com y
/// registra aquí la puntuación de cada ítem. 30 puntos en 7 dominios; corte
/// publicado <26.
const InstrumentoAplicable mocaAplicable = InstrumentoAplicable(
  id: 'moca',
  sigla: 'MoCA',
  titulo: 'Evaluación Cognitiva de Montreal (puntuación)',
  instrucciones: 'Prueba de cribado cognitivo ADMINISTRADA POR EL '
      'PROFESIONAL. Utilice el protocolo y el material oficial de la MoCA '
      '(mocacognition.com). Registre aquí el resultado de cada ítem: marque '
      '"Sí" cuando la persona complete correctamente la tarea según el '
      'manual oficial.',
  preguntas: [
    // ── Visuoespacial / Ejecutiva (5) ─────────────────────────────
    Pregunta(
      texto: 'Visuoespacial — Recorrido: ¿completó la secuencia alternando '
          'números y letras sin error?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Visuoespacial — Copia del cubo: ¿reprodujo correctamente el '
          'cubo?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Reloj — Contorno: ¿dibujó un círculo aceptable?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Reloj — Números: ¿ubicó correctamente los 12 números?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Reloj — Manecillas: ¿dibujó las manecillas en la hora '
          'indicada?',
      opciones: _opcionesSiNo,
    ),
    // ── Denominación (3) ──────────────────────────────────────────
    Pregunta(
      texto: 'Denominación — Ítem 1: ¿identificó correctamente la figura?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Denominación — Ítem 2: ¿identificó correctamente la figura?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Denominación — Ítem 3: ¿identificó correctamente la figura?',
      opciones: _opcionesSiNo,
    ),
    // ── Memoria: recuerdo diferido (5) ────────────────────────────
    Pregunta(
      texto: 'Recuerdo diferido — Palabra 1: ¿la recordó espontáneamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Recuerdo diferido — Palabra 2: ¿la recordó espontáneamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Recuerdo diferido — Palabra 3: ¿la recordó espontáneamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Recuerdo diferido — Palabra 4: ¿la recordó espontáneamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Recuerdo diferido — Palabra 5: ¿la recordó espontáneamente?',
      opciones: _opcionesSiNo,
    ),
    // ── Atención (6) ──────────────────────────────────────────────
    Pregunta(
      texto: 'Atención — Dígitos en orden directo: ¿los repitió '
          'correctamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Atención — Dígitos en orden inverso: ¿los repitió '
          'correctamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Atención — Vigilancia: ¿tocó correctamente ante la letra '
          'señalada sin errores?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Atención — Serie de 7 (93-86-79-72-65): ¿cuántas '
          'sustracciones correctas?',
      opciones: _opcionesSerie7,
    ),
    // ── Lenguaje (3) ──────────────────────────────────────────────
    Pregunta(
      texto: 'Lenguaje — Repetición, frase 1: ¿repitió exactamente la '
          'frase?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Lenguaje — Repetición, frase 2: ¿repitió exactamente la '
          'frase?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Lenguaje — Fluidez: ¿dijo 11 o más palabras con la letra '
          'indicada en 60 segundos?',
      opciones: _opcionesSiNo,
    ),
    // ── Abstracción (2) ───────────────────────────────────────────
    Pregunta(
      texto: 'Abstracción — Semejanza 1: ¿identificó la categoría común '
          'correcta?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Abstracción — Semejanza 2: ¿identificó la categoría común '
          'correcta?',
      opciones: _opcionesSiNo,
    ),
    // ── Orientación (6) ───────────────────────────────────────────
    Pregunta(
      texto: 'Orientación — Fecha del día: ¿la indicó correctamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Orientación — Mes: ¿lo indicó correctamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Orientación — Año: ¿lo indicó correctamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Orientación — Día de la semana: ¿lo indicó correctamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Orientación — Lugar: ¿lo indicó correctamente?',
      opciones: _opcionesSiNo,
    ),
    Pregunta(
      texto: 'Orientación — Ciudad: ¿la indicó correctamente?',
      opciones: _opcionesSiNo,
    ),
  ],

  preguntasComplementarias: [
    Pregunta(
      texto: 'Ajuste educacional: ¿la persona tiene 12 años de escolaridad '
          'o menos? (De ser así se suma 1 punto, máximo 30)',
      opciones: _opcionesSiNo,
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 26,
      maximo: 30,
      etiqueta: 'Dentro de lo esperado',
      descripcion: 'Puntuación en el rango normal según el punto de corte '
          'publicado (≥ 26).',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 0,
      maximo: 25,
      etiqueta: 'Por debajo del punto de corte',
      descripcion: 'Puntuación < 26: sugiere posible deterioro cognitivo. '
          'Se recomienda evaluación clínica.',
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'visuoespacial',
      nombre: 'Visuoespacial / Ejecutiva',
      descripcion: 'Recorrido, copia del cubo y reloj (5 puntos).',
      indicesPregunta: [0, 1, 2, 3, 4],
      rangos: _descriptivo5,
    ),
    SubescalaPuntuacion(
      id: 'denominacion',
      nombre: 'Denominación',
      descripcion: 'Identificación de figuras (3 puntos).',
      indicesPregunta: [5, 6, 7],
      rangos: _descriptivo3,
    ),
    SubescalaPuntuacion(
      id: 'memoria',
      nombre: 'Memoria',
      descripcion: 'Recuerdo diferido de las 5 palabras (5 puntos).',
      indicesPregunta: [8, 9, 10, 11, 12],
      rangos: _descriptivo5,
    ),
    SubescalaPuntuacion(
      id: 'atencion',
      nombre: 'Atención',
      descripcion: 'Dígitos, vigilancia y serie de 7 (6 puntos).',
      indicesPregunta: [13, 14, 15, 16],
      rangos: _descriptivo6,
    ),
    SubescalaPuntuacion(
      id: 'lenguaje',
      nombre: 'Lenguaje',
      descripcion: 'Repetición de frases y fluidez verbal (3 puntos).',
      indicesPregunta: [17, 18, 19],
      rangos: _descriptivo3,
    ),
    SubescalaPuntuacion(
      id: 'abstraccion',
      nombre: 'Abstracción',
      descripcion: 'Semejanzas (2 puntos).',
      indicesPregunta: [20, 21],
      rangos: _descriptivo2,
    ),
    SubescalaPuntuacion(
      id: 'orientacion',
      nombre: 'Orientación',
      descripcion: 'Tiempo y lugar (6 puntos).',
      indicesPregunta: [22, 23, 24, 25, 26, 27],
      rangos: _descriptivo6,
    ),
  ],
  nota: 'La MoCA es un instrumento con derechos de autor (mocacognition.com). '
      'Esta pantalla es solo una hoja de puntuación y NO sustituye el '
      'material oficial de administración. Punto de corte publicado: < 26 '
      'sugiere deterioro cognitivo; se suma 1 punto si la escolaridad es '
      '≤ 12 años (máximo 30).',
);


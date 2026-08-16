import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del PANAS (intensidad 1-5).
const List<OpcionRespuesta> _opcionesPanas = [
  OpcionRespuesta(etiqueta: 'Muy poco o nada', valor: 1),
  OpcionRespuesta(etiqueta: 'Un poco', valor: 2),
  OpcionRespuesta(etiqueta: 'Moderadamente', valor: 3),
  OpcionRespuesta(etiqueta: 'Bastante', valor: 4),
  OpcionRespuesta(etiqueta: 'Extremadamente', valor: 5),
];

/// Bandas referenciales de las subescalas del PANAS (10-50).
/// Bandas descriptivas de las subescalas del PANAS (10-50).
const List<RangoPuntuacion> _bandasPanas = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 10,
    maximo: 50,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte normativos publicados.',
    descriptiva: true,
  ),
];

/// PANAS: Escala de Afecto Positivo y Negativo
/// (Watson, Clark y Tellegen, 1988).
///
/// Mide el afecto positivo (10 ítems) y negativo (10 ítems) durante el
/// último mes. Cada subescala se interpreta por separado.
const InstrumentoAplicable panasAplicable = InstrumentoAplicable(
  id: 'panas',
  sigla: 'PANAS',
  titulo: 'Escala de Afecto Positivo y Negativo',
  instrucciones: 'En general (durante el último mes), ¿en qué medida se ha '
      'sentido de la siguiente manera?',
  preguntas: [
    Pregunta(texto: 'Interesado(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Angustiado(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Ilusionado(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Molesto(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Fuerte', opciones: _opcionesPanas),
    Pregunta(texto: 'Culpable', opciones: _opcionesPanas),
    Pregunta(texto: 'Asustado(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Hostil', opciones: _opcionesPanas),
    Pregunta(texto: 'Entusiasmado(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Orgulloso(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Irritable', opciones: _opcionesPanas),
    Pregunta(texto: 'Alerta', opciones: _opcionesPanas),
    Pregunta(texto: 'Avergonzado(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Inspirado(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Nervioso(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Decidido(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Atento(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Inquieto(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Activo(a)', opciones: _opcionesPanas),
    Pregunta(texto: 'Temeroso(a)', opciones: _opcionesPanas),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 20,
      maximo: 100,
      etiqueta: 'Ver subescalas',
      descripcion: 'Este instrumento se interpreta por subescalas.',
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'afecto-positivo',
      nombre: 'Afecto positivo',
      descripcion: 'Puntuaciones más altas indican mayor afecto positivo '
          '(emociones placenteras).',
      indicesPregunta: [0, 2, 4, 8, 9, 11, 13, 15, 16, 18],
      rangos: _bandasPanas,
    ),
    SubescalaPuntuacion(
      id: 'afecto-negativo',
      nombre: 'Afecto negativo',
      descripcion: 'Puntuaciones más altas indican mayor afecto negativo '
          '(malestar emocional).',
      indicesPregunta: [1, 3, 5, 6, 7, 10, 12, 14, 17, 19],
      rangos: _bandasPanas,
    ),
  ],
  mostrarPuntuacionTotal: false,
  nota: 'El PANAS es una medida descriptiva del afecto, sin puntos de '
      'corte clínicos. Libre uso en investigación (cita del autor).',
);

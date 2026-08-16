import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del MSPSS (acuerdo 1-7).
const List<OpcionRespuesta> _opcionesMspss = [
  OpcionRespuesta(etiqueta: 'Muy en desacuerdo', valor: 1),
  OpcionRespuesta(etiqueta: 'En desacuerdo', valor: 2),
  OpcionRespuesta(etiqueta: 'Ligeramente en desacuerdo', valor: 3),
  OpcionRespuesta(etiqueta: 'Ni de acuerdo ni en desacuerdo', valor: 4),
  OpcionRespuesta(etiqueta: 'Ligeramente de acuerdo', valor: 5),
  OpcionRespuesta(etiqueta: 'De acuerdo', valor: 6),
  OpcionRespuesta(etiqueta: 'Muy de acuerdo', valor: 7),
];

/// Bandas descriptivas de cada subescala del MSPSS (4-28).
const List<RangoPuntuacion> _bandasSubescala = [
  RangoPuntuacion(
    nivel: 0,
    minimo: 4,
    maximo: 28,
    etiqueta: 'Descriptivo',
    descripcion: 'Sin puntos de corte normativos publicados.',
    descriptiva: true,
  ),
];

/// MSPSS: Escala Multidimensional de Apoyo Social Percibido
/// (Zimet et al., 1988).
///
/// Evalúa el apoyo social percibido de la familia, los amigos y otras
/// personas significativas.
const InstrumentoAplicable mspssAplicable = InstrumentoAplicable(
  id: 'mspss',
  sigla: 'MSPSS',
  titulo: 'Escala Multidimensional de Apoyo Social Percibido',
  instrucciones: 'Indique su grado de acuerdo con cada afirmación.',
  preguntas: [
    Pregunta(
        texto: 'Hay una persona especial que está cerca cuando la necesito',
        opciones: _opcionesMspss),
    Pregunta(
        texto:
            'Hay una persona especial con quien puedo compartir mis alegrías y tristezas',
        opciones: _opcionesMspss),
    Pregunta(
        texto: 'Mi familia realmente trata de ayudarme',
        opciones: _opcionesMspss),
    Pregunta(
        texto:
            'Recibo de mi familia la ayuda emocional y el apoyo que necesito',
        opciones: _opcionesMspss),
    Pregunta(
        texto:
            'Tengo una persona especial que es una verdadera fuente de consuelo para mí',
        opciones: _opcionesMspss),
    Pregunta(
        texto: 'Mis amigos realmente tratan de ayudarme',
        opciones: _opcionesMspss),
    Pregunta(
        texto: 'Puedo contar con mis amigos cuando las cosas van mal',
        opciones: _opcionesMspss),
    Pregunta(
        texto: 'Puedo hablar de mis problemas con mi familia',
        opciones: _opcionesMspss),
    Pregunta(
        texto:
            'Tengo amigos con quienes puedo compartir mis alegrías y tristezas',
        opciones: _opcionesMspss),
    Pregunta(
        texto:
            'Hay una persona especial en mi vida que se preocupa por mis sentimientos',
        opciones: _opcionesMspss),
    Pregunta(
        texto: 'Mi familia está dispuesta a ayudarme para tomar decisiones',
        opciones: _opcionesMspss),
    Pregunta(
        texto: 'Puedo hablar de mis problemas con mis amigos',
        opciones: _opcionesMspss),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 12,
      maximo: 84,
      etiqueta: 'Descriptivo',
      descripcion: 'Sin puntos de corte normativos publicados.',
      descriptiva: true,
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'familia',
      nombre: 'Apoyo de la familia',
      descripcion: 'Apoyo percibido de la familia (4-28).',
      indicesPregunta: [2, 3, 7, 10],
      rangos: _bandasSubescala,
    ),
    SubescalaPuntuacion(
      id: 'amigos',
      nombre: 'Apoyo de los amigos',
      descripcion: 'Apoyo percibido de los amigos (4-28).',
      indicesPregunta: [5, 6, 8, 11],
      rangos: _bandasSubescala,
    ),
    SubescalaPuntuacion(
      id: 'persona-especial',
      nombre: 'Apoyo de persona especial',
      descripcion: 'Apoyo percibido de otra persona significativa (4-28).',
      indicesPregunta: [0, 1, 4, 9],
      rangos: _bandasSubescala,
    ),
  ],
  nota: 'El MSPSS es una medida descriptiva del apoyo social percibido, '
      'sin puntos de corte clínicos estrictos. Gratuito para investigación '
      'con cita del autor.',
);

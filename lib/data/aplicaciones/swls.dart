import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del SWLS (acuerdo 1-7).
const List<OpcionRespuesta> _opcionesSwls = [
  OpcionRespuesta(etiqueta: 'Muy en desacuerdo', valor: 1),
  OpcionRespuesta(etiqueta: 'En desacuerdo', valor: 2),
  OpcionRespuesta(etiqueta: 'Ligeramente en desacuerdo', valor: 3),
  OpcionRespuesta(etiqueta: 'Ni de acuerdo ni en desacuerdo', valor: 4),
  OpcionRespuesta(etiqueta: 'Ligeramente de acuerdo', valor: 5),
  OpcionRespuesta(etiqueta: 'De acuerdo', valor: 6),
  OpcionRespuesta(etiqueta: 'Muy de acuerdo', valor: 7),
];

/// SWLS: Escala de Satisfacción con la Vida (Diener et al., 1985).
const InstrumentoAplicable swlsAplicable = InstrumentoAplicable(
  id: 'swls',
  sigla: 'SWLS',
  titulo: 'Escala de Satisfacción con la Vida',
  instrucciones: 'Indique su grado de acuerdo con cada afirmación.',
  preguntas: [
    Pregunta(
        texto: 'En la mayoría de los aspectos, mi vida se acerca a mi ideal',
        opciones: _opcionesSwls),
    Pregunta(
        texto: 'Las condiciones de mi vida son excelentes',
        opciones: _opcionesSwls),
    Pregunta(texto: 'Estoy satisfecho(a) con mi vida', opciones: _opcionesSwls),
    Pregunta(
        texto:
            'Hasta ahora he conseguido las cosas importantes que quiero en la vida',
        opciones: _opcionesSwls),
    Pregunta(
        texto: 'Si pudiera vivir mi vida de nuevo, no cambiaría casi nada',
        opciones: _opcionesSwls),
  ],
  rangos: [
    RangoPuntuacion(
        nivel: 0,
        minimo: 5,
        maximo: 9,
        etiqueta: 'Muy insatisfecho',
        descripcion: 'Extremadamente insatisfecho(a) con la vida.'),
    RangoPuntuacion(
        nivel: 1,
        minimo: 10,
        maximo: 14,
        etiqueta: 'Insatisfecho',
        descripcion: 'Insatisfecho(a) con la vida.'),
    RangoPuntuacion(
        nivel: 2,
        minimo: 15,
        maximo: 19,
        etiqueta: 'Ligeramente insatisfecho',
        descripcion: 'Ligeramente insatisfecho(a) con la vida.'),
    RangoPuntuacion(
        nivel: 3,
        minimo: 20,
        maximo: 20,
        etiqueta: 'Neutro',
        descripcion: 'Ni satisfecho(a) ni insatisfecho(a) con la vida.'),
    RangoPuntuacion(
        nivel: 4,
        minimo: 21,
        maximo: 25,
        etiqueta: 'Ligeramente satisfecho',
        descripcion: 'Ligeramente satisfecho(a) con la vida.'),
    RangoPuntuacion(
        nivel: 5,
        minimo: 26,
        maximo: 30,
        etiqueta: 'Satisfecho',
        descripcion: 'Satisfecho(a) con la vida.'),
    RangoPuntuacion(
        nivel: 6,
        minimo: 31,
        maximo: 35,
        etiqueta: 'Muy satisfecho',
        descripcion: 'Muy satisfecho(a) con la vida.'),
  ],
  nota: 'La SWLS mide la satisfacción vital. Las bandas de interpretación '
      'son las publicadas por el autor del instrumento: Diener, E., '
      'Emmons, R. A., Larsen, R. J., & Griffin, S. (1985). The '
      'Satisfaction With Life Scale. Journal of Personality Assessment, '
      '49(1), 71-75. Libre uso no comercial.',
);

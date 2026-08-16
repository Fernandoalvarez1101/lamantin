import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del LOT-R (acuerdo 0-4).
const List<OpcionRespuesta> _opcionesLotr = [
  OpcionRespuesta(etiqueta: 'Muy en desacuerdo', valor: 0),
  OpcionRespuesta(etiqueta: 'En desacuerdo', valor: 1),
  OpcionRespuesta(etiqueta: 'Ni de acuerdo ni en desacuerdo', valor: 2),
  OpcionRespuesta(etiqueta: 'De acuerdo', valor: 3),
  OpcionRespuesta(etiqueta: 'Muy de acuerdo', valor: 4),
];

/// LOT-R: Test de Orientación Vital-Revisado (Scheier y Carver, 1994).
///
/// Mide el optimismo disposicional. Los ítems 3, 7 y 9 se puntúan de
/// forma invertida; los ítems 2, 5, 6 y 8 son de relleno y no puntúan.
const InstrumentoAplicable lotrAplicable = InstrumentoAplicable(
  id: 'lot-r',
  sigla: 'LOT-R',
  titulo: 'Test de Orientación Vital-Revisado',
  instrucciones: 'Indique su grado de acuerdo con cada afirmación.',
  preguntas: [
    Pregunta(
        texto: 'En tiempos difíciles, suelo esperar lo mejor',
        opciones: _opcionesLotr),
    Pregunta(
        texto: 'Me resulta fácil relajarme',
        opciones: _opcionesLotr,
        puntuable: false),
    Pregunta(
        texto:
            'Si algo malo tiene que pasarme, estoy seguro(a) de que me pasará',
        opciones: _opcionesLotr,
        invertida: true),
    Pregunta(
        texto: 'Siempre soy optimista sobre mi futuro',
        opciones: _opcionesLotr),
    Pregunta(
        texto: 'Me divierto mucho con mis amigos',
        opciones: _opcionesLotr,
        puntuable: false),
    Pregunta(
        texto: 'Para mí es importante mantenerme ocupado(a)',
        opciones: _opcionesLotr,
        puntuable: false),
    Pregunta(
        texto: 'Casi nunca espero que las cosas salgan a mi favor',
        opciones: _opcionesLotr,
        invertida: true),
    Pregunta(
        texto: 'No me molesto con facilidad',
        opciones: _opcionesLotr,
        puntuable: false),
    Pregunta(
        texto: 'Rara vez cuento con que me ocurran cosas buenas',
        opciones: _opcionesLotr,
        invertida: true),
    Pregunta(
        texto: 'En general, espero que me ocurran más cosas buenas que malas',
        opciones: _opcionesLotr),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 13,
      etiqueta: 'Bajo',
      descripcion: 'Nivel de optimismo bajo.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 14,
      maximo: 18,
      etiqueta: 'Moderado',
      descripcion: 'Nivel de optimismo moderado.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 19,
      maximo: 24,
      etiqueta: 'Alto',
      descripcion: 'Nivel de optimismo alto.',
    ),
  ],
  nota: 'El LOT-R es una medida descriptiva del optimismo, sin puntos de '
      'corte clínicos. 4 ítems son de relleno y no se puntúan. Libre uso '
      'en investigación (cita del autor).',
);

import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del RSES (acuerdo 1-4).
const List<OpcionRespuesta> _opcionesRses = [
  OpcionRespuesta(etiqueta: 'Muy en desacuerdo', valor: 1),
  OpcionRespuesta(etiqueta: 'En desacuerdo', valor: 2),
  OpcionRespuesta(etiqueta: 'De acuerdo', valor: 3),
  OpcionRespuesta(etiqueta: 'Muy de acuerdo', valor: 4),
];

/// RSES: Escala de Autoestima de Rosenberg (1965).
///
/// Mide la autoestima global. Los ítems 3, 5, 8, 9 y 10 se puntúan de
/// forma invertida. Rango de 10 a 40; a mayor puntuación, mayor
/// autoestima.
const InstrumentoAplicable rsesAplicable = InstrumentoAplicable(
  id: 'rses',
  sigla: 'RSES',
  titulo: 'Escala de Autoestima de Rosenberg',
  instrucciones: 'Indique su grado de acuerdo con cada afirmación.',
  preguntas: [
    Pregunta(
        texto:
            'Siento que soy una persona digna de aprecio, al menos en igual medida que los demás',
        opciones: _opcionesRses),
    Pregunta(
        texto: 'Siento que tengo muchas cualidades buenas',
        opciones: _opcionesRses),
    Pregunta(
        texto: 'En general, me inclino a pensar que soy un fracasado(a)',
        opciones: _opcionesRses,
        invertida: true),
    Pregunta(
        texto:
            'Soy capaz de hacer las cosas tan bien como la mayoría de las personas',
        opciones: _opcionesRses),
    Pregunta(
        texto: 'Siento que no tengo mucho de qué estar orgulloso(a)',
        opciones: _opcionesRses,
        invertida: true),
    Pregunta(
        texto: 'Tengo una actitud positiva hacia mí mismo(a)',
        opciones: _opcionesRses),
    Pregunta(
        texto: 'En general, estoy satisfecho(a) conmigo mismo(a)',
        opciones: _opcionesRses),
    Pregunta(
        texto: 'Desearía poder respetarme más a mí mismo(a)',
        opciones: _opcionesRses,
        invertida: true),
    Pregunta(
        texto: 'Ciertamente me siento inútil a veces',
        opciones: _opcionesRses,
        invertida: true),
    Pregunta(
        texto: 'A veces pienso que no soy bueno(a) en nada',
        opciones: _opcionesRses,
        invertida: true),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 10,
      maximo: 40,
      etiqueta: 'Descriptivo',
      descripcion: 'Sin puntos de corte normativos publicados para '
          'población hispanohablante.',
      descriptiva: true,
    ),
  ],
  nota: 'El RSES es una medida descriptiva de la autoestima global. No '
      'existen puntos de corte clínicos universales publicados; se '
      'interpreta por comparación con normas locales cuando se dispone de '
      'ellas. Los ítems 3, 5, 8, 9 y 10 se puntúan de forma invertida. '
      'Libre uso.',
);

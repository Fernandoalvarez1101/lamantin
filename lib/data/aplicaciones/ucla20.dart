import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta de la UCLA-20 (frecuencia 1-4).
const List<OpcionRespuesta> _opcionesUcla = [
  OpcionRespuesta(etiqueta: 'Nunca', valor: 1),
  OpcionRespuesta(etiqueta: 'Rara vez', valor: 2),
  OpcionRespuesta(etiqueta: 'A veces', valor: 3),
  OpcionRespuesta(etiqueta: 'Siempre', valor: 4),
];

/// UCLA-20: Escala de Soledad de UCLA, versión 3 (Russell, 1996).
///
/// Mide la percepción subjetiva de soledad. Los ítems formulados en
/// positivo (1, 5, 6, 9, 10, 12, 15, 16, 19 y 20) se puntúan de forma
/// invertida. Rango de 20 a 80; a mayor puntuación, mayor soledad.
const InstrumentoAplicable ucla20Aplicable = InstrumentoAplicable(
  id: 'ucla-20',
  sigla: 'UCLA-20',
  titulo: 'Escala de Soledad de UCLA (versión 3)',
  instrucciones: 'Indique con qué frecuencia siente lo que se describe en '
      'cada afirmación.',
  preguntas: [
    Pregunta(
        texto: 'Siento que estoy "en sintonía" con la gente que me rodea',
        opciones: _opcionesUcla,
        invertida: true),
    Pregunta(texto: 'Siento que me falta compañía', opciones: _opcionesUcla),
    Pregunta(
        texto: 'Siento que no tengo a nadie con quien hablar',
        opciones: _opcionesUcla),
    Pregunta(texto: 'Me siento solo(a)', opciones: _opcionesUcla),
    Pregunta(
        texto: 'Siento que formo parte de un grupo de amigos',
        opciones: _opcionesUcla,
        invertida: true),
    Pregunta(
        texto: 'Siento que tengo mucho en común con la gente que me rodea',
        opciones: _opcionesUcla,
        invertida: true),
    Pregunta(
        texto: 'Siento que ya no tengo confianza con nadie',
        opciones: _opcionesUcla),
    Pregunta(
        texto:
            'Siento que mis intereses e ideas no son compartidos por la gente que me rodea',
        opciones: _opcionesUcla),
    Pregunta(
        texto: 'Me siento extrovertido(a) y amistoso(a)',
        opciones: _opcionesUcla,
        invertida: true),
    Pregunta(
        texto: 'Me siento cercano(a) a la gente',
        opciones: _opcionesUcla,
        invertida: true),
    Pregunta(texto: 'Me siento dejado(a) de lado', opciones: _opcionesUcla),
    Pregunta(
        texto: 'Siento que mis relaciones con los demás son significativas',
        opciones: _opcionesUcla,
        invertida: true),
    Pregunta(
        texto: 'Siento que nadie me conoce realmente bien',
        opciones: _opcionesUcla),
    Pregunta(
        texto: 'Me siento aislado(a) de los demás', opciones: _opcionesUcla),
    Pregunta(
        texto: 'Encuentro compañía cuando la deseo',
        opciones: _opcionesUcla,
        invertida: true),
    Pregunta(
        texto: 'Siento que hay gente que me entiende realmente',
        opciones: _opcionesUcla,
        invertida: true),
    Pregunta(texto: 'Me siento tímido(a)', opciones: _opcionesUcla),
    Pregunta(
        texto: 'Siento que la gente me rodea, pero no está conmigo',
        opciones: _opcionesUcla),
    Pregunta(
        texto: 'Siento que hay gente con quien puedo hablar',
        opciones: _opcionesUcla,
        invertida: true),
    Pregunta(
        texto: 'Siento que hay gente a la que puedo recurrir',
        opciones: _opcionesUcla,
        invertida: true),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 20,
      maximo: 80,
      etiqueta: 'Descriptivo',
      descripcion: 'Sin puntos de corte clínicos normativos publicados.',
      descriptiva: true,
    ),
  ],
  nota: 'La UCLA-20 es una medida descriptiva de la soledad percibida. No '
      'existen puntos de corte clínicos universales publicados; se '
      'interpreta por comparación con normas locales cuando se dispone de '
      'ellas. Los ítems positivos se puntúan de forma invertida. Libre uso '
      'en investigación (cita del autor).',
);

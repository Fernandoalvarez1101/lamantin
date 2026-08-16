import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del PSWQ (tipicidad 1-5).
const List<OpcionRespuesta> _opcionesPswq = [
  OpcionRespuesta(etiqueta: 'Nada típico en mí', valor: 1),
  OpcionRespuesta(etiqueta: 'Poco típico en mí', valor: 2),
  OpcionRespuesta(etiqueta: 'Algo típico en mí', valor: 3),
  OpcionRespuesta(etiqueta: 'Muy típico en mí', valor: 4),
  OpcionRespuesta(etiqueta: 'Totalmente típico en mí', valor: 5),
];

/// PSWQ: Penn State Worry Questionnaire (Meyer et al., 1990).
///
/// Mide la tendencia a la preocupación patológica o excesiva (rasgo).
/// Los ítems 1, 3, 8, 10 y 11 se puntúan de forma invertida.
const InstrumentoAplicable pswqAplicable = InstrumentoAplicable(
  id: 'pswq',
  sigla: 'PSWQ',
  titulo: 'Cuestionario de Preocupación de Penn State',
  instrucciones: 'Indique qué tan típico es para usted cada enunciado.',
  preguntas: [
    Pregunta(
        texto:
            'Si no tengo tiempo suficiente para hacerlo todo, no me preocupo por ello',
        opciones: _opcionesPswq,
        invertida: true),
    Pregunta(texto: 'Mis preocupaciones me abruman', opciones: _opcionesPswq),
    Pregunta(
        texto: 'No suelo preocuparme por las cosas',
        opciones: _opcionesPswq,
        invertida: true),
    Pregunta(
        texto: 'Muchas situaciones me hacen preocuparme',
        opciones: _opcionesPswq),
    Pregunta(
        texto:
            'Sé que no debería preocuparme por las cosas, pero no puedo evitarlo',
        opciones: _opcionesPswq),
    Pregunta(
        texto: 'Cuando estoy bajo presión, me preocupo mucho',
        opciones: _opcionesPswq),
    Pregunta(
        texto: 'Siempre estoy preocupándome por algo', opciones: _opcionesPswq),
    Pregunta(
        texto: 'Me resulta fácil dejar de lado los pensamientos preocupantes',
        opciones: _opcionesPswq,
        invertida: true),
    Pregunta(
        texto:
            'En cuanto termino una tarea, empiezo a preocuparme por todo lo demás',
        opciones: _opcionesPswq),
    Pregunta(
        texto: 'Nunca me preocupo por nada',
        opciones: _opcionesPswq,
        invertida: true),
    Pregunta(
        texto:
            'Cuando ya no puedo hacer nada más sobre una preocupación, no me preocupo',
        opciones: _opcionesPswq,
        invertida: true),
    Pregunta(
        texto: 'He sido una persona preocupona toda mi vida',
        opciones: _opcionesPswq),
    Pregunta(
        texto: 'Me doy cuenta de que he estado preocupándome por las cosas',
        opciones: _opcionesPswq),
    Pregunta(
        texto: 'Una vez que empiezo a preocuparme, no puedo parar',
        opciones: _opcionesPswq),
    Pregunta(texto: 'Me preocupo todo el tiempo', opciones: _opcionesPswq),
    Pregunta(
        texto: 'Me preocupo por los proyectos hasta que están terminados',
        opciones: _opcionesPswq),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 16,
      maximo: 80,
      etiqueta: 'Descriptivo',
      descripcion: 'Sin punto de corte normativo universal publicado.',
      descriptiva: true,
    ),
  ],
  nota: 'El PSWQ es una medida descriptiva de la tendencia a la '
      'preocupación. No existe un punto de corte clínico universal '
      'publicado (los estudios utilizan umbrales variables, p. ej. ≥ 45 '
      'o ≥ 60 según la muestra); se interpreta por comparación con normas '
      'de investigación. La puntuación va de 16 a 80. Los ítems 1, 3, 8, '
      '10 y 11 se puntúan de forma invertida.',
);

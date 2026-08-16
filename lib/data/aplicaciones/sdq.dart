import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del SDQ (0-2).
const List<OpcionRespuesta> _opcionesSdq = [
  OpcionRespuesta(etiqueta: 'No es cierto', valor: 0),
  OpcionRespuesta(etiqueta: 'Un tanto cierto', valor: 1),
  OpcionRespuesta(etiqueta: 'Es cierto', valor: 2),
];

/// Bandas de cada subescala del SDQ (0-10).
const List<RangoPuntuacion> _bandasSubescala = [
  RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 6,
      etiqueta: 'Normal',
      descripcion: 'Dentro del rango normal.'),
  RangoPuntuacion(
      nivel: 1,
      minimo: 7,
      maximo: 8,
      etiqueta: 'Límite',
      descripcion: 'En el límite. Se recomienda seguimiento.'),
  RangoPuntuacion(
      nivel: 2,
      minimo: 9,
      maximo: 10,
      etiqueta: 'Anormal',
      descripcion: 'Por encima del rango normal.'),
];

/// Bandas de la escala prosocial (mayor = mejor).
const List<RangoPuntuacion> _bandasProsocial = [
  RangoPuntuacion(
      nivel: 0,
      minimo: 6,
      maximo: 10,
      etiqueta: 'Normal',
      descripcion: 'Dentro del rango normal.'),
  RangoPuntuacion(
      nivel: 1,
      minimo: 5,
      maximo: 5,
      etiqueta: 'Límite',
      descripcion: 'En el límite.'),
  RangoPuntuacion(
      nivel: 2,
      minimo: 0,
      maximo: 4,
      etiqueta: 'Anormal',
      descripcion: 'Conducta prosocial baja.'),
];

/// SDQ: Cuestionario de Capacidades y Dificultades (Goodman, 1997).
///
/// Cribado de problemas emocionales, de conducta, hiperactividad,
/// relación con los compañeros y conducta prosocial. La puntuación total
/// de dificultades suma las 4 primeras subescalas (0-40).
const InstrumentoAplicable sdqAplicable = InstrumentoAplicable(
  id: 'sdq',
  sigla: 'SDQ',
  titulo: 'Cuestionario de Capacidades y Dificultades',
  instrucciones: 'Responda según cómo ha sido el comportamiento del niño(a) '
      'durante los últimos 6 meses.',
  preguntas: [
    Pregunta(
        texto: 'Tomo en cuenta los sentimientos de otras personas',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'No me quedo quieto(a); soy inquieto(a), me muevo mucho',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Me dan muchos dolores de cabeza, de estómago o náuseas',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Normalmente comparto con otros (galletas, juguetes, lápices)',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Me enojo mucho y pierdo el control', opciones: _opcionesSdq),
    Pregunta(
        texto:
            'Estoy casi siempre solo(a); por lo general juego solo(a) o me mantengo apartado(a)',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Por lo general hago lo que me dicen',
        opciones: _opcionesSdq,
        invertida: true),
    Pregunta(texto: 'Me preocupo mucho', opciones: _opcionesSdq),
    Pregunta(
        texto: 'Ayudo si alguien está herido, disgustado o se siente mal',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Estoy constantemente inquieto(a) o retorciéndome',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Tengo un(a) buen(a) amigo(a) o amigos(as)',
        opciones: _opcionesSdq,
        invertida: true),
    Pregunta(
        texto: 'Peleo mucho; puedo obligar a otros a hacer lo que yo quiero',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'A menudo me siento triste, desanimado(a) o lloroso(a)',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Por lo general los demás de mi edad me caen bien',
        opciones: _opcionesSdq,
        invertida: true),
    Pregunta(
        texto: 'Me distraigo con facilidad; me cuesta concentrarme',
        opciones: _opcionesSdq),
    Pregunta(
        texto:
            'Me siento nervioso(a) en situaciones nuevas; fácilmente pierdo la seguridad',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Soy amable con los niños(as) más pequeños(as)',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Con frecuencia me acusan de mentir o engañar',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Los demás niños(as) se meten conmigo o se burlan de mí',
        opciones: _opcionesSdq),
    Pregunta(
        texto:
            'Con frecuencia me ofrezco para ayudar a otras personas (padres, profesores, niños)',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Pienso las cosas antes de hacerlas',
        opciones: _opcionesSdq,
        invertida: true),
    Pregunta(
        texto:
            'Tomo cosas que no son mías de la casa, la escuela u otros lugares',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Me llevo mejor con adultos que con personas de mi edad',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Tengo muchos miedos; me asusto fácilmente',
        opciones: _opcionesSdq),
    Pregunta(
        texto: 'Termino lo que empiezo; tengo buena concentración',
        opciones: _opcionesSdq,
        invertida: true),
  ],
  rangos: [
    RangoPuntuacion(
        nivel: 0,
        minimo: 0,
        maximo: 13,
        etiqueta: 'Normal',
        descripcion: 'Dificultades dentro del rango normal.'),
    RangoPuntuacion(
        nivel: 1,
        minimo: 14,
        maximo: 16,
        etiqueta: 'Límite',
        descripcion: 'Dificultades en el límite. Se recomienda seguimiento.'),
    RangoPuntuacion(
        nivel: 2,
        minimo: 17,
        maximo: 40,
        etiqueta: 'Anormal',
        descripcion: 'Dificultades por encima del rango normal.'),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'emocionales',
      nombre: 'Síntomas emocionales',
      descripcion: 'Síntomas emocionales (0-10).',
      indicesPregunta: [2, 7, 12, 15, 23],
      rangos: _bandasSubescala,
    ),
    SubescalaPuntuacion(
      id: 'conducta',
      nombre: 'Problemas de conducta',
      descripcion: 'Problemas de conducta (0-10).',
      indicesPregunta: [4, 6, 11, 17, 21],
      rangos: _bandasSubescala,
    ),
    SubescalaPuntuacion(
      id: 'hiperactividad',
      nombre: 'Hiperactividad',
      descripcion: 'Hiperactividad e inatención (0-10).',
      indicesPregunta: [1, 9, 14, 20, 24],
      rangos: _bandasSubescala,
    ),
    SubescalaPuntuacion(
      id: 'companeros',
      nombre: 'Problemas con los compañeros',
      descripcion: 'Problemas de relación con los compañeros (0-10).',
      indicesPregunta: [5, 10, 13, 18, 22],
      rangos: _bandasSubescala,
    ),
    SubescalaPuntuacion(
      id: 'prosocial',
      nombre: 'Conducta prosocial',
      descripcion: 'Conducta prosocial (0-10). A mayor puntuación, mejor.',
      indicesPregunta: [0, 3, 8, 16, 19],
      rangos: _bandasProsocial,
    ),
  ],
  calcularPuntuacionPersonalizada: _puntuacionDificultades,
  nota: 'El SDQ es una herramienta de cribado, no un diagnóstico. '
      'Las bandas (normal/límite/anormal) del total y de las subescalas '
      'son las publicadas por el autor: Goodman, R. (1997). The Strengths '
      'and Difficulties Questionnaire: A research note. Journal of Child '
      'Psychology and Psychiatry, 38(5), 581-586 (y bandas oficiales en '
      'sdqinfo.org). Gratuito en papel para uso no comercial.',
);

/// Calcula la puntuación total de dificultades (0-40) sumando las
/// subescalas de síntomas, conducta, hiperactividad y compañeros.
int _puntuacionDificultades(List<int> respuestas) {
  var total = 0;
  for (var i = 0; i < respuestas.length; i++) {
    if (i == 0 || i == 3 || i == 8 || i == 16 || i == 19) continue; // prosocial
    var valor = respuestas[i];
    if (i == 6 || i == 10 || i == 13 || i == 20 || i == 24) {
      valor = 2 - valor;
    }
    total += valor;
  }
  return total;
}

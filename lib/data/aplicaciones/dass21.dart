import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del DASS-21 (frecuencia 0-3).
const List<OpcionRespuesta> _opcionesDass = [
  OpcionRespuesta(etiqueta: 'No me ha ocurrido', valor: 0),
  OpcionRespuesta(
      etiqueta: 'Me ha ocurrido un poco, o durante parte del tiempo', valor: 1),
  OpcionRespuesta(
      etiqueta: 'Me ha ocurrido bastante, o durante una buena parte del tiempo',
      valor: 2),
  OpcionRespuesta(
      etiqueta: 'Me ha ocurrido mucho, o la mayor parte del tiempo', valor: 3),
];

/// Bandas de depresión (puntuación duplicada, 0-42).
const List<RangoPuntuacion> _bandasDepresion = [
  RangoPuntuacion(
      nivel: 0, minimo: 0, maximo: 9, etiqueta: 'Normal', descripcion: ''),
  RangoPuntuacion(
      nivel: 1, minimo: 10, maximo: 13, etiqueta: 'Leve', descripcion: ''),
  RangoPuntuacion(
      nivel: 2, minimo: 14, maximo: 20, etiqueta: 'Moderada', descripcion: ''),
  RangoPuntuacion(
      nivel: 3, minimo: 21, maximo: 27, etiqueta: 'Severa', descripcion: ''),
  RangoPuntuacion(
      nivel: 4,
      minimo: 28,
      maximo: 42,
      etiqueta: 'Muy severa',
      descripcion: ''),
];

/// Bandas de ansiedad (puntuación duplicada, 0-42).
const List<RangoPuntuacion> _bandasAnsiedad = [
  RangoPuntuacion(
      nivel: 0, minimo: 0, maximo: 7, etiqueta: 'Normal', descripcion: ''),
  RangoPuntuacion(
      nivel: 1, minimo: 8, maximo: 9, etiqueta: 'Leve', descripcion: ''),
  RangoPuntuacion(
      nivel: 2, minimo: 10, maximo: 14, etiqueta: 'Moderada', descripcion: ''),
  RangoPuntuacion(
      nivel: 3, minimo: 15, maximo: 19, etiqueta: 'Severa', descripcion: ''),
  RangoPuntuacion(
      nivel: 4,
      minimo: 20,
      maximo: 42,
      etiqueta: 'Muy severa',
      descripcion: ''),
];

/// Bandas de estrés (puntuación duplicada, 0-42).
const List<RangoPuntuacion> _bandasEstres = [
  RangoPuntuacion(
      nivel: 0, minimo: 0, maximo: 14, etiqueta: 'Normal', descripcion: ''),
  RangoPuntuacion(
      nivel: 1, minimo: 15, maximo: 18, etiqueta: 'Leve', descripcion: ''),
  RangoPuntuacion(
      nivel: 2, minimo: 19, maximo: 25, etiqueta: 'Moderada', descripcion: ''),
  RangoPuntuacion(
      nivel: 3, minimo: 26, maximo: 33, etiqueta: 'Severa', descripcion: ''),
  RangoPuntuacion(
      nivel: 4,
      minimo: 34,
      maximo: 42,
      etiqueta: 'Muy severa',
      descripcion: ''),
];

/// DASS-21: Escalas de Depresión, Ansiedad y Estrés (Lovibond y Lovibond,
/// 1995).
///
/// Mide tres estados emocionales negativos durante la última semana. Las
/// puntuaciones de cada subescala se duplican para aplicar los puntos de
/// corte del manual (equivalentes a la versión de 42 ítems).
const InstrumentoAplicable dass21Aplicable = InstrumentoAplicable(
  id: 'dass-21',
  sigla: 'DASS-21',
  titulo: 'Escalas de Depresión, Ansiedad y Estrés',
  instrucciones: 'Durante la última semana, ¿cuánto le ha ocurrido lo '
      'siguiente?',
  preguntas: [
    Pregunta(texto: 'Me costó mucho relajarme', opciones: _opcionesDass),
    Pregunta(
        texto: 'Me di cuenta de que tenía la boca seca',
        opciones: _opcionesDass),
    Pregunta(
        texto: 'No podía sentir ningún sentimiento positivo',
        opciones: _opcionesDass),
    Pregunta(texto: 'Se me hizo difícil respirar', opciones: _opcionesDass),
    Pregunta(
        texto: 'Se me hizo difícil tomar la iniciativa para hacer cosas',
        opciones: _opcionesDass),
    Pregunta(
        texto: 'Reaccioné exageradamente en ciertas situaciones',
        opciones: _opcionesDass),
    Pregunta(
        texto: 'Sentí que me temblaban las manos', opciones: _opcionesDass),
    Pregunta(
        texto: 'Sentí que estaba gastando mucha energía nerviosa',
        opciones: _opcionesDass),
    Pregunta(
        texto:
            'Estaba preocupado(a) por situaciones en las que podía tener pánico o en las que podría hacer el ridículo',
        opciones: _opcionesDass),
    Pregunta(
        texto: 'Tuve la sensación de que no había nada que me ilusionara',
        opciones: _opcionesDass),
    Pregunta(texto: 'Noté que me agitaba', opciones: _opcionesDass),
    Pregunta(texto: 'Se me hizo difícil relajarme', opciones: _opcionesDass),
    Pregunta(texto: 'Me sentí triste y deprimido(a)', opciones: _opcionesDass),
    Pregunta(
        texto:
            'No toleré que nada me impidiera continuar con lo que estaba haciendo',
        opciones: _opcionesDass),
    Pregunta(
        texto: 'Sentí que estaba al punto de pánico', opciones: _opcionesDass),
    Pregunta(texto: 'No pude entusiasmarme con nada', opciones: _opcionesDass),
    Pregunta(
        texto: 'Sentí que valía muy poco como persona',
        opciones: _opcionesDass),
    Pregunta(
        texto: 'Sentí que era bastante susceptible', opciones: _opcionesDass),
    Pregunta(
        texto:
            'Sentí los latidos del corazón a pesar de no haber hecho ningún esfuerzo físico',
        opciones: _opcionesDass),
    Pregunta(texto: 'Tuve miedo sin razón', opciones: _opcionesDass),
    Pregunta(
        texto: 'Sentí que la vida no tenía ningún sentido',
        opciones: _opcionesDass),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 63,
      etiqueta: 'Ver subescalas',
      descripcion: 'Este instrumento se interpreta por subescalas.',
    ),
  ],
  subescalas: [
    SubescalaPuntuacion(
      id: 'depresion',
      nombre: 'Depresión',
      descripcion: 'Disforia, desesperanza y anhedonia. Puntuación '
          'duplicada (0-42).',
      indicesPregunta: [2, 4, 9, 12, 15, 16, 20],
      rangos: _bandasDepresion,
      calcularPuntuacion: _dobleSuma,
    ),
    SubescalaPuntuacion(
      id: 'ansiedad',
      nombre: 'Ansiedad',
      descripcion: 'Activación autonómica y miedo. Puntuación duplicada '
          '(0-42).',
      indicesPregunta: [1, 3, 6, 8, 14, 18, 19],
      rangos: _bandasAnsiedad,
      calcularPuntuacion: _dobleSuma,
    ),
    SubescalaPuntuacion(
      id: 'estres',
      nombre: 'Estrés',
      descripcion: 'Tensión, irritabilidad y dificultad para relajarse. '
          'Puntuación duplicada (0-42).',
      indicesPregunta: [0, 5, 7, 10, 11, 13, 17],
      rangos: _bandasEstres,
      calcularPuntuacion: _dobleSuma,
    ),
  ],
  mostrarPuntuacionTotal: false,
  nota: 'El DASS-21 es una herramienta de cribado, no un diagnóstico. '
      'Las puntuaciones de cada subescala se duplican para aplicar los '
      'puntos de corte del manual de 42 ítems. Gratuito para uso no '
      'comercial (permiso de los autores).',
);

/// Devuelve el doble de la suma de las respuestas en [indices].
int _dobleSuma(List<int> respuestas, List<int> indices) {
  var suma = 0;
  for (final indice in indices) {
    suma += respuestas[indice];
  }
  return suma * 2;
}

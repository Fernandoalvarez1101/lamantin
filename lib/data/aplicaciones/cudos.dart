import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del CUDOS (frecuencia durante la última semana).
const List<OpcionRespuesta> _opcionesCudos = [
  OpcionRespuesta(etiqueta: 'Nada en absoluto', valor: 0),
  OpcionRespuesta(etiqueta: 'Un poco de tiempo', valor: 1),
  OpcionRespuesta(etiqueta: 'Alguna parte del tiempo', valor: 2),
  OpcionRespuesta(etiqueta: 'Buena parte del tiempo', valor: 3),
  OpcionRespuesta(etiqueta: 'Casi todo el tiempo', valor: 4),
];

/// CUDOS: Clinically Useful Depression Outcome Scale (Zimmerman, 2004).
///
/// Evalúa la gravedad de la depresión y su evolución durante el
/// tratamiento. Instrumento de dominio público.
const InstrumentoAplicable cudosAplicable = InstrumentoAplicable(
  id: 'cudos',
  sigla: 'CUDOS',
  titulo: 'Escala Clínica Útil de Resultados en Depresión',
  instrucciones: 'Durante la última semana, ¿con qué frecuencia le ocurrió '
      'lo siguiente?',
  preguntas: [
    Pregunta(
        texto: 'Poco interés o placer en hacer las cosas',
        opciones: _opcionesCudos),
    Pregunta(
        texto: 'Sentirse decaído(a), deprimido(a) o sin esperanza',
        opciones: _opcionesCudos),
    Pregunta(
        texto:
            'Problemas para conciliar el sueño, para mantenerse dormido(a) o dormir demasiado',
        opciones: _opcionesCudos),
    Pregunta(texto: 'Poco apetito o comer en exceso', opciones: _opcionesCudos),
    Pregunta(
        texto: 'Sentirse cansado(a) o con poca energía',
        opciones: _opcionesCudos),
    Pregunta(
        texto:
            'Sentirse mal con usted mismo(a), sentir que es un fracaso o que ha defraudado a su familia',
        opciones: _opcionesCudos),
    Pregunta(texto: 'Problemas para concentrarse', opciones: _opcionesCudos),
    Pregunta(
        texto:
            'Moverse o hablar tan despacio que otros lo notaron, o lo contrario: tan inquieto(a) que se movía mucho más de lo normal',
        opciones: _opcionesCudos),
    Pregunta(
        texto: 'Pensamientos de que estaría mejor muerto(a) o de hacerse daño',
        opciones: _opcionesCudos),
    Pregunta(texto: 'Sentirse culpable', opciones: _opcionesCudos),
    Pregunta(texto: 'Sentirse irritable', opciones: _opcionesCudos),
    Pregunta(texto: 'Sentirse ansioso(a)', opciones: _opcionesCudos),
    Pregunta(texto: 'Sentirse preocupado(a)', opciones: _opcionesCudos),
    Pregunta(
        texto: 'Sentirse desesperanzado(a), sin ayuda',
        opciones: _opcionesCudos),
    Pregunta(texto: 'Sentirse inútil', opciones: _opcionesCudos),
    Pregunta(texto: 'Sentir que no hay futuro', opciones: _opcionesCudos),
    Pregunta(
        texto: 'Sentir que la vida no vale la pena', opciones: _opcionesCudos),
    Pregunta(texto: 'Sentirse abrumado(a)', opciones: _opcionesCudos),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 19,
      etiqueta: 'Mínima',
      descripcion: 'Sintomatología depresiva mínima (remisión clínica '
          'considerada con puntuaciones < 20).',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 20,
      maximo: 29,
      etiqueta: 'Leve',
      descripcion: 'Sintomatología depresiva leve.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 30,
      maximo: 39,
      etiqueta: 'Moderada',
      descripcion: 'Sintomatología depresiva moderada.',
    ),
    RangoPuntuacion(
      nivel: 3,
      minimo: 40,
      maximo: 49,
      etiqueta: 'Severa',
      descripcion: 'Sintomatología depresiva severa.',
    ),
    RangoPuntuacion(
      nivel: 4,
      minimo: 50,
      maximo: 72,
      etiqueta: 'Muy severa',
      descripcion: 'Sintomatología depresiva muy severa.',
    ),
  ],
  alertas: [
    AlertaPregunta(
      numeroPregunta: 9,
      valorMinimo: 1,
      mensaje: 'Se registró una respuesta positiva en el ítem 9 '
          '(pensamientos de muerte o autolesión). Realice una evaluación '
          'inmediata del riesgo de suicidio.',
    ),
    AlertaPregunta(
      numeroPregunta: 17,
      valorMinimo: 1,
      mensaje: 'Se registró una respuesta positiva en el ítem 17 '
          '("la vida no vale la pena"). Valore el riesgo de suicidio en '
          'la entrevista clínica.',
    ),
  ],
  nota: 'El CUDOS es de dominio público. La puntuación va de 0 a 72. '
      'Ítems en adaptación al español; confirmar la traducción con la '
      'publicación original antes de su uso.',
);

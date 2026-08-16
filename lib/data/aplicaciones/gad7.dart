import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del GAD-7 (frecuencia 0-3).
const List<OpcionRespuesta> _opcionesGad7 = [
  OpcionRespuesta(etiqueta: 'Nada en absoluto', valor: 0),
  OpcionRespuesta(etiqueta: 'Varios días', valor: 1),
  OpcionRespuesta(etiqueta: 'Más de la mitad de los días', valor: 2),
  OpcionRespuesta(etiqueta: 'Casi todos los días', valor: 3),
];

/// GAD-7: Generalized Anxiety Disorder-7 (Spitzer et al., 2006).
///
/// Cribado de ansiedad generalizada según los criterios del DSM-5.
/// Instrumento de dominio público.
const InstrumentoAplicable gad7Aplicable = InstrumentoAplicable(
  id: 'gad-7',
  sigla: 'GAD-7',
  titulo: 'Trastorno de Ansiedad Generalizada-7',
  instrucciones: 'Durante las últimas 2 semanas, ¿qué tan seguido le han '
      'molestado los siguientes problemas?',
  preguntas: [
    Pregunta(
        texto: 'Sentirse nervioso(a), ansioso(a) o con los nervios de punta',
        opciones: _opcionesGad7),
    Pregunta(
        texto:
            'No poder dejar de preocuparse o no poder controlar la preocupación',
        opciones: _opcionesGad7),
    Pregunta(
        texto: 'Preocuparse demasiado por diferentes cosas',
        opciones: _opcionesGad7),
    Pregunta(texto: 'Dificultad para relajarse', opciones: _opcionesGad7),
    Pregunta(
        texto:
            'Estar tan inquieto(a) que le es difícil quedarse sentado(a) y tranquilo(a)',
        opciones: _opcionesGad7),
    Pregunta(
        texto: 'Molestarse o irritarse fácilmente', opciones: _opcionesGad7),
    Pregunta(
        texto: 'Sentir miedo, como si algo malo pudiera ocurrir',
        opciones: _opcionesGad7),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 4,
      etiqueta: 'Mínima',
      descripcion: 'Sin o con mínima sintomatología ansiosa.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 5,
      maximo: 9,
      etiqueta: 'Leve',
      descripcion: 'Sintomatología ansiosa leve.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 10,
      maximo: 14,
      etiqueta: 'Moderada',
      descripcion: 'Sintomatología ansiosa moderada. El punto de corte '
          '≥ 10 es el umbral habitual para considerar un probable '
          'trastorno de ansiedad generalizada.',
    ),
    RangoPuntuacion(
      nivel: 3,
      minimo: 15,
      maximo: 21,
      etiqueta: 'Grave',
      descripcion: 'Sintomatología ansiosa grave.',
    ),
  ],
  nota: 'El GAD-7 es una herramienta de cribado, no un diagnóstico. '
      'Una puntuación ≥ 10 se asocia con un probable trastorno de '
      'ansiedad generalizada (sensibilidad 89 %, especificidad 82 %) y '
      'debe confirmarse con una evaluación clínica completa.',
);

import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del SRQ-20 (sí/no).
const List<OpcionRespuesta> _opcionesSiNo = [
  OpcionRespuesta(etiqueta: 'No', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí', valor: 1),
];

/// SRQ-20: Self-Reporting Questionnaire (Harding et al., 1980; OMS).
///
/// Cribado de trastornos mentales comunes en atención primaria.
const InstrumentoAplicable srq20Aplicable = InstrumentoAplicable(
  id: 'srq-20',
  sigla: 'SRQ-20',
  titulo: 'Cuestionario de Autoreporte',
  instrucciones: 'Responda sí o no según cómo se ha sentido durante el '
      'último mes.',
  preguntas: [
    Pregunta(
        texto: '¿Sufre usted de dolores de cabeza con frecuencia?',
        opciones: _opcionesSiNo),
    Pregunta(texto: '¿Tiene mal apetito?', opciones: _opcionesSiNo),
    Pregunta(texto: '¿Duerme mal?', opciones: _opcionesSiNo),
    Pregunta(texto: '¿Se asusta con facilidad?', opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Sufre de temblores en las manos?', opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Se siente nervioso(a), tenso(a) o preocupado(a)?',
        opciones: _opcionesSiNo),
    Pregunta(texto: '¿Sufre de mala digestión?', opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Tiene dificultad para pensar con claridad?',
        opciones: _opcionesSiNo),
    Pregunta(texto: '¿Se siente triste?', opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Llora usted con mucha frecuencia?', opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Le cuesta disfrutar de sus actividades diarias?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Tiene dificultades para tomar decisiones?',
        opciones: _opcionesSiNo),
    Pregunta(texto: '¿Le cuesta realizar su trabajo?', opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Es incapaz de desempeñar un papel útil en su vida?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Ha perdido interés en las cosas?', opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Siente que es una persona que no vale nada?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Ha tenido la idea de acabar con su vida?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Se siente cansado(a) todo el tiempo?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Sufre de sensaciones desagradables en el estómago?',
        opciones: _opcionesSiNo),
    Pregunta(texto: '¿Se cansa con facilidad?', opciones: _opcionesSiNo),
  ],
  rangos: [
    RangoPuntuacion(
        nivel: 0,
        minimo: 0,
        maximo: 6,
        etiqueta: 'Bajo',
        descripcion: 'Probabilidad baja de trastorno mental común.'),
    RangoPuntuacion(
        nivel: 1,
        minimo: 7,
        maximo: 20,
        etiqueta: 'Probable trastorno mental',
        descripcion:
            'Puntuación ≥ 7-8 (según el punto de corte del contexto): probable trastorno mental común. Se recomienda evaluación.'),
  ],
  alertas: [
    AlertaPregunta(
      numeroPregunta: 17,
      valorMinimo: 1,
      mensaje: 'Se registró ideación de acabar con su vida (ítem 17). '
          'Realice una evaluación inmediata del riesgo de suicidio.',
    ),
  ],
  nota: 'El SRQ-20 es una herramienta de cribado, no un diagnóstico. '
      'El punto de corte habitual es ≥ 7-8. Instrumento de la OMS.',
);

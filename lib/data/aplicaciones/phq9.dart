import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del PHQ-9 (escala Likert 0-3).
const List<OpcionRespuesta> _opcionesPhq9 = [
  OpcionRespuesta(etiqueta: 'Nada en absoluto', valor: 0),
  OpcionRespuesta(etiqueta: 'Varios días', valor: 1),
  OpcionRespuesta(etiqueta: 'Más de la mitad de los días', valor: 2),
  OpcionRespuesta(etiqueta: 'Casi todos los días', valor: 3),
];

/// PHQ-9 (Patient Health Questionnaire-9): cribado de depresión.
///
/// Ítems en su versión en español y bandas de severidad estándar
/// (Kroenke, Spitzer y Williams, 2001).
const InstrumentoAplicable phq9Aplicable = InstrumentoAplicable(
  id: 'phq-9',
  sigla: 'PHQ-9',
  titulo: 'Cuestionario de Salud del Paciente-9',
  instrucciones: 'Durante las últimas 2 semanas, ¿qué tan seguido le han '
      'molestado los siguientes problemas?',
  preguntas: [
    Pregunta(
      texto: 'Poco interés o placer en hacer las cosas',
      opciones: _opcionesPhq9,
    ),
    Pregunta(
      texto: 'Se ha sentido decaído(a), deprimido(a) o sin esperanza',
      opciones: _opcionesPhq9,
    ),
    Pregunta(
      texto: 'Problemas para conciliar el sueño, para mantenerse '
          'dormido(a), o dormir demasiado',
      opciones: _opcionesPhq9,
    ),
    Pregunta(
      texto: 'Se ha sentido cansado(a) o con poca energía',
      opciones: _opcionesPhq9,
    ),
    Pregunta(
      texto: 'Sin apetito o ha comido en exceso',
      opciones: _opcionesPhq9,
    ),
    Pregunta(
      texto: 'Se ha sentido mal con usted mismo(a) — o que es un fracaso '
          'o que ha quedado mal con usted mismo(a) o con su familia',
      opciones: _opcionesPhq9,
    ),
    Pregunta(
      texto: 'Problemas para concentrarse en cosas tales como leer el '
          'periódico o ver la televisión',
      opciones: _opcionesPhq9,
    ),
    Pregunta(
      texto: 'Se ha movido o hablado tan despacio que otras personas '
          'podrían haberlo notado. O lo contrario — tan inquieto(a) o '
          'agitado(a) que se ha estado moviendo mucho más de lo normal',
      opciones: _opcionesPhq9,
    ),
    Pregunta(
      texto: 'Pensamientos de que estaría mejor muerto(a) o de que le '
          'haría daño de alguna manera',
      opciones: _opcionesPhq9,
    ),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 4,
      etiqueta: 'Mínima',
      descripcion: 'Sin o con mínima sintomatología depresiva.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 5,
      maximo: 9,
      etiqueta: 'Leve',
      descripcion: 'Sintomatología depresiva leve.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 10,
      maximo: 14,
      etiqueta: 'Moderada',
      descripcion: 'Sintomatología depresiva moderada. El punto de corte '
          '≥ 10 es el umbral habitual para considerar un probable '
          'episodio depresivo mayor y orientar el tratamiento.',
    ),
    RangoPuntuacion(
      nivel: 3,
      minimo: 15,
      maximo: 19,
      etiqueta: 'Moderadamente grave',
      descripcion: 'Sintomatología depresiva moderadamente grave.',
    ),
    RangoPuntuacion(
      nivel: 4,
      minimo: 20,
      maximo: 27,
      etiqueta: 'Grave',
      descripcion: 'Sintomatología depresiva grave.',
    ),
  ],
  alertas: [
    AlertaPregunta(
      numeroPregunta: 9,
      valorMinimo: 1,
      mensaje: 'Se registró una respuesta positiva en el ítem 9 '
          '(pensamientos de autolesión). Realice una evaluación inmediata '
          'del riesgo de suicidio siguiendo el protocolo clínico.',
    ),
  ],
  preguntasComplementarias: [
    Pregunta(
      texto: 'Si marcó algún problema, ¿qué tan difícil le ha resultado '
          'hacer su trabajo, encargarse de las cosas en su casa o '
          'relacionarse con otras personas?',
      opciones: [
        OpcionRespuesta(etiqueta: 'Nada difícil', valor: 0),
        OpcionRespuesta(etiqueta: 'Algo difícil', valor: 1),
        OpcionRespuesta(etiqueta: 'Muy difícil', valor: 2),
        OpcionRespuesta(etiqueta: 'Extremadamente difícil', valor: 3),
      ],
    ),
  ],
  nota: 'El PHQ-9 es una herramienta de cribado, no un diagnóstico. '
      'Una puntuación ≥ 10 se asocia con un probable episodio depresivo '
      'mayor (sensibilidad 88 %, especificidad 88 %) y debe confirmarse '
      'con una evaluación clínica completa. El ítem 10 (deterioro '
      'funcional) no forma parte de la puntuación.',
);

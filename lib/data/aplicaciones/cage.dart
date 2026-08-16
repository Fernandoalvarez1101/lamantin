import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del CAGE (sí/no).
const List<OpcionRespuesta> _opcionesSiNo = [
  OpcionRespuesta(etiqueta: 'No', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí', valor: 1),
];

/// CAGE: cribado breve de problemas con la bebida (Ewing, 1984).
const InstrumentoAplicable cageAplicable = InstrumentoAplicable(
  id: 'cage',
  sigla: 'CAGE',
  titulo: 'Cuestionario CAGE',
  instrucciones: 'Responda sí o no a las siguientes preguntas sobre su '
      'consumo de alcohol.',
  preguntas: [
    Pregunta(
        texto:
            '¿Ha sentido alguna vez que debería reducir su consumo de alcohol?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Le ha molestado la gente que le critica su forma de beber?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Se ha sentido alguna vez culpable por beber?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto:
            '¿Alguna vez ha bebido al despertar para tranquilizar los nervios o librarse de una resaca?',
        opciones: _opcionesSiNo),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 1,
      etiqueta: 'Sin indicadores',
      descripcion: 'Sin indicadores clínicamente significativos de '
          'problema con el alcohol.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 2,
      maximo: 4,
      etiqueta: 'Probable problema',
      descripcion: 'Dos o más respuestas positivas sugieren un probable '
          'problema con el alcohol. Se recomienda evaluación clínica.',
    ),
  ],
  nota: 'El CAGE es un cribado breve, no un diagnóstico. El punto de corte '
      'habitual es ≥ 2.',
);

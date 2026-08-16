import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del DAST-10 (sí/no).
const List<OpcionRespuesta> _opcionesSiNo = [
  OpcionRespuesta(etiqueta: 'No', valor: 0),
  OpcionRespuesta(etiqueta: 'Sí', valor: 1),
];

/// DAST-10: Drug Abuse Screening Test (Skinner, 1982).
///
/// Detección del uso problemático de drogas en el último año. Los ítems
/// 4 y 5 (capacidad de abstenerse) se puntúan de forma invertida.
const InstrumentoAplicable dast10Aplicable = InstrumentoAplicable(
  id: 'dast-10',
  sigla: 'DAST-10',
  titulo: 'Test de Cribado de Abuso de Drogas-10',
  instrucciones: 'Las siguientes preguntas se refieren a su consumo de '
      'drogas (excluye alcohol y tabaco) en los últimos 12 meses.',
  preguntas: [
    Pregunta(
        texto:
            '¿Ha consumido drogas que no sean las recetadas por razones médicas?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Ha abusado de más de una droga a la vez?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿No puede dejar las drogas cuando lo desea?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto:
            '¿Puede pasar la semana sin consumir drogas (además de las recetadas por razones médicas)?',
        opciones: _opcionesSiNo,
        invertida: true),
    Pregunta(
        texto: '¿Puede siempre dejar de consumir drogas cuando lo desea?',
        opciones: _opcionesSiNo,
        invertida: true),
    Pregunta(
        texto:
            '¿Ha tenido "lagunas" o "flashbacks" como resultado del consumo de drogas?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Alguna vez se siente mal o culpable por su consumo de drogas?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto:
            '¿Su pareja o sus padres se quejan alguna vez de su consumo de drogas?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto: '¿Ha descuidado a su familia por el consumo de drogas?',
        opciones: _opcionesSiNo),
    Pregunta(
        texto:
            '¿Ha tenido problemas en el trabajo o en la escuela por el consumo de drogas?',
        opciones: _opcionesSiNo),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 0,
      etiqueta: 'Sin indicadores',
      descripcion: 'Sin problemas de consumo reportados.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 1,
      maximo: 2,
      etiqueta: 'Bajo',
      descripcion: 'Nivel bajo de problemas de consumo.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 3,
      maximo: 5,
      etiqueta: 'Moderado',
      descripcion: 'Nivel moderado de problemas de consumo.',
    ),
    RangoPuntuacion(
      nivel: 3,
      minimo: 6,
      maximo: 8,
      etiqueta: 'Sustancial',
      descripcion: 'Nivel sustancial de problemas de consumo.',
    ),
    RangoPuntuacion(
      nivel: 4,
      minimo: 9,
      maximo: 10,
      etiqueta: 'Severo',
      descripcion: 'Nivel severo de problemas de consumo.',
    ),
  ],
  nota: 'El DAST-10 es una herramienta de cribado, no un diagnóstico. '
      'Los ítems 4 y 5 se puntúan de forma invertida.',
);

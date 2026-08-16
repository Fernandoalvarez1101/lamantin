import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del PSS-10 (frecuencia 0-4).
const List<OpcionRespuesta> _opcionesPss = [
  OpcionRespuesta(etiqueta: 'Nunca', valor: 0),
  OpcionRespuesta(etiqueta: 'Casi nunca', valor: 1),
  OpcionRespuesta(etiqueta: 'De vez en cuando', valor: 2),
  OpcionRespuesta(etiqueta: 'A menudo', valor: 3),
  OpcionRespuesta(etiqueta: 'Muy a menudo', valor: 4),
];

/// PSS-10: Escala de Estrés Percibido (Cohen, Kamarck y Mermelstein, 1983).
///
/// Mide el grado en que las situaciones se valoran como estresantes en el
/// último mes. Los ítems 4, 5, 7 y 8 se puntúan de forma invertida.
const InstrumentoAplicable pss10Aplicable = InstrumentoAplicable(
  id: 'pss-10',
  sigla: 'PSS-10',
  titulo: 'Escala de Estrés Percibido',
  instrucciones: 'Durante el último mes, ¿con qué frecuencia…',
  preguntas: [
    Pregunta(
        texto: 'Ha estado afectado(a) por algo que ha ocurrido inesperadamente',
        opciones: _opcionesPss),
    Pregunta(
        texto:
            'Ha sentido que no podía controlar las cosas importantes de su vida',
        opciones: _opcionesPss),
    Pregunta(
        texto: 'Se ha sentido nervioso(a) o estresado(a)',
        opciones: _opcionesPss),
    Pregunta(
        texto:
            'Ha manejado con éxito los pequeños problemas irritantes de la vida',
        opciones: _opcionesPss,
        invertida: true),
    Pregunta(
        texto:
            'Ha sentido que ha afrontado efectivamente los cambios importantes que han ocurrido en su vida',
        opciones: _opcionesPss,
        invertida: true),
    Pregunta(
        texto:
            'Ha estado seguro(a) sobre su capacidad para manejar sus problemas personales',
        opciones: _opcionesPss),
    Pregunta(
        texto: 'Ha sentido que las cosas le van bien',
        opciones: _opcionesPss,
        invertida: true),
    Pregunta(
        texto: 'Ha sentido que tenía las cosas bajo control',
        opciones: _opcionesPss,
        invertida: true),
    Pregunta(
        texto: 'Ha estado molesto(a) por cosas que estaban fuera de su control',
        opciones: _opcionesPss),
    Pregunta(
        texto:
            'Ha sentido que las dificultades se acumulaban tanto que no podía superarlas',
        opciones: _opcionesPss),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 13,
      etiqueta: 'Bajo',
      descripcion: 'Estrés percibido bajo.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 14,
      maximo: 26,
      etiqueta: 'Moderado',
      descripcion: 'Estrés percibido moderado.',
    ),
    RangoPuntuacion(
      nivel: 2,
      minimo: 27,
      maximo: 40,
      etiqueta: 'Alto',
      descripcion: 'Estrés percibido alto. Se recomienda valorar recursos '
          'de afrontamiento y derivar si procede.',
    ),
  ],
  nota: 'El PSS-10 es una herramienta de cribado, no un diagnóstico. '
      'Los ítems 4, 5, 7 y 8 se puntúan de forma invertida. Instrumento '
      'con copyright (Cohen y colaboradores); su distribución comercial '
      'se realiza a través de Mind Garden.',
);

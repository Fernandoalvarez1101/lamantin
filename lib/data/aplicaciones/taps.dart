import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del TAPS-1 (frecuencia en el último año).
const List<OpcionRespuesta> _opcionesTaps = [
  OpcionRespuesta(etiqueta: 'Nunca', valor: 0),
  OpcionRespuesta(etiqueta: 'Menos de una vez al mes', valor: 1),
  OpcionRespuesta(etiqueta: 'Mensualmente', valor: 2),
  OpcionRespuesta(etiqueta: 'Semanalmente', valor: 3),
  OpcionRespuesta(etiqueta: 'A diario o casi a diario', valor: 4),
];

/// TAPS: Tobacco, Alcohol, Prescription medication, and other Substance
/// use Tool (NIDA/NIAAA, 2017).
///
/// Cribado de consumo de tabaco, alcohol, fármacos con receta y otras
/// sustancias en el último año. La puntuación oficial es por sustancia
/// (cualquier respuesta positiva dispara el TAPS-2).
const InstrumentoAplicable tapsAplicable = InstrumentoAplicable(
  id: 'taps',
  sigla: 'TAPS',
  titulo: 'Herramienta de Cribado de Tabaco, Alcohol, Fármacos y Sustancias',
  instrucciones: 'En los últimos 12 meses, ¿con qué frecuencia…',
  preguntas: [
    Pregunta(
        texto:
            'Ha consumido algún producto de tabaco (cigarrillos, cigarrillos electrónicos/vapeo, puros, etc.)',
        opciones: _opcionesTaps),
    Pregunta(
        texto: 'Ha tomado bebidas que contienen alcohol (cerveza, vino, licor)',
        opciones: _opcionesTaps),
    Pregunta(
        texto:
            'Ha usado drogas ilegales (marihuana/cannabis, cocaína, heroína, metanfetamina, etc.)',
        opciones: _opcionesTaps),
    Pregunta(
        texto:
            'Ha usado algún medicamento con receta (analgésicos opioides, estimulantes, sedantes o tranquilizantes) por razones no médicas',
        opciones: _opcionesTaps),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: 0,
      etiqueta: 'Sin consumo',
      descripcion: 'No reporta consumo de ninguna sustancia en el '
          'último año.',
    ),
    RangoPuntuacion(
      nivel: 1,
      minimo: 1,
      maximo: 16,
      etiqueta: 'Consumo positivo',
      descripcion: 'Se reportó consumo de al menos una sustancia. '
          'Debe administrarse el TAPS-2 para cada sustancia positiva.',
    ),
  ],
  nota: 'La puntuación oficial del TAPS se calcula por sustancia y no '
      'como una suma total: cualquier respuesta distinta de «nunca» '
      'activa el TAPS-2 para esa sustancia. Instrumento de dominio '
      'público (NIDA/NIAAA).',
);

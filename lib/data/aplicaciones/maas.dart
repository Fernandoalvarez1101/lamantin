import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Opciones de respuesta del MAAS (frecuencia 1-6).
const List<OpcionRespuesta> _opcionesMaas = [
  OpcionRespuesta(etiqueta: 'Casi siempre', valor: 1),
  OpcionRespuesta(etiqueta: 'Muy frecuentemente', valor: 2),
  OpcionRespuesta(etiqueta: 'Algo frecuente', valor: 3),
  OpcionRespuesta(etiqueta: 'Algo infrecuente', valor: 4),
  OpcionRespuesta(etiqueta: 'Muy infrecuente', valor: 5),
  OpcionRespuesta(etiqueta: 'Casi nunca', valor: 6),
];

/// MAAS: Mindful Attention Awareness Scale (Brown y Ryan, 2003).
///
/// Mide la atención y conciencia plena (mindfulness) en la vida
/// cotidiana. Puntuaciones más altas indican mayor atención plena.
const InstrumentoAplicable maasAplicable = InstrumentoAplicable(
  id: 'maas',
  sigla: 'MAAS',
  titulo: 'Escala de Atención y Conciencia Plena',
  instrucciones: 'Indique con qué frecuencia le ocurre lo siguiente en su '
      'vida diaria.',
  preguntas: [
    Pregunta(
        texto:
            'Podría estar experimentando una emoción y no darme cuenta hasta algún tiempo después',
        opciones: _opcionesMaas),
    Pregunta(
        texto:
            'Rompo o derramo cosas por descuido, falta de atención o por estar pensando en otra cosa',
        opciones: _opcionesMaas),
    Pregunta(
        texto:
            'Me cuesta mantenerme centrado(a) en lo que está ocurriendo en el presente',
        opciones: _opcionesMaas),
    Pregunta(
        texto:
            'Tiendo a caminar rápido para llegar adonde voy sin prestar atención a lo que experimento en el camino',
        opciones: _opcionesMaas),
    Pregunta(
        texto:
            'Tiendo a no notar las sensaciones de tensión física hasta que realmente llaman mi atención',
        opciones: _opcionesMaas),
    Pregunta(
        texto: 'Olvido el nombre de una persona tan pronto como me lo dicen',
        opciones: _opcionesMaas),
    Pregunta(
        texto:
            'Parece que funciono en "piloto automático", sin darme cuenta de lo que estoy haciendo',
        opciones: _opcionesMaas),
    Pregunta(
        texto:
            'Hago las actividades con prisas, sin estar realmente atento(a) a ellas',
        opciones: _opcionesMaas),
    Pregunta(
        texto:
            'Me concentro tanto en la meta que deseo alcanzar que pierdo el contacto con lo que estoy haciendo ahora',
        opciones: _opcionesMaas),
    Pregunta(
        texto:
            'Hago trabajos o tareas automáticamente, sin ser consciente de lo que estoy haciendo',
        opciones: _opcionesMaas),
    Pregunta(
        texto:
            'Me descubro escuchando a alguien con un oído y haciendo otra cosa al mismo tiempo',
        opciones: _opcionesMaas),
    Pregunta(
        texto:
            'Conduzco "en piloto automático" y luego me pregunto por qué fui a ese lugar',
        opciones: _opcionesMaas),
    Pregunta(
        texto: 'Me descubro preocupado(a) por el futuro o el pasado',
        opciones: _opcionesMaas),
    Pregunta(
        texto: 'Me descubro haciendo cosas sin prestar atención',
        opciones: _opcionesMaas),
    Pregunta(
        texto: 'Picoteo sin ser consciente de que estoy comiendo',
        opciones: _opcionesMaas),
  ],
  rangos: [
    RangoPuntuacion(
      nivel: 0,
      minimo: 15,
      maximo: 90,
      etiqueta: 'Descriptivo',
      descripcion: 'Sin puntos de corte clínicos normativos publicados.',
      descriptiva: true,
    ),
  ],
  nota: 'El MAAS es una medida descriptiva del mindfulness. No existen '
      'puntos de corte clínicos publicados; se interpreta por comparación '
      'con normas de investigación. Libre uso en investigación (cita del '
      'autor).',
);

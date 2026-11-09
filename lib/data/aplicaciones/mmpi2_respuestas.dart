import '../../models/instrumento_aplicable.dart';
import '../../models/pregunta.dart';

/// Cantidad de ítems del cuadernillo del MMPI-2 (forma completa).
const int mmpi2TotalItems = 567;

/// Opciones de la hoja de respuestas: Verdadero o Falso.
const List<OpcionRespuesta> _opcionesVerdaderoFalso = [
  OpcionRespuesta(etiqueta: 'V · Verdadero', valor: 1),
  OpcionRespuesta(etiqueta: 'F · Falso', valor: 0),
];

/// MMPI-2: hoja de respuestas de los 567 ítems.
///
/// Los ítems del MMPI-2 son propietarios y no se reproducen: la app ofrece
/// 567 casillas numeradas Verdadero/Falso. El evaluado lee cada reactivo en
/// el cuadernillo oficial y el profesional marca aquí su respuesta; al
/// finalizar se obtiene la plantilla completa de respuestas para calificar
/// con la clave del editor o trasladarla a su plataforma licenciada.
final InstrumentoAplicable mmpi2RespuestasAplicable = InstrumentoAplicable(
  id: 'mmpi-2-respuestas',
  sigla: 'MMPI-2 · respuestas',
  titulo: 'MMPI-2: hoja de respuestas (567 ítems)',
  instrucciones: 'HOJA DE RESPUESTAS. Entregue al evaluado el cuadernillo '
      'oficial del MMPI-2 y registre aquí, ítem por ítem, si responde '
      '«Verdadero» o «Falso». Lamantin no reproduce los 567 reactivos: el '
      'evaluado los lee en el material licenciado y el profesional sólo '
      'transcribe sus marcas. Procure no dejar ítems sin responder, porque el '
      'MMPI-2 penaliza las omisiones en las escalas de validez.',
  preguntas: [
    for (var numero = 1; numero <= mmpi2TotalItems; numero++)
      Pregunta(texto: 'Ítem $numero', opciones: _opcionesVerdaderoFalso),
  ],
  rangos: [
    const RangoPuntuacion(
      nivel: 0,
      minimo: 0,
      maximo: mmpi2TotalItems,
      etiqueta: 'Ver plantilla',
      descripcion: 'La hoja de respuestas no se interpreta en la app: la '
          'calificación se hace con la clave y los baremos oficiales.',
    ),
  ],
  mostrarPuntuacionTotal: false,
  mostrarPlantillaRespuestas: true,
  nota: 'Instrumento propietario (Pearson / University of Minnesota Press): '
      'sólo puede administrarse con licencia vigente y el cuadernillo '
      'original. Esta hoja no contiene los reactivos ni calcula puntuaciones '
      'directas o T; únicamente registra las respuestas Verdadero/Falso para '
      'que el profesional las traslade a la hoja de perfil o a la plataforma '
      'del editor. En el resultado puede copiar la plantilla completa, ítem '
      'por ítem.',
);

import 'pregunta.dart';

/// Banda de interpretación de la puntuación total.
class RangoPuntuacion {
  const RangoPuntuacion({
    required this.nivel,
    required this.minimo,
    required this.maximo,
    required this.etiqueta,
    required this.descripcion,
    this.descriptiva = false,
  });

  /// Gravedad de la banda (0 = menor, mayor = más grave).
  final int nivel;

  /// Límite inferior de la puntuación (inclusive).
  final int minimo;

  /// Límite superior de la puntuación (inclusive).
  final int maximo;

  /// Etiqueta corta, p. ej. «Moderada».
  final String etiqueta;

  /// Interpretación clínica de la banda.
  final String descripcion;

  /// Indica que la banda es solo descriptiva (sin interpretación
  /// categórica clínica).
  ///
  /// Cuando es `true`, la pantalla de resultados muestra la puntuación
  /// bruta, el rango de la escala y la media por ítem, **sin etiqueta
  /// categórica**, tal como corresponde a instrumentos sin puntos de
  /// corte normativos publicados.
  final bool descriptiva;
}

/// Subescala de puntuación de un instrumento (p. ej. el afecto positivo y
/// negativo del PANAS, o los dominios del WHOQOL-BREF).
class SubescalaPuntuacion {
  const SubescalaPuntuacion({
    required this.id,
    required this.nombre,
    required this.indicesPregunta,
    required this.rangos,
    this.descripcion,
    this.calcularPuntuacion,
  });

  /// Identificador único de la subescala.
  final String id;

  /// Nombre visible de la subescala.
  final String nombre;

  /// Índices (base 0) de las preguntas que componen la subescala.
  final List<int> indicesPregunta;

  /// Bandas de interpretación de la puntuación de la subescala.
  final List<RangoPuntuacion> rangos;

  /// Aclaración clínica sobre la subescala (qué significa una puntuación
  /// alta o baja).
  final String? descripcion;

  /// Calculador personalizado para subescalas cuyo total no es una suma
  /// lineal (p. ej. la transformación 4-20 de los dominios del WHOQOL).
  final int Function(List<int> respuestas, List<int> indicesPregunta)?
      calcularPuntuacion;
}

/// Alerta clínica que se activa cuando una pregunta alcanza un valor.
class AlertaPregunta {
  const AlertaPregunta({
    required this.numeroPregunta,
    required this.valorMinimo,
    required this.mensaje,
  });

  /// Número de pregunta (base 1) que dispara la alerta.
  final int numeroPregunta;

  /// Valor a partir del cual se activa la alerta.
  final int valorMinimo;

  /// Mensaje clínico que se muestra al activarse.
  final String mensaje;
}

/// Instrumento listo para aplicarse dentro de la app.
///
/// Incluye las instrucciones, las preguntas con su escala de respuesta,
/// las bandas de interpretación y las alertas clínicas.
class InstrumentoAplicable {
  const InstrumentoAplicable({
    required this.id,
    required this.sigla,
    required this.titulo,
    required this.instrucciones,
    required this.preguntas,
    required this.rangos,
    required this.nota,
    this.alertas = const [],
    this.preguntasComplementarias = const [],
    this.calcularPuntuacionPersonalizada,
    this.subescalas = const [],
    this.mostrarPuntuacionTotal = true,
    this.mostrarPlantillaRespuestas = false,
  });

  /// Identificador que coincide con el catálogo (`Instrumento.id`).
  final String id;

  /// Sigla o acrónimo, p. ej. «PHQ-9».
  final String sigla;

  /// Nombre legible del instrumento.
  final String titulo;

  /// Instrucciones que se muestran al profesional.
  final String instrucciones;

  /// Preguntas en orden de aplicación.
  final List<Pregunta> preguntas;

  /// Bandas de interpretación de la puntuación total.
  final List<RangoPuntuacion> rangos;

  /// Alertas clínicas condicionadas a respuestas concretas.
  final List<AlertaPregunta> alertas;

  /// Preguntas complementarias que se aplican después de las puntuables
  /// pero que **no forman parte de la puntuación**.
  ///
  /// Su respuesta se muestra al profesional como información clínica
  /// adicional (p. ej. el ítem 10 de deterioro funcional del PHQ-9).
  final List<Pregunta> preguntasComplementarias;

  /// Nota sobre el alcance del instrumento (p. ej. cribado, no diagnóstico).
  final String nota;

  /// Calculador de puntuación personalizado para instrumentos cuyo total
  /// no es una suma lineal de los valores de respuesta (p. ej. el PSQI,
  /// que puntúa por componentes).
  final int Function(List<int> respuestas)? calcularPuntuacionPersonalizada;

  /// Subescalas de puntuación (p. ej. afecto positivo y negativo del
  /// PANAS). Si la lista no está vacía, la pantalla de resultados las
  /// muestra en lugar de una puntuación única.
  final List<SubescalaPuntuacion> subescalas;

  /// Indica si la puntuación total debe mostrarse como tarjeta principal.
  ///
  /// Se desactiva en instrumentos cuya puntuación total no es clínicamente
  /// interpretable (p. ej. el PANAS, que se lee por subescalas).
  final bool mostrarPuntuacionTotal;

  /// Indica si la pantalla de resultados debe mostrar la plantilla de
  /// respuestas ítem por ítem (número de ítem y opción elegida).
  ///
  /// Se usa en instrumentos cuya calificación se hace fuera de la app, como
  /// la hoja de respuestas del MMPI-2: la app registra las marcas
  /// Verdadero/Falso y el profesional las traslada a su hoja de perfil o a la
  /// plataforma licenciada del editor.
  final bool mostrarPlantillaRespuestas;

  /// Cantidad total de preguntas (puntuables + complementarias).
  int get totalPreguntas => preguntas.length + preguntasComplementarias.length;

  /// Devuelve una copia de este instrumento con el texto de las preguntas
  /// sustituido por el del mapa [textos] (clave = número de ítem, base 1).
  ///
  /// Los ítems que no figuren en [textos] conservan su texto original. Se usa
  /// en la hoja de respuestas del MMPI-2 para que el profesional cargue los
  /// reactivos desde un archivo local sin publicarlos.
  InstrumentoAplicable conTextosDePregunta(Map<int, String> textos) {
    return InstrumentoAplicable(
      id: id,
      sigla: sigla,
      titulo: titulo,
      instrucciones: instrucciones,
      nota: nota,
      preguntas: [
        for (var i = 0; i < preguntas.length; i++)
          Pregunta(
            texto: textos.containsKey(i + 1)
                ? '${i + 1}. ${textos[i + 1]}'
                : preguntas[i].texto,
            opciones: preguntas[i].opciones,
            invertida: preguntas[i].invertida,
            puntuable: preguntas[i].puntuable,
          ),
      ],
      rangos: rangos,
      alertas: alertas,
      preguntasComplementarias: preguntasComplementarias,
      calcularPuntuacionPersonalizada: calcularPuntuacionPersonalizada,
      subescalas: subescalas,
      mostrarPuntuacionTotal: mostrarPuntuacionTotal,
      mostrarPlantillaRespuestas: mostrarPlantillaRespuestas,
    );
  }
}

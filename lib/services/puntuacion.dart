import '../models/instrumento_aplicable.dart';
import '../models/resultado_aplicacion.dart';

/// Calcula la puntuación total, la banda de severidad y las alertas
/// clínicas de un instrumento a partir de las respuestas.
///
/// [respuestas] debe contener exactamente un valor por pregunta, en el
/// mismo orden que [InstrumentoAplicable.preguntas].
ResultadoAplicacion puntuarInstrumento(
  InstrumentoAplicable instrumento,
  List<int> respuestas,
) {
  if (respuestas.length != instrumento.preguntas.length) {
    throw ArgumentError(
      'Se esperaban ${instrumento.preguntas.length} respuestas '
      'y se recibieron ${respuestas.length}.',
    );
  }

  var total = instrumento.calcularPuntuacionPersonalizada != null
      ? instrumento.calcularPuntuacionPersonalizada!(respuestas)
      : _sumaLineal(instrumento, respuestas);

  final rango = instrumento.rangos.firstWhere(
    (rango) => total >= rango.minimo && total <= rango.maximo,
    orElse: () => instrumento.rangos.last,
  );

  final alertas = <String>[];
  for (final alerta in instrumento.alertas) {
    final valor = respuestas[alerta.numeroPregunta - 1];
    if (valor >= alerta.valorMinimo) {
      alertas.add(alerta.mensaje);
    }
  }

  final subescalas = <Subpuntuacion>[];
  for (final subescala in instrumento.subescalas) {
    final totalSubescala = subescala.calcularPuntuacion != null
        ? subescala.calcularPuntuacion!(
            respuestas,
            subescala.indicesPregunta,
          )
        : _sumaIndices(instrumento, respuestas, subescala.indicesPregunta);
    final rangoSubescala = subescala.rangos.firstWhere(
      (rango) =>
          totalSubescala >= rango.minimo && totalSubescala <= rango.maximo,
      orElse: () => subescala.rangos.last,
    );
    subescalas.add(
      Subpuntuacion(
        nombre: subescala.nombre,
        total: totalSubescala,
        rango: rangoSubescala,
        cantidadItems: subescala.indicesPregunta.length,
        descripcion: subescala.descripcion,
      ),
    );
  }

  return ResultadoAplicacion(
    total: total,
    rango: rango,
    alertasActivadas: alertas,
    subescalas: subescalas,
  );
}

/// Suma lineal de los valores de respuesta, aplicando la inversión de los
/// ítems marcados como `invertida` y omitiendo los que no son `puntuable`.
int _sumaLineal(InstrumentoAplicable instrumento, List<int> respuestas) {
  var total = 0;
  for (var i = 0; i < instrumento.preguntas.length; i++) {
    final pregunta = instrumento.preguntas[i];
    if (!pregunta.puntuable) continue;
    var valor = respuestas[i];
    if (pregunta.invertida) {
      // Invierte la puntuación: nuevo = minimo + maximo - valor.
      valor =
          pregunta.opciones.first.valor + pregunta.opciones.last.valor - valor;
    }
    total += valor;
  }
  return total;
}

/// Suma los valores de las preguntas indicadas por [indices], aplicando la
/// inversión de los ítems marcados como `invertida`.
int _sumaIndices(
  InstrumentoAplicable instrumento,
  List<int> respuestas,
  List<int> indices,
) {
  var total = 0;
  for (final indice in indices) {
    final pregunta = instrumento.preguntas[indice];
    var valor = respuestas[indice];
    if (pregunta.invertida) {
      valor =
          pregunta.opciones.first.valor + pregunta.opciones.last.valor - valor;
    }
    total += valor;
  }
  return total;
}

/// Parser del CSV de reactivos de la hoja de respuestas del MMPI-2.
///
/// El archivo tiene dos columnas por línea: el número del ítem y su texto,
/// separadas por la **primera** coma (el texto puede contener comas). Ejemplo:
///
/// ```
/// numero,texto
/// 1,Texto del primer ítem
/// 2,Texto del segundo
/// ```
///
/// Reglas:
/// - La línea de encabezado `numero,texto` se ignora.
/// - Las líneas en blanco y las que no empiezan con un número se ignoran.
/// - Los textos vacíos se ignoran.
library;

Map<int, String> parsearReactivosCsv(String contenido) {
  final reactivos = <int, String>{};

  for (final linea in contenido.split(RegExp(r'\r?\n'))) {
    final limpia = linea.trim();
    if (limpia.isEmpty) continue;

    final coma = limpia.indexOf(',');
    if (coma <= 0) continue;

    final numeroTexto = limpia.substring(0, coma).trim();
    final texto = limpia.substring(coma + 1).trim();

    if (numeroTexto.toLowerCase() == 'numero' &&
        texto.toLowerCase() == 'texto') {
      continue; // encabezado
    }
    if (texto.isEmpty) continue;

    final numero = int.tryParse(numeroTexto);
    if (numero == null) continue;

    reactivos[numero] = texto;
  }

  return reactivos;
}

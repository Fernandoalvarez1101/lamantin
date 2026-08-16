const List<String> _mesesAbreviados = [
  'ene',
  'feb',
  'mar',
  'abr',
  'may',
  'jun',
  'jul',
  'ago',
  'sep',
  'oct',
  'nov',
  'dic',
];

/// Formatea una fecha como «14 ago 2026».
String formatearFecha(DateTime fecha) {
  return '${fecha.day} ${_mesesAbreviados[fecha.month - 1]} ${fecha.year}';
}

/// Formatea una fecha con hora como «14 ago 2026 · 09:30».
String formatearFechaHora(DateTime fecha) {
  final hh = fecha.hour.toString().padLeft(2, '0');
  final mm = fecha.minute.toString().padLeft(2, '0');
  return '${formatearFecha(fecha)} · $hh:$mm';
}

/// Iniciales de un nombre y apellido (máximo 2 letras).
String inicialesDe(String nombre, String apellido) {
  String inicial(String s) =>
      s.trim().isEmpty ? '' : s.trim().substring(0, 1).toUpperCase();
  final resultado = '${inicial(nombre)}${inicial(apellido)}';
  return resultado.isEmpty ? '?' : resultado;
}

/// Convierte un texto en un nombre de archivo seguro: minúsculas, sin
/// diacríticos ni espacios (p. ej. «Ana García» -> «ana_garcia»).
String nombreArchivoSeguro(String texto) {
  const conDiacriticos = 'áéíóúüñÁÉÍÓÚÜÑ';
  const sinDiacriticos = 'aeiounAEIOUUN';
  final buffer = StringBuffer();
  for (final ch in texto.split('')) {
    final idx = conDiacriticos.indexOf(ch);
    buffer.write(idx >= 0 ? sinDiacriticos[idx] : ch);
  }
  return buffer
      .toString()
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'^_+|_+$'), '');
}

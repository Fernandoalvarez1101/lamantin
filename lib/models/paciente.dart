/// Paciente atendido por el profesional.
class Paciente {
  const Paciente({
    required this.id,
    required this.nombre,
    required this.apellido,
    this.fechaNacimiento,
    this.sexo,
    this.notas,
    required this.fechaRegistro,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) => Paciente(
        id: json['id'] as String,
        nombre: json['nombre'] as String,
        apellido: json['apellido'] as String,
        fechaNacimiento: json['fechaNacimiento'] != null
            ? DateTime.parse(json['fechaNacimiento'] as String)
            : null,
        sexo: json['sexo'] as String?,
        notas: json['notas'] as String?,
        fechaRegistro: DateTime.parse(json['fechaRegistro'] as String),
      );

  final String id;
  final String nombre;
  final String apellido;

  /// Fecha de nacimiento (opcional).
  final DateTime? fechaNacimiento;

  /// Sexo registrado ('Femenino', 'Masculino', 'Otro' o null).
  final String? sexo;

  /// Notas clínicas libres.
  final String? notas;

  /// Fecha de alta del paciente en la app.
  final DateTime fechaRegistro;

  String get nombreCompleto => '$nombre $apellido'.trim();

  /// Edad en años al día de hoy, o null si no se conoce la fecha.
  int? get edad {
    final fn = fechaNacimiento;
    if (fn == null) return null;
    final hoy = DateTime.now();
    var edad = hoy.year - fn.year;
    if (hoy.month < fn.month ||
        (hoy.month == fn.month && hoy.day < fn.day)) {
      edad--;
    }
    return edad;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'apellido': apellido,
        'fechaNacimiento': fechaNacimiento?.toIso8601String(),
        'sexo': sexo,
        'notas': notas,
        'fechaRegistro': fechaRegistro.toIso8601String(),
      };
}

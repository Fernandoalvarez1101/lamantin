import 'package:flutter/material.dart';

import '../../models/paciente.dart';
import '../../repositories/almacen.dart';
import '../../utils/formato.dart';
import '../../widgets/futuristic_button.dart';
import '../../widgets/theme_toggle_button.dart';

/// Formulario de alta y edición de pacientes.
///
/// Al guardar correctamente, cierra la pantalla devolviendo el [Paciente]
/// creado o actualizado.
class FormularioPacienteScreen extends StatefulWidget {
  const FormularioPacienteScreen({super.key, this.paciente});

  /// Paciente a editar; si es null se crea uno nuevo.
  final Paciente? paciente;

  @override
  State<FormularioPacienteScreen> createState() =>
      _FormularioPacienteScreenState();
}

class _FormularioPacienteScreenState extends State<FormularioPacienteScreen> {
  static const List<String> _opcionesSexo = [
    'Femenino',
    'Masculino',
    'Otro',
  ];

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombre;
  late final TextEditingController _apellido;
  late final TextEditingController _notas;
  DateTime? _fechaNacimiento;
  String? _sexo;
  bool _guardando = false;

  bool get _editando => widget.paciente != null;

  @override
  void initState() {
    super.initState();
    final p = widget.paciente;
    _nombre = TextEditingController(text: p?.nombre ?? '');
    _apellido = TextEditingController(text: p?.apellido ?? '');
    _notas = TextEditingController(text: p?.notas ?? '');
    _fechaNacimiento = p?.fechaNacimiento;
    _sexo = p?.sexo;
  }

  @override
  void dispose() {
    _nombre.dispose();
    _apellido.dispose();
    _notas.dispose();
    super.dispose();
  }

  Future<void> _seleccionarFecha() async {
    final hoy = DateTime.now();
    final elegida = await showDatePicker(
      context: context,
      initialDate:
          _fechaNacimiento ?? DateTime(hoy.year - 30, hoy.month, hoy.day),
      firstDate: DateTime(hoy.year - 120),
      lastDate: hoy,
      helpText: 'Fecha de nacimiento',
    );
    if (elegida != null) {
      setState(() => _fechaNacimiento = elegida);
    }
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _guardando = true);
    final previo = widget.paciente;
    final paciente = Paciente(
      id: previo?.id ?? 'p${DateTime.now().microsecondsSinceEpoch}',
      nombre: _nombre.text.trim(),
      apellido: _apellido.text.trim(),
      fechaNacimiento: _fechaNacimiento,
      sexo: _sexo,
      notas: _notas.text.trim().isEmpty ? null : _notas.text.trim(),
      fechaRegistro: previo?.fechaRegistro ?? DateTime.now(),
    );

    if (previo == null) {
      await AppRepositorios.paciente.crear(paciente);
    } else {
      await AppRepositorios.paciente.actualizar(paciente);
    }

    if (!mounted) return;
    Navigator.of(context).pop(paciente);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final labelFechaColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editar paciente' : 'Nuevo paciente'),
        actions: const [ThemeToggleButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _editando
                    ? 'Actualiza los datos del paciente.'
                    : 'Registra los datos del paciente para poder guardar '
                        'sus aplicaciones de instrumentos.',
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nombre,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nombre *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Indica el nombre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _apellido,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Apellido *',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Indica el apellido'
                    : null,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: _seleccionarFecha,
                borderRadius: BorderRadius.circular(4),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Fecha de nacimiento',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  child: Text(
                    _fechaNacimiento == null
                        ? 'Sin especificar'
                        : formatearFecha(_fechaNacimiento!),
                    style: textTheme.bodyLarge?.copyWith(
                      color: _fechaNacimiento == null ? labelFechaColor : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _sexo,
                decoration: const InputDecoration(
                  labelText: 'Sexo',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Sin especificar'),
                  ),
                  for (final opcion in _opcionesSexo)
                    DropdownMenuItem<String>(
                      value: opcion,
                      child: Text(opcion),
                    ),
                ],
                onChanged: (v) => setState(() => _sexo = v),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notas,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Notas clínicas',
                  hintText: 'Motivo de consulta, observaciones…',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              FuturisticButton(
                label: _editando ? 'Guardar cambios' : 'Guardar paciente',
                icon: Icons.check,
                onTap: _guardando ? null : _guardar,
                loading: _guardando,
                fullWidth: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

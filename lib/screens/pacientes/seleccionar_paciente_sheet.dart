import 'package:flutter/material.dart';

import '../../models/paciente.dart';
import '../../repositories/almacen.dart';
import '../../utils/formato.dart';

/// Hoja inferior para elegir un paciente al guardar una sesión.
///
/// Devuelve el id del paciente elegido, el valor especial
/// [SeleccionarPacienteSheet.nuevoPaciente] si se quiere registrar uno
/// nuevo, o `null` si se cancela.
class SeleccionarPacienteSheet extends StatefulWidget {
  const SeleccionarPacienteSheet({super.key});

  /// Valor devuelto cuando se elige registrar un paciente nuevo.
  static const String nuevoPaciente = '__nuevo__';

  @override
  State<SeleccionarPacienteSheet> createState() =>
      _SeleccionarPacienteSheetState();
}

class _SeleccionarPacienteSheetState extends State<SeleccionarPacienteSheet> {
  late Future<List<Paciente>> _futuroPacientes;

  @override
  void initState() {
    super.initState();
    _futuroPacientes = AppRepositorios.paciente.obtenerTodos();
  }

  String _subtitulo(Paciente p) {
    final partes = <String>[
      if (p.edad != null) '${p.edad} años',
      if (p.sexo != null) p.sexo!,
    ];
    return partes.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
            child: Text(
              'Guardar resultado en…',
              style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: FutureBuilder<List<Paciente>>(
              future: _futuroPacientes,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final pacientes = snapshot.data ?? const <Paciente>[];
                if (pacientes.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    child: Text(
                      'Aún no hay pacientes. Crea uno para guardar el '
                      'resultado.',
                      style: textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: pacientes.length,
                  itemBuilder: (context, index) {
                    final p = pacientes[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        child: Text(
                          inicialesDe(p.nombre, p.apellido),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                      title: Text(p.nombreCompleto),
                      subtitle: Text(_subtitulo(p)),
                      onTap: () => Navigator.of(context).pop(p.id),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.person_add_alt),
            title: const Text('Nuevo paciente'),
            onTap: () =>
                Navigator.of(context).pop(SeleccionarPacienteSheet.nuevoPaciente),
          ),
        ],
      ),
    );
  }
}

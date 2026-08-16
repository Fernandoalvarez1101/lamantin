import 'package:flutter/material.dart';

import '../../models/paciente.dart';
import '../../repositories/almacen.dart';
import '../../theme.dart';
import '../../utils/formato.dart';
import '../../widgets/theme_toggle_button.dart';
import 'detalle_paciente_screen.dart';
import 'formulario_paciente_screen.dart';

/// Listado de pacientes con búsqueda y alta desde el botón flotante.
class ListaPacientesScreen extends StatefulWidget {
  const ListaPacientesScreen({super.key});

  @override
  State<ListaPacientesScreen> createState() => _ListaPacientesScreenState();
}

class _ListaPacientesScreenState extends State<ListaPacientesScreen> {
  late Future<List<Paciente>> _futuroPacientes;
  String _filtro = '';

  @override
  void initState() {
    super.initState();
    _futuroPacientes = _cargarPacientes();
  }

  Future<List<Paciente>> _cargarPacientes() async {
    final pacientes = await AppRepositorios.paciente.obtenerTodos();
    final filtro = _filtro.trim().toLowerCase();
    if (filtro.isEmpty) return pacientes;
    return pacientes
        .where((p) =>
            p.nombreCompleto.toLowerCase().contains(filtro) ||
            (p.sexo?.toLowerCase().contains(filtro) ?? false))
        .toList();
  }

  void _recargar() {
    setState(() {
      _futuroPacientes = _cargarPacientes();
    });
  }

  Future<void> _crearPaciente() async {
    final creado = await Navigator.of(context).push<Paciente>(
      MaterialPageRoute<Paciente>(
        builder: (_) => const FormularioPacienteScreen(),
      ),
    );
    if (creado != null) _recargar();
  }

  Future<void> _abrirPaciente(Paciente paciente) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DetallePacienteScreen(paciente: paciente),
      ),
    );
    _recargar();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
        actions: const [ThemeToggleButton()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _crearPaciente,
        tooltip: 'Nuevo paciente',
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: TextField(
              onChanged: (v) {
                _filtro = v;
                _recargar();
              },
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre…',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Paciente>>(
              future: _futuroPacientes,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                final pacientes = snapshot.data ?? const <Paciente>[];
                if (pacientes.isEmpty) {
                  return _EstadoVacio(filtroActivo: _filtro.trim().isNotEmpty);
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: pacientes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final p = pacientes[index];
                    return Card(
                      elevation: 1,
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        onTap: () => _abrirPaciente(p),
                        leading: CircleAvatar(
                          backgroundColor: LamantinColors.slateBlueSecondary,
                          foregroundColor: Colors.white,
                          child: Text(inicialesDe(p.nombre, p.apellido)),
                        ),
                        title: Text(
                          p.nombreCompleto,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(_subtitulo(p)),
                        trailing: const Icon(Icons.chevron_right),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Mensaje de estado vacío (sin pacientes o sin coincidencias).
class _EstadoVacio extends StatelessWidget {
  const _EstadoVacio({required this.filtroActivo});

  final bool filtroActivo;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.people_outline,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              filtroActivo
                  ? 'Sin resultados para la búsqueda.'
                  : 'Aún no hay pacientes registrados.',
              style: textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              filtroActivo
                  ? 'Prueba con otro nombre.'
                  : 'Toca el botón + para registrar el primero.',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

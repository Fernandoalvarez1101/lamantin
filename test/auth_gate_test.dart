import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/screens/auth/auth_gate.dart';
import 'package:lamantin/screens/auth/login_screen.dart';
import 'package:lamantin/screens/dashboard_screen.dart';

void main() {
  testWidgets(
      'AuthGate sin Supabase inicializado cae al dashboard (modo local)',
      (tester) async {
    // En tests no se inicializa Supabase: AuthGate debe detectar que no está
    // disponible y permitir el acceso directo al dashboard (comportamiento
    // requerido para que la suite no dependa de la red).
    await tester.pumpWidget(
      MaterialApp(home: AuthGate(onThemeChanged: () {})),
    );

    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);
  });
}

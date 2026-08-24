import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/screens/auth/auth_gate.dart';
import 'package:lamantin/screens/auth/login_screen.dart';
import 'package:lamantin/screens/dashboard_screen.dart';

void main() {
  testWidgets(
      'AuthGate sin Supabase inicializado no deja pasar sin autenticación',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: AuthGate(onThemeChanged: () {})),
    );

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(DashboardScreen), findsNothing);
    expect(find.textContaining('No se pudo iniciar Supabase'), findsOneWidget);
  });

  testWidgets('AuthGate con modo offline explícito permite entrar al dashboard',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: AuthGate(onThemeChanged: () {}, modoOffline: true)),
    );

    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);
  });
}

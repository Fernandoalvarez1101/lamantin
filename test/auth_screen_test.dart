import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/screens/auth/login_screen.dart';
import 'package:lamantin/screens/auth/registro_screen.dart';

void main() {
  Widget pumpApp(Widget home) => MaterialApp(home: home);

  /// El logo de Lamantin tiene una animación infinita, así que no se puede
  /// usar pumpAndSettle: se avanza con pumps de duración fija.
  Future<void> esperarTransicion(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  testWidgets('El login lleva al registro y vuelve', (tester) async {
    await tester.pumpWidget(pumpApp(LoginScreen(onThemeChanged: () {})));

    expect(find.text('Iniciá sesión para acceder a tus pacientes'),
        findsOneWidget);

    final link = find.text('¿No tenés cuenta? Registrate');
    await tester.ensureVisible(link);
    await tester.pump();
    await tester.tap(link);
    await esperarTransicion(tester);

    expect(find.byType(RegistroScreen), findsOneWidget);
    expect(find.text('Creá tu cuenta de profesional'), findsOneWidget);
  });

  testWidgets('El registro valida los campos obligatorios', (tester) async {
    await tester.pumpWidget(pumpApp(RegistroScreen(onThemeChanged: () {})));

    final boton = find.text('Crear cuenta');
    await tester.ensureVisible(boton);
    await tester.pump();
    await tester.tap(boton);
    await tester.pump();

    expect(find.text('Ingresá tu nombre.'), findsOneWidget);
    expect(find.text('Ingresá tu apellido.'), findsOneWidget);
    expect(find.text('Ingresá tu correo electrónico.'), findsOneWidget);
    expect(find.text('Ingresá una contraseña.'), findsOneWidget);
    expect(find.text('Repetí la contraseña.'), findsOneWidget);
  });

  testWidgets('El registro valida que las contraseñas coincidan',
      (tester) async {
    await tester.pumpWidget(pumpApp(RegistroScreen(onThemeChanged: () {})));

    await tester.enterText(find.byType(TextFormField).at(0), 'Ana');
    await tester.enterText(find.byType(TextFormField).at(1), 'García');
    await tester.enterText(
        find.byType(TextFormField).at(2), 'ana@ejemplo.com');
    await tester.enterText(find.byType(TextFormField).at(3), 'clave123');
    await tester.enterText(find.byType(TextFormField).at(4), 'clave456');

    final boton = find.text('Crear cuenta');
    await tester.ensureVisible(boton);
    await tester.pump();
    await tester.tap(boton);
    await tester.pump();

    expect(find.text('Las contraseñas no coinciden.'), findsOneWidget);
  });
}


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lamantin/screens/auth/auth_gate.dart';
import 'package:lamantin/screens/auth/login_screen.dart';
import 'package:lamantin/screens/auth/nueva_password_screen.dart';
import 'package:lamantin/screens/auth/recuperar_password_screen.dart';
import 'package:lamantin/services/recuperacion_password.dart';

void main() {
  /// El logo de Lamantin tiene una animación infinita, así que no se puede
  /// usar pumpAndSettle: se avanza con pumps de duración fija.
  Future<void> esperarTransicion(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  }

  // El flujo de recuperación usa estado estático: se limpia entre tests.
  tearDown(() {
    RecuperacionPassword.finalizar();
    RecuperacionPassword.error = null;
  });

  group('RecuperacionPassword.esCallbackAuth', () {
    test('reconoce el código del flujo PKCE', () {
      expect(
        RecuperacionPassword.esCallbackAuth(
          Uri.parse('https://app.test/?code=abc123'),
        ),
        isTrue,
      );
    });

    test('reconoce los tokens del flujo implícito en el fragmento', () {
      expect(
        RecuperacionPassword.esCallbackAuth(
          Uri.parse('https://app.test/#access_token=t&type=recovery'),
        ),
        isTrue,
      );
    });

    test('reconoce los errores que devuelve Supabase', () {
      expect(
        RecuperacionPassword.esCallbackAuth(
          Uri.parse('https://app.test/?error=access_denied'),
        ),
        isTrue,
      );
    });

    test('ignora una dirección normal de la app', () {
      expect(
        RecuperacionPassword.esCallbackAuth(
          Uri.parse('https://fernandoalvarez1101.github.io/lamantin/'),
        ),
        isFalse,
      );
    });
  });

  testWidgets('El login ofrece recuperar la contraseña', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen(onThemeChanged: () {})),
    );

    final enlace = find.text('¿Olvidaste tu contraseña?');
    await tester.ensureVisible(enlace);
    await tester.pump();
    await tester.tap(enlace);
    await esperarTransicion(tester);

    expect(find.byType(RecuperarPasswordScreen), findsOneWidget);
    expect(find.text('Recuperar contraseña'), findsOneWidget);
  });

  testWidgets('Recuperar contraseña valida el correo', (tester) async {
    await tester.pumpWidget(
      MaterialApp(home: RecuperarPasswordScreen(onThemeChanged: () {})),
    );

    final boton = find.text('Enviar enlace');
    await tester.ensureVisible(boton);
    await tester.pump();
    await tester.tap(boton);
    await tester.pump();

    expect(find.text('Ingresá tu correo electrónico.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'no-es-un-correo');
    await tester.tap(boton);
    await tester.pump();

    expect(find.text('El correo no parece válido.'), findsOneWidget);
  });

  testWidgets('Nueva contraseña valida los campos', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: NuevaPasswordScreen(onThemeChanged: () {}, onListo: () {}),
      ),
    );

    final boton = find.text('Guardar contraseña');
    await tester.ensureVisible(boton);
    await tester.pump();
    await tester.tap(boton);
    await tester.pump();

    expect(find.text('Ingresá una contraseña.'), findsOneWidget);
    expect(find.text('Repetí la contraseña.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'clave123');
    await tester.enterText(find.byType(TextFormField).at(1), 'clave456');
    await tester.tap(boton);
    await tester.pump();

    expect(find.text('Las contraseñas no coinciden.'), findsOneWidget);
  });

  testWidgets('AuthGate pide una contraseña nueva tras el enlace del correo',
      (tester) async {
    RecuperacionPassword.pendiente = true;

    await tester.pumpWidget(
      MaterialApp(home: AuthGate(onThemeChanged: () {})),
    );

    expect(find.byType(NuevaPasswordScreen), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);
  });

  testWidgets('AuthGate consume una sola vez el aviso de enlace fallido',
      (tester) async {
    RecuperacionPassword.error = 'El enlace del correo ya venció.';

    await tester.pumpWidget(
      MaterialApp(home: AuthGate(onThemeChanged: () {})),
    );

    // El aviso queda tomado por el AuthGate y no vuelve a aparecer en cada
    // reconstrucción de la pantalla de ingreso.
    expect(RecuperacionPassword.error, isNull);
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.textContaining('No se pudo iniciar Supabase'), findsOneWidget);
  });
}

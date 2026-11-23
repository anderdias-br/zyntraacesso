import 'package:flutter/material.dart';
import 'package:flutter_hbb/common/widgets/zyntra_access.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('keeps both access panels and settings usable in both themes',
      (tester) async {
    tester.view.physicalSize = const Size(1100, 760);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    for (final brightness in Brightness.values) {
      var openedSettings = false;
      await tester.pumpWidget(MaterialApp(
        theme: ThemeData(brightness: brightness),
        home: Scaffold(
          body: ZyntraAccessFrame(
            localPane: const Text('Número deste computador'),
            remotePane: const Text('Conectar a outro computador'),
            onSettings: () => openedSettings = true,
          ),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.text('ZyntraAcesso'), findsOneWidget);
      expect(find.text('Número deste computador'), findsOneWidget);
      expect(find.text('Conectar a outro computador'), findsOneWidget);
      await tester.tap(find.byTooltip('Configurações'));
      expect(openedSettings, isTrue);
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('narrow windows retain the remote panel without overflow',
      (tester) async {
    tester.view.physicalSize = const Size(390, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ZyntraAccessFrame(
          localPane: const Text('Número deste computador'),
          remotePane: const Center(child: Text('Conectar a outro computador')),
          onSettings: () {},
        ),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Conectar a outro computador'));
    await tester.pumpAndSettle();
    expect(find.text('Conectar a outro computador').hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('permission notice explains actual access and administrator prompt',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: ZyntraAccessPermissionNotice(
          capabilities: ['Ver a tela deste computador'],
          administratorAvailable: false,
        ),
      ),
    ));
    expect(find.textContaining('Ver a tela'), findsOneWidget);
    expect(find.textContaining('credenciais de administrador'), findsNothing);
    expect(find.textContaining('transferir arquivos'), findsNothing);
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: ZyntraAccessPermissionNotice(
          capabilities: [
            'Ver a tela deste computador',
            'Controlar o mouse e o teclado e usar seus programas',
          ],
          administratorAvailable: true,
        ),
      ),
    ));
    expect(find.textContaining('credenciais de administrador'), findsOneWidget);
    expect(find.textContaining('encerrar a conexão'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

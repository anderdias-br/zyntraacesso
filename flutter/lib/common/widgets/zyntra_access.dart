import 'package:flutter/material.dart';

class ZyntraAccessColors {
  ZyntraAccessColors._();

  static const primary = Color(0xFF1355D8);
  static const primaryDark = Color(0xFF4689F6);
  static const navy = Color(0xFF101A30);
  static const background = Color(0xFFF3F5FA);

  static Color accent(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? primaryDark : primary;
}

/// Composes the existing connection controls without replacing their callbacks.
class ZyntraAccessFrame extends StatelessWidget {
  const ZyntraAccessFrame({
    super.key,
    required this.localPane,
    this.remotePane,
    required this.onSettings,
  });

  final Widget localPane;
  final Widget? remotePane;
  final VoidCallback? onSettings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    return ColoredBox(
      color: dark ? ZyntraAccessColors.navy : ZyntraAccessColors.background,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/zyntra-mark.png',
                      width: 44, height: 44, semanticLabel: 'Zyntra'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ZyntraAcesso',
                          style: theme.textTheme.titleLarge?.copyWith(
                              fontSize: 22, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 3),
                      Text('Seu computador, onde você estiver.',
                          style: theme.textTheme.bodySmall),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Configurações',
                  onPressed: onSettings,
                  icon: const Icon(Icons.settings_outlined),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: LayoutBuilder(builder: (context, constraints) {
                final local = _surface(context, localPane);
                if (remotePane == null) return Center(child: local);
                final remote = _surface(context, remotePane!);
                if (constraints.maxWidth < 720) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 460, child: local),
                        const SizedBox(height: 12),
                        SizedBox(height: 520, child: remote),
                      ],
                    ),
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: 300, child: local),
                    const SizedBox(width: 16),
                    Expanded(child: remote),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _surface(BuildContext context, Widget child) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(color: theme.dividerColor.withOpacity(0.35)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(16), child: child),
    );
  }
}

class ZyntraAccessPermissionNotice extends StatelessWidget {
  const ZyntraAccessPermissionNotice({
    super.key,
    required this.capabilities,
    required this.administratorAvailable,
  });

  final List<String> capabilities;
  final bool administratorAvailable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ZyntraAccessColors.accent(context).withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.shield_outlined,
                size: 18, color: ZyntraAccessColors.accent(context)),
            const SizedBox(width: 8),
            Expanded(
              child: Text('Antes de permitir o acesso',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ),
          ]),
          const SizedBox(height: 8),
          Text('Confira as permissões desta janela. Esta conexão pode permitir:',
              style: theme.textTheme.bodySmall),
          for (final capability in capabilities)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text('• $capability', style: theme.textTheme.bodySmall),
            ),
          if (administratorAvailable) ...[
            const SizedBox(height: 8),
            Text(
              'A opção “Aceitar e elevar” permite solicitar controle de '
              'programas como administrador. O Windows poderá pedir '
              'autorização ou credenciais de administrador.',
              style: theme.textTheme.bodySmall,
            ),
          ] else ...[
            const SizedBox(height: 8),
            Text('Se o ZyntraAcesso estiver instalado com autorização elevada, '
                'o controle poderá incluir programas de administrador.',
                style: theme.textTheme.bodySmall),
          ],
          const SizedBox(height: 8),
          Text('Aceite apenas pessoas em quem você confia. '
              'Você pode encerrar a conexão a qualquer momento.',
              style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

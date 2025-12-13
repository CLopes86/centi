import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:centi/features/auth/presentation/controllers/auth_controller.dart';
import 'package:centi/features/auth/presentation/screens/login_screen.dart';

/// Ecrã Principal (Dashboard)
///
/// A primeira tela que o utilizador vê após um login bem-sucedido.
/// Atualmente exibe uma mensagem de boas-vindas e um botão de Logout.
///
/// Utiliza [ref.watch] para garantir que o estado de autenticação é monitorizado
/// e evitar erros de "Provider disposed".
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              // 1. Fazer Logout no Firebase
              await ref.read(authControllerProvider.notifier).logout();

              // 2. Voltar para o Login
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: const Center(child: Text('Bem-vindo à Penny! 💰')),
    );
  }
}

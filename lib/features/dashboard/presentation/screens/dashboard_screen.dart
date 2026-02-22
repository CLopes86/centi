import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Ecrã Principal (Dashboard)
///
/// A primeira tela que o utilizador vê após um login bem-sucedido.
/// Atualmente exibe uma mensagem de boas-vindas e um botão de Logout.
///
/// Utiliza [ref.watch] para garantir que o estado de autenticação é monitorizado
/// e evitar erros de "Provider disposed".

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // 1. Variável de Estado: Guarda qual o separador (tab) selecionado
  int _selectedIndex = 0;

  List<Widget> get _screens => [
    // 1. Início (Home)
    SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Olá, Cesaltino! 👋',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const Text(
              'Bem-vindo de volta',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            // Aqui virá o Cartão de Saldo depois...
          ],
        ),
      ),
    ),

    // 2. Perfil (Placeholder)
    const Center(child: Text('👤 Perfil')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Tab Selecionada: $_selectedIndex',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Atualiza a variável e redesenha o ecrã
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

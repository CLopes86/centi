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

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // 1. Variável de Estado: Guarda qual o separador (tab) selecionado
  int _selectedIndex = 0;
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

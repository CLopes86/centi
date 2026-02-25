import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:centi/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:centi/features/dashboard/presentation/widgets/transaction_item.dart';

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
            const SizedBox(height: 12),
            BalanceCard(balance: 1234.56, income: 2450.00, expenses: 1215.44),
            const SizedBox(height: 24),

            // CABEÇALHO DA SECÇÃO
            // Row com o título à esquerda e "Ver todas" à direita
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transações Recentes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                TextButton(
                  onPressed: () {}, // Por agora não faz nada
                  child: const Text('Ver todas'),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // LISTA DE TRANSAÇÕES (dados falsos por agora)
            // Cada TransactionItem representa uma transação
            TransactionItem(
              icon: Icons.shopping_cart,
              title: 'Supermercado',
              amount: 45.00,
              date: '24 Fev',
              isExpense: true,
            ),
            TransactionItem(
              icon: Icons.local_pharmacy,
              title: 'Farmácia',
              amount: 12.50,
              date: '23 Fev',
              isExpense: true,
            ),
            TransactionItem(
              icon: Icons.account_balance_wallet,
              title: 'Salário',
              amount: 1200.00,
              date: '22 Fev',
              isExpense: false, // false = receita → verde
            ),
            TransactionItem(
              icon: Icons.restaurant,
              title: 'Restaurante',
              amount: 28.00,
              date: '21 Fev',
              isExpense: true,
            ),
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
      body: _screens[_selectedIndex],
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

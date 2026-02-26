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
    Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,

              colors: [
                Color(0xFF6366F1), // Indigo — cor primária da app
                Color(0xFF8B5CF6),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Olá, Cesaltino! 👋',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '25 de Frevereiro de 2026',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  BalanceCard(
                    balance: 1234.56,
                    income: 2450.00,
                    expenses: 1215.89,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: const Color(0xFFF0F2F5),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Transaçoes Recentes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Ver todas'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Lista de transações (dados falsos por agora)
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
                    isExpense: false,
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
        ),
      ],
    ),
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

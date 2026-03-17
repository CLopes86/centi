import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:centi/features/dashboard/presentation/widgets/balance_card.dart';
import 'package:centi/features/dashboard/presentation/widgets/transaction_item.dart';
import 'package:centi/features/auth/domain/entities/user.dart';
import 'package:centi/features/auth/presentation/controllers/auth_controller.dart';
import 'package:centi/features/transactions/domain/entities/transaction.dart';
import 'package:centi/features/transactions/presentation/controllers/transaction_controller.dart';
import 'package:go_router/go_router.dart';

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
    Consumer(
      builder: (context, ref, _) {
        final transactionsAsync = ref.watch(transactionControllerProvider);
        final authState = ref.watch(authControllerProvider);

        final user = authState.when(
          data: (u) => u,
          loading: () => null,
          error: (_, __) => null,
        );

        final userName = _displayName(user);
        final userInitial = _userInitial(userName);
        final today = _fullDatePt(DateTime.now());

        return transactionsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Erro: $error')),
          data: (transactions) {
            final sortedTransactions = [...transactions]
              ..sort((a, b) => b.date.compareTo(a.date));

            final totalIncome = sortedTransactions
                .where((t) => t.type == TransactionType.income)
                .fold(0.0, (sum, t) => sum + t.amount);

            final totalExpenses = sortedTransactions
                .where((t) => t.type == TransactionType.expense)
                .fold(0.0, (sum, t) => sum + t.amount);

            final balance = totalIncome - totalExpenses;

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Builder(
                                builder: (context) => InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () =>
                                      Scaffold.of(context).openDrawer(),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.menu_rounded,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  userInitial,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Olá, $userName! 👋',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            today,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 20),
                          BalanceCard(
                            balance: balance,
                            income: totalIncome,
                            expenses: totalExpenses,
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
                              const Text(
                                'Transações Recentes',
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
                          if (sortedTransactions.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 40),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.receipt_long_outlined,
                                      size: 64,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Ainda não tens transações.\nToca no + para adicionar!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            ...sortedTransactions.map(
                              (transaction) => TransactionItem(
                                icon: _categoryIcon(transaction.category),
                                title: transaction.category,
                                amount: transaction.amount,
                                date: _shortDatePt(transaction.date),
                                isExpense:
                                    transaction.type == TransactionType.expense,
                                onDelete: () =>
                                    _confirmDeleteTransaction(transaction),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    ),
    Consumer(
      builder: (context, ref, _) {
        final authState = ref.watch(authControllerProvider);

        return authState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Erro: $error')),
          data: (user) {
            if (user == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock_outline, size: 64),
                      const SizedBox(height: 16),
                      const Text(
                        'Não tens sessão ativa.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('Ir para Login'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Perfil',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _displayName(user),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user.email,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await ref.read(authControllerProvider.notifier).logout();
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('Terminar sessão'),
                  ),
                ],
              ),
            );
          },
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDashboardDrawer(),
      body: _screens[_selectedIndex],
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () => context.push('/addtransaction'),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildDashboardDrawer() {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Consumer(
          builder: (context, ref, _) {
            final authState = ref.watch(authControllerProvider);

            final user = authState.when(
              data: (u) => u,
              loading: () => null,
              error: (_, __) => null,
            );

            final userName = _displayName(user);
            final userEmail = user?.email ?? 'Sem sessão ativa';

            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white.withValues(alpha: 0.24),
                        child: Text(
                          _userInitial(userName),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        userName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        userEmail,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      _drawerTile(
                        icon: Icons.home_rounded,
                        title: 'Início',
                        selected: _selectedIndex == 0,
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() => _selectedIndex = 0);
                        },
                      ),
                      _drawerTile(
                        icon: Icons.person_rounded,
                        title: 'Perfil',
                        selected: _selectedIndex == 1,
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() => _selectedIndex = 1);
                        },
                      ),
                      _drawerTile(
                        icon: Icons.settings_rounded,
                        title: 'Definições',
                        subtitle: 'Em breve',
                        onTap: () {
                          Navigator.of(context).pop();
                          _showComingSoon('Definições');
                        },
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'MVP Portugal',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      _drawerTile(
                        icon: Icons.receipt_long_rounded,
                        title: 'IRS Refund Gamification',
                        subtitle: 'Em breve',
                        onTap: () {
                          Navigator.of(context).pop();
                          _showComingSoon('IRS Refund Gamification');
                        },
                      ),
                      _drawerTile(
                        icon: Icons.phone_android_rounded,
                        title: 'MB WAY Smart Decoder',
                        subtitle: 'Em breve',
                        onTap: () {
                          Navigator.of(context).pop();
                          _showComingSoon('MB WAY Smart Decoder');
                        },
                      ),
                      _drawerTile(
                        icon: Icons.lunch_dining_rounded,
                        title: 'Meal Card Tracker',
                        subtitle: 'Em breve',
                        onTap: () {
                          Navigator.of(context).pop();
                          _showComingSoon('Meal Card Tracker');
                        },
                      ),
                      _drawerTile(
                        icon: Icons.trending_up_rounded,
                        title: 'Savings Certificates',
                        subtitle: 'Em breve',
                        onTap: () {
                          Navigator.of(context).pop();
                          _showComingSoon('Savings Certificates');
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await ref
                            .read(authControllerProvider.notifier)
                            .logout();
                      },
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text('Terminar sessão'),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _drawerTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? subtitle,
    bool selected = false,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      selected: selected,
      selectedTileColor: const Color(0xFFEDE9FE),
      leading: Icon(
        icon,
        color: selected ? const Color(0xFF6366F1) : const Color(0xFF4B5563),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: selected ? const Color(0xFF4338CA) : const Color(0xFF111827),
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
            ),
      onTap: onTap,
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature estará disponível em breve.')),
    );
  }

  Future<void> _confirmDeleteTransaction(Transaction transaction) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar transação'),
        content: Text(
          'Tens a certeza que queres eliminar "${transaction.category}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    try {
      await ref
          .read(transactionControllerProvider.notifier)
          .deleteTransaction(transaction.id);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Transação eliminada com sucesso.')),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao eliminar transação: $e')));
    }
  }

  // ─── HELPER: Converte o nome da categoria no ícone correspondente ───
  // Usado para mostrar o ícone correto em cada TransactionItem
  IconData _categoryIcon(String category) {
    // Switch expression (Dart 3) — mais compacto que switch statement
    return switch (category) {
      'Alimentação' => Icons.restaurant,
      'Transporte' => Icons.directions_car,
      'Saúde' => Icons.local_hospital,
      'Lazer' => Icons.sports_esports,
      'Casa' => Icons.home,
      'Educação' => Icons.school,
      'Compras' => Icons.shopping_cart,
      'Subscrições' => Icons.subscriptions,
      'Tecnologia' => Icons.computer,
      'Viagens' => Icons.flight,
      'Animais' => Icons.pets,
      'Salário' => Icons.attach_money,
      'Freelance' => Icons.work,
      _ => Icons.category, // _ é o "default" — qualquer outro valor
    };
  }

  // ─── HELPER: Converte o número do mês no nome abreviado ───
  // ex: 3 → "Mar", 12 → "Dez"
  String _monthName(int month) {
    const months = [
      '', // índice 0 (meses vão de 1 a 12)
      'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
      'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez',
    ];
    return months[month];
  }

  String _fullDatePt(DateTime date) {
    const months = [
      '',
      'janeiro',
      'fevereiro',
      'março',
      'abril',
      'maio',
      'junho',
      'julho',
      'agosto',
      'setembro',
      'outubro',
      'novembro',
      'dezembro',
    ];
    return '${date.day} de ${months[date.month]} de ${date.year}';
  }

  String _shortDatePt(DateTime date) {
    return '${date.day} ${_monthName(date.month)}';
  }

  String _userInitial(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      return 'C';
    }
    return trimmed.substring(0, 1).toUpperCase();
  }

  String _displayName(User? user) {
    if (user == null) {
      return 'Utilizador';
    }

    final displayName = user.displayName?.trim();
    if (displayName != null && displayName.isNotEmpty) {
      return displayName;
    }

    final email = user.email;
    final at = email.indexOf('@');
    if (at > 0) {
      return email.substring(0, at);
    }

    return 'Utilizador';
  }
}

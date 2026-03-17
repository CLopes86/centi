// ============================================
// SCREEN: AddTransactionScreen
//
// OBJETIVO:
// Formulário para adicionar receita ou despesa
// Design moderno com gradiente indigo/roxo (matching splash)
// ============================================
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:centi/features/auth/presentation/controllers/auth_controller.dart';
import 'package:centi/features/transactions/domain/entities/transaction.dart';
import 'package:centi/features/transactions/presentation/controllers/transaction_controller.dart';

class AddTransactionScreen extends ConsumerStatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  ConsumerState<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends ConsumerState<AddTransactionScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool _isExpense = true;
  String _selectedCategory = '';
  DateTime _selectedDate = DateTime.now();
  bool _isSaving = false; // Controla o estado de loading do botão

  // ─── CORES DO BRANDING (mesmas do splash e app_theme) ───
  // Definidas aqui como static const para reutilizar no build()
  static const Color _indigo = Color(0xFF6366F1);
  static const Color _purple = Color(0xFF8B5CF6);
  // Versões mais suaves de vermelho/verde para indicar despesa/receita
  static const Color _expenseRed = Color(0xFFEF4444);
  static const Color _incomeGreen = Color(0xFF10B981);

  // ─── CATEGORIAS DISPONÍVEIS ───
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Alimentação', 'icon': Icons.restaurant},
    {'name': 'Transporte', 'icon': Icons.directions_car},
    {'name': 'Saúde', 'icon': Icons.local_hospital},
    {'name': 'Lazer', 'icon': Icons.sports_esports},
    {'name': 'Casa', 'icon': Icons.home},
    {'name': 'Educação', 'icon': Icons.school},
    {'name': 'Compras', 'icon': Icons.shopping_cart},
    {'name': 'Subscrições', 'icon': Icons.subscriptions},
    {'name': 'Tecnologia', 'icon': Icons.computer},
    {'name': 'Viagens', 'icon': Icons.flight},
    {'name': 'Animais', 'icon': Icons.pets},
    {'name': 'Salário', 'icon': Icons.attach_money},
    {'name': 'Freelance', 'icon': Icons.work},
    {'name': 'Outros', 'icon': Icons.category},
  ];

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // ─── MÉTODO: GUARDAR TRANSAÇÃO ───
  // Chamado quando o utilizador toca no botão "Guardar Transação"
  Future<void> _guardarTransacao() async {
    // 1. VALIDAÇÃO — verificar se os campos obrigatórios estão preenchidos
    final amountText = _amountController.text.trim();

    if (amountText.isEmpty) {
      // ScaffoldMessenger mostra uma SnackBar (mensagem temporária no fundo)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Introduz um valor')));
      return; // Sai do método sem guardar
    }

    // double.tryParse — tenta converter o texto para número
    // Retorna null se não for um número válido (ex: "abc")
    final amount = double.tryParse(amountText.replaceAll(',', '.'));
    // ↑ replaceAll(',', '.') — substitui vírgula por ponto (ex: "12,50" → "12.50")

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Valor inválido')));
      return;
    }

    if (_selectedCategory.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Seleciona uma categoria')));
      return;
    }

    // 2. OBTER O UTILIZADOR AUTENTICADO
    final authState = ref.read(authControllerProvider);
    final user = authState.when(
      data: (u) => u,
      loading: () => null,
      error: (_, __) => null,
    );

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erro: sessão expirada. Faz login novamente.'),
        ),
      );
      return;
    }

    // 3. MOSTRAR LOADING — desativa o botão e mostra spinner
    setState(() => _isSaving = true);

    try {
      // 4. CRIAR O OBJETO Transaction
      final transaction = Transaction(
        id: const Uuid().v4(),
        // ↑ Uuid().v4() gera um ID único universalmente (ex: "550e8400-e29b-41d4-a716-446655440000")
        // É o padrão para gerar IDs sem depender do servidor
        userId: user.id,
        amount: amount,
        type: _isExpense ? TransactionType.expense : TransactionType.income,
        // ↑ Converte o bool _isExpense para o enum TransactionType
        category: _selectedCategory,
        description: _descriptionController.text.trim(),
        date: _selectedDate,
      );

      // 5. ENVIAR PARA O FIRESTORE via controller
      await ref
          .read(transactionControllerProvider.notifier)
          .addTransaction(transaction);

      // 6. VOLTAR AO DASHBOARD com mensagem de sucesso
      if (mounted) {
        // mounted — verifica se o widget ainda está na árvore de widgets
        // Importante verificar antes de usar context após um await
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transação guardada com sucesso!'),
            backgroundColor: Color(0xFF10B981), // Verde de receita
          ),
        );
        context.pop(); // Volta à página anterior (Dashboard)
      }
    } catch (e) {
      // 7. ERRO — mostrar mensagem e reativar o botão
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao guardar: $e')));
      }
    } finally {
      // finally — corre SEMPRE, com erro ou sem erro
      // Garante que o botão volta ao normal mesmo que algo falhe
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo com tom muito leve de indigo — não é branco puro
      backgroundColor: const Color(0xFFF8F9FE),

      // ─── APP BAR TRANSPARENTE ───
      // Estilo moderno: sem fundo, texto indigo, seta estilo iOS
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Nova Transação',
          style: TextStyle(color: _indigo, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: _indigo),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ═══════════════════════════════════════
            // CARD PRINCIPAL — Gradiente com toggle + valor
            // Estilo "cartão bancário" com sombra indigo
            // ═══════════════════════════════════════
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                // Gradiente indigo→roxo (igual ao splash)
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [_indigo, _purple],
                ),
                borderRadius: BorderRadius.circular(20),
                // Sombra com cor indigo para efeito "glow"
                boxShadow: [
                  BoxShadow(
                    color: _indigo.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // ─── TOGGLE DESPESA / RECEITA ───
                  // Fundo semi-transparente branco sobre o gradiente
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        // Botão DESPESA
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isExpense = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                // Selecionado = fundo branco sólido
                                color: _isExpense
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Seta ↓ vermelha = dinheiro a sair
                                    Icon(
                                      Icons.arrow_downward,
                                      size: 16,
                                      color: _isExpense
                                          ? _expenseRed
                                          : Colors.white70,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Despesa',
                                      style: TextStyle(
                                        color: _isExpense
                                            ? _expenseRed
                                            : Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Botão RECEITA
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isExpense = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: !_isExpense
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Seta ↑ verde = dinheiro a entrar
                                    Icon(
                                      Icons.arrow_upward,
                                      size: 16,
                                      color: !_isExpense
                                          ? _incomeGreen
                                          : Colors.white70,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Receita',
                                      style: TextStyle(
                                        color: !_isExpense
                                            ? _incomeGreen
                                            : Colors.white70,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ─── CAMPO DE VALOR (€) ───
                  // Row com MainAxisSize.min: o número e o € ficam juntos
                  // Center centra o conjunto todo no card
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      // ↑ O Row ocupa só o espaço do conteúdo (não estica)
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      // ↑ Alinha pela linha de base do texto (fundo das letras)
                      // Sem isto, o "€" ficaria desalinhado verticalmente
                      children: [
                        IntrinsicWidth(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            cursorColor: Colors.white,
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              filled: false,
                              hintText: '0.00',
                              hintStyle: TextStyle(
                                fontSize: 48,
                                color: Colors.white.withValues(alpha: 0.4),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                        // "€" como widget separado — fica colado ao número
                        const Text(
                          ' €',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ═══════════════════════════════════════
            // SECÇÃO DE CATEGORIAS
            // ═══════════════════════════════════════
            Text(
              'Categoria',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category['name'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category['name'] as String;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      // Selecionado = indigo (cor da marca), não selecionado = branco
                      color: isSelected ? _indigo : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? _indigo : Colors.grey[300]!,
                      ),
                      // Sombra suave quando selecionado
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: _indigo.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          category['icon'] as IconData,
                          size: 18,
                          color: isSelected ? Colors.white : Colors.grey[600],
                        ),
                        const SizedBox(width: 6),
                        Text(
                          category['name'] as String,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.grey[700],
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // ═══════════════════════════════════════
            // CAMPO DE DESCRIÇÃO
            // Usa o estilo do tema (fundo branco, borda indigo no focus)
            // ═══════════════════════════════════════
            TextField(
              controller: _descriptionController,
              maxLength: 100,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                labelText: 'Descrição (opcional)',
                hintText: 'Ex: Almoço no trabalho',
                prefixIcon: const Icon(Icons.edit_note, color: _indigo),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: _indigo, width: 2),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ═══════════════════════════════════════
            // SELETOR DE DATA
            // Estilo card branco com ícone indigo
            // ═══════════════════════════════════════
            GestureDetector(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[200]!),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: _indigo, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      '${_selectedDate.day.toString().padLeft(2, '0')}/'
                      '${_selectedDate.month.toString().padLeft(2, '0')}/'
                      '${_selectedDate.year}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.arrow_drop_down, color: Colors.grey[400]),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            // ═══════════════════════════════════════
            // BOTÃO GUARDAR — Gradiente indigo→roxo com sombra
            // Container com gradient + ElevatedButton transparente por cima
            // ═══════════════════════════════════════
            Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [_indigo, _purple]),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: _indigo.withValues(alpha: 0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                // Se _isSaving=true, passa null ao onPressed — desativa o botão
                onPressed: _isSaving ? null : _guardarTransacao,
                style: ElevatedButton.styleFrom(
                  // Transparente para deixar o gradiente do Container visível
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: _isSaving
                    // Enquanto guarda, mostra um spinner em vez do texto
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, size: 22),
                          SizedBox(width: 8),
                          Text(
                            'Guardar Transação',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

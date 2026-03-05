// ============================================
// SCREEN: AddTransactionScreen
//
// OBJETIVO:
// Formulário para adicionar receita ou despesa
// Design moderno com gradiente indigo/roxo (matching splash)
// ============================================
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                onPressed: () {
                  // TODO: Parte 7 — validação e envio para Firestore
                },
                style: ElevatedButton.styleFrom(
                  // Transparente para deixar o gradiente do Container visível
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Row(
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

// TODO: AddTransactionScreen — formulário para adicionar receita ou despesa
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

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Transaçao')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isExpense = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _isExpense ? Colors.red : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Despesa',
                            style: TextStyle(
                              color: _isExpense
                                  ? Colors.white
                                  : Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _isExpense = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          // Se NÃO é despesa (é receita), fundo verde
                          color: !_isExpense
                              ? Colors.green
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Receita',
                            style: TextStyle(
                              color: !_isExpense
                                  ? Colors.white
                                  : Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ), // Espaço entre o toggle e o campo de valor
            // ─── CAMPO DE VALOR (€) ───
            // TextField grande e centrado para o utilizador escrever o montante
            TextField(
              controller: _amountController, // Liga ao controller que criámos
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              // ↑ Abre o teclado numérico com ponto decimal
              textAlign: TextAlign.center, // Texto centrado
              style: TextStyle(
                fontSize: 48, // Tamanho grande para destaque
                fontWeight: FontWeight.bold,
                // Cor muda conforme o tipo: vermelho para despesa, verde para receita
                color: _isExpense ? Colors.red : Colors.green,
              ),
              decoration: InputDecoration(
                hintText: '0.00', // Texto placeholder quando vazio
                hintStyle: TextStyle(
                  fontSize: 48,
                  color: Colors.grey[300], // Placeholder bem clarinho
                ),
                prefixText: '€ ', // Símbolo do euro antes do número
                prefixStyle: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _isExpense ? Colors.red : Colors.green,
                ),
                border: InputBorder.none, // Remove a linha por baixo do campo
              ),
            ),
          ],
        ),
      ),
    );
  }
}

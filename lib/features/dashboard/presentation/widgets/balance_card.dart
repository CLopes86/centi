import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  final double balance;
  final double income;
  final double expenses;

  const BalanceCard({
    super.key,
    required this.balance,
    required this.income,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Saldo Total',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '€ ${_formatNumber(balance)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),

          Divider(color: Colors.white.withValues(alpha: 0.3)),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _statItem(
                  icon: Icons.arrow_upward,
                  iconColor: const Color(
                    0xFF00FF87,
                  ), // verde néon — visível no escuro // verde claro
                  label: 'Receitas',
                  value: income,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              Expanded(
                child: _statItem(
                  icon: Icons.arrow_downward,
                  iconColor: const Color(
                    0xFFFF4757,
                  ), // vermelho vivo — visível no escuro
                  label: 'Despesas',
                  value: expenses,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── HELPER: _statItem ────────────────────────
  // Cria um bloco de estatística (ícone + label + valor).
  // Usado para Receitas e Despesas.
  Widget _statItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required double value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // Círculo com o ícone
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.35),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              Text(
                '€ ${_formatNumber(value)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── HELPER: _formatNumber ───────────────────
  // Formata um número para o estilo europeu:
  // 1234.56 → "1 234,56"
  // Separador de milhar = espaço, decimal = vírgula
  String _formatNumber(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    // split('.'): divide "1234.56" em ["1234", "56"]
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      // RegExp: expressão regular que encontra grupos de 3 dígitos
      (m) => '${m[1]} ', // adiciona espaço a cada 3 dígitos
    );
    return '$intPart,${parts[1]}'; // junta com vírgula
  }
}

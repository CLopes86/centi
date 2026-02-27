// TODO: Transaction entity — enum TransactionType + class Transaction
enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String userId;
  final double amount;
  final TransactionType type;
  final String category;
  final String description;
  final DateTime date;

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.category,
    required this.description,
    required this.date,
  }) {
    if (id.isEmpty) {
      throw ArgumentError('ID não pode estar vazio');
    }
    if (userId.isEmpty) {
      throw ArgumentError('UserId não pode estar vazio');
    }
    if (amount <= 0) {
      throw ArgumentError('Valor deve ser sempre positivo');
    }
    if (category.isEmpty) {
      throw ArgumentError('Categoria não podes estar vazia');
    }
  }

  // copyWith — permite criar uma cópia com campos alterados
  Transaction copyWith({
    String? id,
    String? userId,
    double? amount,
    TransactionType? type,
    String? category,
    String? description,
    DateTime? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}

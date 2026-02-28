// TODO: TransactionModel — extends Transaction, com fromJson, toJson, fromFirestore
import 'package:centi/features/transactions/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.userId,
    required super.amount,
    required super.type,
    required super.category,
    required super.description,
    required super.date,
  });

  factory TransactionModel.fromFirestore(Map<String, dynamic> map, String id) {
    return TransactionModel(
      id: id,
      userId: map['userId'] as String,
      amount: (map['amount'] as num).toDouble(),
      type: map['type'] == 'income'
          ? TransactionType.income
          : TransactionType.expense,
      category: map['category'] as String,
      description: map['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'amount': amount,
      'type': type == TransactionType.income ? 'income' : 'expense',
      'category': category,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }
}

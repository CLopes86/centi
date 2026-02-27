import 'package:centi/features/transactions/domain/entities/transaction.dart';
import 'package:centi/features/transactions/domain/repositories/transaction_repository.dart';

class AddTransaction {
  final TransactionRepository repository;

  AddTransaction(this.repository);

  Future<void> call(Transaction transaction) async {
    return await repository.addTransaction(transaction);
  }
}

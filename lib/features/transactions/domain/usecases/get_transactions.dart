import 'package:centi/features/transactions/domain/entities/transaction.dart';
import 'package:centi/features/transactions/domain/repositories/transaction_repository.dart';

class GetTransactions {
  final TransactionRepository repository;

  GetTransactions(this.repository);

  Stream<List<Transaction>> call(String userId) {
    return repository.getTransactions(userId);
  }
}

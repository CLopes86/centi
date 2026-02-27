// TODO: DeleteTransaction use case — recebe transactionId, chama repository.deleteTransaction
import 'package:centi/features/transactions/domain/repositories/transaction_repository.dart';

class DeleteTransaction {
  final TransactionRepository repository;

  DeleteTransaction(this.repository);

  Future<void> call(String transactionId) async {
    return await repository.deleteTransaction(transactionId);
  }
}

import 'package:centi/features/transactions/domain/entities/transaction.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(Transaction transaction);

  Stream<List<Transaction>> getTransactions(String userId);

  Future<void> deleteTransaction(String transactionId);
}

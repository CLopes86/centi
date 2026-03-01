// TODO: TransactionRepositoryImpl — implementa TransactionRepository usando o datasource
import 'package:centi/features/transactions/data/datasources/transaction_remote_datasource.dart';
import 'package:centi/features/transactions/data/models/transaction_model.dart';
import 'package:centi/features/transactions/domain/entities/transaction.dart';
import 'package:centi/features/transactions/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDatasource datasource;

  TransactionRepositoryImpl(this.datasource);

  @override
  Future<void> addTransaction(Transaction transaction) async {
    final model = TransactionModel(
      id: transaction.id,
      userId: transaction.userId,
      amount: transaction.amount,
      type: transaction.type,
      category: transaction.category,
      description: transaction.description,
      date: transaction.date,
    );
    await datasource.addTransaction(model);
  }

  @override
  Future<void> deleteTransaction(String userId, String transactionId) async {
    // TODO: implement deleteTransaction
    await datasource.deleteTransaction(userId, transactionId);
  }

  @override
  Stream<List<Transaction>> getTransactions(String userId) {
    // TODO: implement getTransactions
    return datasource.getTransactions(userId);
  }
}

// TODO: transaction_providers.dart — Riverpod providers para datasource, repository e use cases
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:centi/features/transactions/data/datasources/transaction_remote_datasource.dart';
import 'package:centi/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:centi/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:centi/features/transactions/domain/usecases/add_transaction.dart';
import 'package:centi/features/transactions/domain/usecases/delete_transaction.dart';
import 'package:centi/features/transactions/domain/usecases/get_transactions.dart';

part 'transaction_providers.g.dart';

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
TransactionRemoteDatasource transactionRemoteDatasource(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return TransactionRemoteDatasource(firestore);
}

@riverpod
TransactionRepository transactionRepository(Ref ref) {
  final datasource = ref.watch(transactionRemoteDatasourceProvider);
  return TransactionRepositoryImpl(datasource);
}

@riverpod
AddTransaction addTransaction(Ref ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return AddTransaction(repository);
}

@riverpod
GetTransactions getTransactions(Ref ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return GetTransactions(repository);
}

@riverpod
DeleteTransaction deleteTransaction(Ref ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return DeleteTransaction(repository);
}

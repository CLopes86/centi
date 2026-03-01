import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:centi/features/auth/presentation/controllers/auth_controller.dart';
import 'package:centi/features/transactions/domain/entities/transaction.dart';
import 'package:centi/features/transactions/presentation/providers/transaction_providers.dart';

part 'transaction_controller.g.dart';

@riverpod
class TransactionController extends _$TransactionController {
  StreamSubscription<List<Transaction>>? _subscription;

  @override
  Future<List<Transaction>> build() async {
    final authState = ref.watch(authControllerProvider);

    final user = authState.when(
      data: (user) => user,
      loading: () => null,
      error: (_, __) => null,
    );

    if (user == null) {
      return [];
    }

    final getTransactionsUseCase = ref.read(getTransactionsProvider);

    _subscription?.cancel();
    _subscription = getTransactionsUseCase(user.id).listen(
      (transactions) {
        state = AsyncValue.data(transactions);
      },
      onError: (error, stackTrace) {
        state = AsyncValue.error(error, stackTrace);
      },
    );

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return [];
  }

  Future<void> addTransaction(Transaction transaction) async {
    final addTransactionUseCase = ref.read(addTransactionProvider);

    await addTransactionUseCase(transaction);
  }

  Future<void> deleteTransaction(String transactionId) async {
    final authState = ref.read(authControllerProvider);

    final user = authState.when(
      data: (user) => user,
      loading: () => null,
      error: (_, __) => null,
    );

    if (user == null) {
      throw StateError('Utilizador não autenticado');
    }

    final deleteTransactionUseCase = ref.read(deleteTransactionProvider);

    await deleteTransactionUseCase(user.id, transactionId);
  }
}

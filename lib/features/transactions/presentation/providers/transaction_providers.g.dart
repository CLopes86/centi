// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseFirestore)
const firebaseFirestoreProvider = FirebaseFirestoreProvider._();

final class FirebaseFirestoreProvider
    extends
        $FunctionalProvider<
          FirebaseFirestore,
          FirebaseFirestore,
          FirebaseFirestore
        >
    with $Provider<FirebaseFirestore> {
  const FirebaseFirestoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseFirestoreProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseFirestoreHash();

  @$internal
  @override
  $ProviderElement<FirebaseFirestore> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseFirestore create(Ref ref) {
    return firebaseFirestore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFirestore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFirestore>(value),
    );
  }
}

String _$firebaseFirestoreHash() => r'963402713bf9b7cc1fb259d619d9b0184d4dcec1';

@ProviderFor(transactionRemoteDatasource)
const transactionRemoteDatasourceProvider =
    TransactionRemoteDatasourceProvider._();

final class TransactionRemoteDatasourceProvider
    extends
        $FunctionalProvider<
          TransactionRemoteDatasource,
          TransactionRemoteDatasource,
          TransactionRemoteDatasource
        >
    with $Provider<TransactionRemoteDatasource> {
  const TransactionRemoteDatasourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionRemoteDatasourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionRemoteDatasourceHash();

  @$internal
  @override
  $ProviderElement<TransactionRemoteDatasource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionRemoteDatasource create(Ref ref) {
    return transactionRemoteDatasource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionRemoteDatasource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionRemoteDatasource>(value),
    );
  }
}

String _$transactionRemoteDatasourceHash() =>
    r'1546393fd568188a1c32d5ebc584924eb9e72464';

@ProviderFor(transactionRepository)
const transactionRepositoryProvider = TransactionRepositoryProvider._();

final class TransactionRepositoryProvider
    extends
        $FunctionalProvider<
          TransactionRepository,
          TransactionRepository,
          TransactionRepository
        >
    with $Provider<TransactionRepository> {
  const TransactionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'transactionRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$transactionRepositoryHash();

  @$internal
  @override
  $ProviderElement<TransactionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TransactionRepository create(Ref ref) {
    return transactionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TransactionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TransactionRepository>(value),
    );
  }
}

String _$transactionRepositoryHash() =>
    r'4ac82f75bfafbd18a30b8d84e4e00f0058883c66';

@ProviderFor(addTransaction)
const addTransactionProvider = AddTransactionProvider._();

final class AddTransactionProvider
    extends $FunctionalProvider<AddTransaction, AddTransaction, AddTransaction>
    with $Provider<AddTransaction> {
  const AddTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addTransactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addTransactionHash();

  @$internal
  @override
  $ProviderElement<AddTransaction> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AddTransaction create(Ref ref) {
    return addTransaction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AddTransaction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AddTransaction>(value),
    );
  }
}

String _$addTransactionHash() => r'e357bfd13f600d53b89a861673e727b3a088cde2';

@ProviderFor(getTransactions)
const getTransactionsProvider = GetTransactionsProvider._();

final class GetTransactionsProvider
    extends
        $FunctionalProvider<GetTransactions, GetTransactions, GetTransactions>
    with $Provider<GetTransactions> {
  const GetTransactionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTransactionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTransactionsHash();

  @$internal
  @override
  $ProviderElement<GetTransactions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GetTransactions create(Ref ref) {
    return getTransactions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTransactions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTransactions>(value),
    );
  }
}

String _$getTransactionsHash() => r'c1a1bfabd1a6e8332246b08adc2132b841abf85c';

@ProviderFor(deleteTransaction)
const deleteTransactionProvider = DeleteTransactionProvider._();

final class DeleteTransactionProvider
    extends
        $FunctionalProvider<
          DeleteTransaction,
          DeleteTransaction,
          DeleteTransaction
        >
    with $Provider<DeleteTransaction> {
  const DeleteTransactionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deleteTransactionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deleteTransactionHash();

  @$internal
  @override
  $ProviderElement<DeleteTransaction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeleteTransaction create(Ref ref) {
    return deleteTransaction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeleteTransaction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeleteTransaction>(value),
    );
  }
}

String _$deleteTransactionHash() => r'f31d4bceadace0bd4e2d57ea902f661a429b4948';

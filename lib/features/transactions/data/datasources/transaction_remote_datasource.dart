import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:centi/features/transactions/data/models/transaction_model.dart';

class TransactionRemoteDatasource {
  final FirebaseFirestore firestore;

  TransactionRemoteDatasource(this.firestore);

  CollectionReference _collection(String userId) {
    return firestore.collection('users').doc(userId).collection('transactions');
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await _collection(
      transaction.userId,
    ).doc(transaction.id).set(transaction.toFirestore());
  }

  Stream<List<TransactionModel>> getTransactions(String userId) {
    return _collection(userId).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TransactionModel.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }

  Future<void> deleteTransaction(String userId, String transactionId) async {
    await _collection(userId).doc(transactionId).delete();
  }
}

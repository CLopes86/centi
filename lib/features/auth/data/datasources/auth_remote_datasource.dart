// DataSource - Comunicação direta com Firebase Authentication

import 'package:firebase_auth/firebase_auth.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource(this.firebaseAuth);

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createUser({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<void> updateDisplayName(String displayName) async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw StateError('Utilizador não autenticado');
    }

    await user.updateDisplayName(displayName);
    await user.reload();
  }

  Future<void> updatePhotoUrl(String photoUrl) async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw StateError('Utilizador não autenticado');
    }

    await user.updatePhotoURL(photoUrl);
    await user.reload();
  }

  Future<void> updatePassword(String newPassword) async {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw StateError('Utilizador não autenticado');
    }

    await user.updatePassword(newPassword);
  }

  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}

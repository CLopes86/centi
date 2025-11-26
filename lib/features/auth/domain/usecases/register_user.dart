// Use Case - Registar novo utilizador

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<User> call({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final user = await repository.register(
      email: email,
      password: password,
      displayName: displayName,
    );

    return user;
  }
}

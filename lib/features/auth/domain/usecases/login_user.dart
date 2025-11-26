// Use Case - Login de utilizador

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<User> call({required String email, required String password}) async {
    final user = await repository.login(email: email, password: password);

    return user;
  }
}

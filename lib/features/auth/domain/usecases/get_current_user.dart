// Use Case - Obter utilizador atual
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<User?> call() async {
    final user = await repository.getCurrentUser();

    return user;
  }
}

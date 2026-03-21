import 'package:centi/features/auth/domain/repositories/auth_repository.dart';

/// Caso de uso para atualizar a password do utilizador autenticado.
class UpdatePassword {
  final AuthRepository repository;

  UpdatePassword(this.repository);

  Future<void> call(String newPassword) async {
    return repository.updatePassword(newPassword);
  }
}

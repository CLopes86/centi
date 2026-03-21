import 'package:centi/features/auth/domain/entities/user.dart';
import 'package:centi/features/auth/domain/repositories/auth_repository.dart';

/// Caso de uso para atualizar o nome de exibição do utilizador autenticado.
class UpdateDisplayName {
  final AuthRepository repository;

  UpdateDisplayName(this.repository);

  Future<User> call(String displayName) async {
    return repository.updateDisplayName(displayName);
  }
}

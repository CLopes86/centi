import 'package:centi/features/auth/domain/entities/user.dart';
import 'package:centi/features/auth/domain/repositories/auth_repository.dart';

/// Caso de uso para atualizar a URL da foto de perfil do utilizador autenticado.
class UpdatePhotoUrl {
  final AuthRepository repository;

  UpdatePhotoUrl(this.repository);

  Future<User> call(String photoUrl) async {
    return repository.updatePhotoUrl(photoUrl);
  }
}

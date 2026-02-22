/// Interface do repositório de autenticação.
///
/// Define o contrato que as implementações de autenticação devem seguir.
/// Esta interface pertence à camada de domínio e não deve ter dependências externas.
library;

import '../entities/user.dart';

/// Repositório de autenticação - Define operações de autenticação.
///
/// Esta interface será implementada na camada de dados (data layer).
abstract class AuthRepository {
  /// Realiza login com email e senha.
  ///
  /// Retorna um [User] se o login for bem-sucedido.
  /// Lança exceção em caso de erro (credenciais inválidas, etc).
  Future<User> login({required String email, required String password});

  /// Regista um novo utilizador com email e senha.
  ///
  /// Parâmetros:
  /// - [email]: Email do novo utilizador
  /// - [password]: Senha do novo utilizador
  /// - [displayName]: Nome de exibição (opcional)
  ///
  /// Retorna um [User] se o registo for bem-sucedido.
  /// Lança exceção se o email já estiver em uso ou dados inválidos.
  Future<User> register({
    required String email,
    required String password,
    String? displayName,
  });

  /// Termina a sessão do utilizador atual.
  ///
  /// Lança exceção em caso de erro ao fazer logout.
  Future<void> logout();

  /// Obtém o utilizador atualmente autenticado.
  ///
  /// Retorna [User] se houver um utilizador autenticado.
  /// Retorna `null` se não houver utilizador autenticado.
  Future<User?> getCurrentUser();
}

/// Entity User - Representa um utilizador na aplicação.
///
/// Esta é uma entidade de domínio pura, sem dependências externas.
/// Contém apenas as propriedades essenciais de um utilizador e validações básicas.
library;

/// Entidade que representa um utilizador no domínio da aplicação.
class User {
  /// Identificador único do utilizador.
  final String id;

  /// Endereço de email do utilizador.
  final String email;

  /// Nome de exibição do utilizador (opcional).
  final String? displayName;

  /// Cria uma instância de [User].
  ///
  /// Valida que:
  /// - [id] não está vazio
  /// - [email] não está vazio
  /// - [email] contém o caractere '@'
  ///
  /// Lança [ArgumentError] se alguma validação falhar.
  User({required this.id, required this.email, this.displayName}) {
    if (id.isEmpty) {
      throw ArgumentError('ID não pode estar vazio');
    }

    if (email.isEmpty) {
      throw ArgumentError('Email não pode estar vazio');
    }

    if (!email.contains('@')) {
      throw ArgumentError('Email deve conter @');
    }
  }

  /// Cria uma cópia deste [User] com os campos especificados atualizados.
  ///
  /// Permite criar uma nova instância mantendo a imutabilidade do objeto original.
  ///
  /// Exemplo:
  /// ```dart
  /// final user = User(id: '123', email: 'joao@email.com');
  /// final userAtualizado = user.copyWith(displayName: 'João Silva');
  /// ```
  User copyWith({String? id, String? email, String? displayName}) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
    );
  }
}

// Entity User - Representa um utilizador na aplicação

class User {
  final String id;
  final String email;
  final String? displayName;

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

  User copyWith({String? id, String? email, String? displayName}) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
    );
  }
}

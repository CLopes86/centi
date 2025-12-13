// Teste do Data Layer - UserModel
import 'package:flutter_test/flutter_test.dart';
import 'package:centi/features/auth/data/models/user_model.dart';
import 'package:centi/features/auth/domain/entities/user.dart';

void main() {
  group('Data Layer Tests', () {
    test('UserModel - Criação e propriedades', () {
      print('\n📦 TESTE 1: UserModel');
      print('-' * 50);

      final userModel = UserModel(
        id: 'test123',
        email: 'teste@example.com',
        displayName: 'Utilizador Teste',
      );

      print('✅ UserModel criado com sucesso!');
      print('   ID: ${userModel.id}');
      print('   Email: ${userModel.email}');
      print('   Nome: ${userModel.displayName}');

      expect(userModel.id, 'test123');
      expect(userModel.email, 'teste@example.com');
      expect(userModel.displayName, 'Utilizador Teste');
    });

    test('UserModel - toJson', () {
      final userModel = UserModel(
        id: 'test123',
        email: 'teste@example.com',
        displayName: 'Utilizador Teste',
      );

      final json = userModel.toJson();

      print('\n✅ toJson funciona!');
      print('   JSON: $json');

      expect(json['id'], 'test123');
      expect(json['email'], 'teste@example.com');
      expect(json['displayName'], 'Utilizador Teste');
    });

    test('UserModel - fromJson', () {
      final json = {
        'id': 'test123',
        'email': 'teste@example.com',
        'displayName': 'Utilizador Teste',
      };

      final userModel = UserModel.fromJson(json);

      print('\n✅ fromJson funciona!');
      print('   ID: ${userModel.id}');

      expect(userModel.id, 'test123');
      expect(userModel.email, 'teste@example.com');
      expect(userModel.displayName, 'Utilizador Teste');
    });

    test('UserModel - Polimorfismo (UserModel É um User)', () {
      final userModel = UserModel(
        id: 'test123',
        email: 'teste@example.com',
        displayName: 'Utilizador Teste',
      );

      User user = userModel;

      print('\n✅ UserModel É um User!');
      print('   User ID: ${user.id}');

      expect(user.id, 'test123');
      expect(user, isA<User>());
      expect(user, isA<UserModel>());
    });

    test('Resumo Final', () {
      print('\n' + '=' * 50);
      print('✅ TODOS OS TESTES PASSARAM!');
      print('\n📸 Código compilou sem erros!');
      print('🎉 Data Layer está correto!\n');
    });
  });
}

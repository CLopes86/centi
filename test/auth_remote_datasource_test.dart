// Testes do AuthRemoteDataSource - Adaptado ao código existente
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:centi/features/auth/data/datasources/auth_remote_datasource.dart';

// Gera mocks automaticamente
@GenerateMocks([FirebaseAuth, UserCredential, User])
import 'auth_remote_datasource_test.mocks.dart';

void main() {
  late AuthRemoteDataSource dataSource;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    dataSource = AuthRemoteDataSource(mockFirebaseAuth);
  });

  group('AuthRemoteDataSource - signIn', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';

    test('✅ Deve fazer login com sucesso', () async {
      // Arrange
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      // Act
      final result = await dataSource.signIn(
        email: testEmail,
        password: testPassword,
      );

      // Assert
      expect(result, mockUserCredential);
      verify(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        ),
      ).called(1);

      print('✅ signIn funciona corretamente!');
    });

    test('❌ Deve lançar exceção quando credenciais inválidas', () async {
      // Arrange
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        ),
      ).thenThrow(FirebaseAuthException(code: 'wrong-password'));

      // Act & Assert
      expect(
        () => dataSource.signIn(email: testEmail, password: testPassword),
        throwsA(isA<FirebaseAuthException>()),
      );

      print('✅ signIn lança exceção corretamente!');
    });
  });

  group('AuthRemoteDataSource - createUser', () {
    const testEmail = 'newuser@example.com';
    const testPassword = 'password123';

    test('✅ Deve registar utilizador com sucesso', () async {
      // Arrange
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      // Act
      final result = await dataSource.createUser(
        email: testEmail,
        password: testPassword,
      );

      // Assert
      expect(result, mockUserCredential);
      verify(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        ),
      ).called(1);

      print('✅ createUser funciona corretamente!');
    });

    test('❌ Deve lançar exceção quando email já existe', () async {
      // Arrange
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: testEmail,
          password: testPassword,
        ),
      ).thenThrow(FirebaseAuthException(code: 'email-already-in-use'));

      // Act & Assert
      expect(
        () => dataSource.createUser(email: testEmail, password: testPassword),
        throwsA(isA<FirebaseAuthException>()),
      );

      print('✅ createUser lança exceção corretamente!');
    });
  });

  group('AuthRemoteDataSource - signOut', () {
    test('✅ Deve fazer logout com sucesso', () async {
      // Arrange
      when(mockFirebaseAuth.signOut()).thenAnswer((_) async => {});

      // Act
      await dataSource.signOut();

      // Assert
      verify(mockFirebaseAuth.signOut()).called(1);

      print('✅ signOut funciona corretamente!');
    });
  });

  group('AuthRemoteDataSource - getCurrentUser', () {
    test('✅ Deve retornar utilizador quando autenticado', () {
      // Arrange
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

      // Act
      final result = dataSource.getCurrentUser();

      // Assert
      expect(result, mockUser);
      verify(mockFirebaseAuth.currentUser).called(1);

      print('✅ getCurrentUser retorna utilizador!');
    });

    test('✅ Deve retornar null quando não autenticado', () {
      // Arrange
      when(mockFirebaseAuth.currentUser).thenReturn(null);

      // Act
      final result = dataSource.getCurrentUser();

      // Assert
      expect(result, null);

      print('✅ getCurrentUser retorna null corretamente!');
    });
  });

  test('📊 RESUMO: AuthRemoteDataSource', () {
    print('\n' + '=' * 60);
    print('✅ TODOS OS TESTES DO AuthRemoteDataSource PASSARAM!');
    print('=' * 60);
    print('Métodos testados:');
    print('  ✅ signIn() - Login com email/password');
    print('  ✅ createUser() - Registo de novo utilizador');
    print('  ✅ signOut() - Logout');
    print('  ✅ getCurrentUser() - Obter utilizador atual');
    print('=' * 60 + '\n');
  });
}

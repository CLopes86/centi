// ============================================
// FICHEIRO: auth_providers.dart
//
// OBJETIVO:
// Fornece todas as dependências da feature Auth
// usando Riverpod para injeção automática
// ============================================

import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/usecases/logout_user.dart';
import '../../domain/usecases/get_current_user.dart';

// Este ficheiro será gerado automaticamente pelo build_runner
part 'auth_providers.g.dart';

// ============================================
// PROVIDER 1: FirebaseAuth Instance
// ============================================
@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

// ============================================
// PROVIDER 2: AuthRemoteDataSource
// ============================================
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthRemoteDataSource(firebaseAuth);
}

// ============================================
// PROVIDER 3: AuthRepository
// ============================================
@riverpod
AuthRepository authRepository(Ref ref) {
  final dataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
}

// ============================================
// PROVIDER 4: LoginUser Use Case
// ============================================
@riverpod
LoginUser loginUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUser(repository);
}

// ============================================
// PROVIDER 5: RegisterUser Use Case
// ============================================
@riverpod
RegisterUser registerUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUser(repository);
}

// ============================================
// PROVIDER 6: LogoutUser Use Case
// ============================================
@riverpod
LogoutUser logoutUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUser(repository);
}

// ============================================
// PROVIDER 7: GetCurrentUser Use Case
// ============================================
@riverpod
GetCurrentUser getCurrentUser(Ref ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCurrentUser(repository);
}

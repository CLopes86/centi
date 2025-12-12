// Penny - Aplicação de Gestão de Despesas Pessoais
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:penny/core/theme/app_theme.dart';
import 'package:penny/features/auth/presentation/screens/splash_screen.dart';
import 'firebase_options.dart';

/// Ponto de entrada da aplicação.
/// Inicializa o Firebase e executa a aplicação.
void main() async {
  // Garante inicialização do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Erro ao inicializar Firebase: $e");
  }

  // Inicia app com ProviderScope (necessário para Riverpod)
  runApp(const ProviderScope(child: MyApp()));
}

/// Widget raiz que configura o MaterialApp.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penny',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Usa o tema personalizado
      home: const SplashScreen(),
    );
  }
}

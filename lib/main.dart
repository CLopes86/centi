// Penny - Aplicação de Gestão de Despesas Pessoais
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Ponto de entrada da aplicação.
/// Inicializa o Firebase e executa a aplicação.
void main() async {
  // Garante inicialização do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(child: Text('Penny - Setup Completo!')),
      ),
    );
  }
}

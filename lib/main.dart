import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MoneyFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _message = 'Pronto para testar Firebase!';

  Future<void> _testAuth() async {
    try {
      // Criar utilizador de teste
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: "teste${DateTime.now().millisecondsSinceEpoch}@example.com",
            password: "password123",
          );

      setState(() {
        _message = '✅ Utilizador criado: ${userCredential.user?.email}';
      });
    } catch (e) {
      setState(() {
        _message = '❌ Erro Auth: $e';
      });
    }
  }

  Future<void> _testFirestore() async {
    try {
      // Guardar dados de teste
      await FirebaseFirestore.instance.collection('test').add({
        'message': 'Olá do MoneyFlow!',
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _message = '✅ Dados guardados no Firestore!';
      });
    } catch (e) {
      setState(() {
        _message = '❌ Erro Firestore: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoneyFlow'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _message,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _testAuth,
                child: const Text('🔐 Testar Auth'),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _testFirestore,
                child: const Text('💾 Testar Firestore'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/auth_controller.dart';
import 'package:centi/features/auth/presentation/screens/register_screen.dart';

/// Ecrã de Login
///
/// Permite aos utilizadores autenticarem-se na aplicação utilizando Email e Password.
/// Utiliza [ConsumerStatefulWidget] para interagir com o [AuthController] via Riverpod.
///
/// Funcionalidades:
/// - Validação de formulário
/// - Feedback visual de sucesso/erro (SnackBars)
/// - Navegação para o Ecrã de Registo
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ref.listen: "Escuta" mudanças sem reconstruir o widget inteiro.
    // Ideal para mostrar diálogos, SnackBars ou navegação baseada em estado.
    ref.listen(authControllerProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login com sucesso! Bem-vindo'),
                backgroundColor: Colors.green,
              ),
            );
            // TODO: Navegar para Dashboard
          }
        },
        error: (error, stack) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro: ${error.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        },

        loading: () {
          // Opcional: Podía mostrar um loading overlay aqui
        },
      );
    });

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset('assets/images/fox_logo.png', height: 120),
                  const SizedBox(height: 32),

                  // Título e Subtítulo
                  Text(
                    'Bem-vindo de volta',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Faça login para gerir as suas finanças',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Color(0xFF9CA3AF)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  // Email Input
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      hintText: 'exemplo@email.com',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o seu email';
                      }
                      if (!value.contains('@')) {
                        return 'O email não é válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Password Input
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a password';
                      }
                      if (value.length < 6) {
                        return 'A password deve ter pelo menos 6 caracteres';
                      }
                      return null;
                    },
                  ),

                  // Esqueci password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Esqueceu a password?'),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Botão de Login
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // ref.read: "Lê" o provider apenas uma vez.
                        // Usamos .notifier para aceder aos métodos da classe (login).
                        ref
                            .read(authControllerProvider.notifier)
                            .login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                      }
                    },
                    child: const Text('Entrar'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Não tem conta?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text('Registar-se'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

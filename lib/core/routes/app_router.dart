// lib/core/routes/app_router.dart

// Este ficheiro define o router da aplicação utilizando o pacote go_router
// e fica disponível através de um provider Riverpod. O objetivo é centralizar
// toda a lógica de navegação e redirecionamentos, deixando os ecrãs limpos.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import dos ecrãs que constituem as rotas principais da app
import 'package:centi/features/auth/presentation/screens/login_screen.dart';
import 'package:centi/features/auth/presentation/screens/register_screen.dart';
import 'package:centi/features/auth/presentation/screens/splash_screen.dart';
import 'package:centi/features/dashboard/presentation/screens/dashboard_screen.dart';

// Import do controller de autenticação para saber se o utilizador está logado
import 'package:centi/features/auth/presentation/controllers/auth_controller.dart';

/// Provider que expõe um [GoRouter] configurado para o estado da aplicação.
///
/// Ele observa o [authControllerProvider] para reagir a logins/logouts e
/// aplica automaticamente os redirecionamentos definidos em [redirect].
final goRouterProvider = Provider<GoRouter>((ref) {
  // observamos o estado de autenticação para que o provider seja
  // recriado sempre que ele mudar. Isto faz com que o método `redirect`
  // seja reavaliado automaticamente.
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    // Rota inicial da aplicação, exibida logo após o main() correr
    initialLocation: '/splash',

    // Lógica central de redirecionamento baseada no estado de autenticação.
    redirect: (BuildContext context, GoRouterState state) {
      // usamos a variável capturada acima em vez de ler novamente
      // no interior da função.

      // O utilizador considera-se logado se o valor do AsyncValue não for nulo
      final bool loggedIn = authState.value != null;

      // Verifica se a rota atual é o ecrã de login/registo
      // `GoRouterState` não tem `location` na v17; usamos `uri.toString()`
      final String loc = state.uri.toString();
      final bool loggingIn = loc == '/login' || loc == '/register';

      // Se não estiver logado e tentar aceder a uma página protegida,
      // redireciona para login.
      if (!loggedIn && !loggingIn) return '/login';

      // Se estiver logado mas tentar voltar para login/registo,
      // manda-o para o dashboard.
      if (loggedIn && loggingIn) return '/dashboard';

      // Caso contrário não faz nenhuma alteração.
      return null;
    },

    // Definição das rotas pública da aplicação.
    routes: <GoRoute>[
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
});

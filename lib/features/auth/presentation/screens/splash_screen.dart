// ============================================
// SCREEN: SplashScreen
//
// OBJETIVO:
// Primeira tela da aplicação - mostra logo animado
// e verifica autenticação do utilizador
//
// FLUXO:
// 1. Mostra logo Penny com animação
// 2. Espera 2-3 segundos
// 3. Verifica se user está logado
// 4. Redireciona para Dashboard ou Login
// ============================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:penny/features/auth/presentation/screens/login_screen.dart';
import 'dart:async';
import '../controllers/auth_controller.dart';

// ============================================
// SCREEN: SplashScreen

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

// ============================================
// STATE: _SplashScreenState
// ============================================
//
// Responsabilidades:
// - Inicializar animações
// - Executar timer (2-3 segundos)
// - Verificar autenticação
// - Navegar para próxima screen
// ============================================

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ============================================
  // VARIÁVEIS DE ANIMAÇÃO
  // ============================================
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  // ============================================
  // MÉTODO: initState()
  // ============================================
  //
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    _navigateToNextScreen();
  }

  // ============================================
  // MÉTODO: _navigateToNextScreen()
  // ============================================
  //
  void _navigateToNextScreen() {
    Timer(const Duration(seconds: 3), () async {
      // Usar .future permite esperar que o carregamento termine, se ainda estiver loading
      try {
        final user = await ref.read(authControllerProvider.future);

        if (user != null) {
          print('✅ User logado: ${user.email}. Indo para Dashboard...');
          // TODO: Navegar para Dashboard
        } else {
          print('🔓 Nenhum user logado. Indo para Login...');
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        }
      } catch (e) {
        print('❌ Erro na autenticação ($e). Indo para Login...');
        // Em caso de erro, também vamos para o login por segurança
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    });
  }

  // ============================================
  // MÉTODO: dispose()
  // ============================================
  //
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ============================================
  // MÉTODO: build()
  // ============================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(
                            255,
                            215,
                            0,
                            0.4,
                          ), // Glow dourado
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/penny_logo.png',
                      width: 160,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Penny',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD700), // ← DOURADO!
                      letterSpacing: 8,
                      shadows: [
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          blurRadius: 15,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your smart financial companion',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFE0E0E0), // Cinza prateado - sofisticado
                      letterSpacing: 1,
                      shadows: [
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
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

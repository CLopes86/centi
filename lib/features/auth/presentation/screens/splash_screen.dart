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
import 'package:centi/features/auth/presentation/screens/login_screen.dart';
import 'package:centi/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'dart:async';
import '../controllers/auth_controller.dart';

// ============================================
// SCREEN: SplashScreen

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ============================================
  // VARIÁVEIS DE ANIMAÇÃO
  // ============================================
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation; // Nova animação para o brilho

  @override
  void initState() {
    super.initState();

    // Aumentei ligeiramente a duração para dar tempo do efeito "Wow"
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Fade in suave
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn), // Começa logo
      ),
    );

    // O logo cresce ligeiramente (efeito pop-up)
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    // O brilho dourado pulsa no final para destacar os "olhos/energia"
    _glowAnimation = Tween<double>(begin: 0.0, end: 30.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut), // Começa a meio
      ),
    );

    _controller.forward();

    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    // Tempo total: 8 segundos (para apreciar a animação)
    Timer(const Duration(seconds: 8), () async {
      try {
        // Verifica o estado de autenticação via Riverpod
        final user = await ref.read(authControllerProvider.future);

        if (mounted) {
          if (user != null) {
            print('✅ Centi: Bem-vindo de volta, ${user.email}');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            );
          } else {
            print('🔓 Centi: Novo acesso ou convidado');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        }
      } catch (e) {
        print('❌ Erro Auth: $e');
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Definição das Cores do Branding
    const Color indigoPrimary = Color(0xFF6366F1);
    const Color purpleSecondary = Color(0xFF8B5CF6);
    const Color goldColor = Color(0xFFFFD700);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [indigoPrimary, purpleSecondary],
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- O LOGO DA RAPOSA ---
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            // Efeito de brilho dinâmico atrás da raposa
                            BoxShadow(
                              color: Color.fromRGBO(
                                255,
                                215,
                                0,
                                0.5,
                              ), // Gold com 0.5 opacidade
                              blurRadius:
                                  _glowAnimation.value + 20, // O blur aumenta
                              spreadRadius:
                                  _glowAnimation.value / 2, // O tamanho aumenta
                            ),
                          ],
                        ),
                        // Certifica-te que a imagem é um PNG transparente
                        child: Image.asset(
                          'assets/images/fox_logo.png',
                          width: 180, // Um pouco maior para impor respeito
                          height: 180,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // --- O NOME "CENTI" ---
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      'Centi',
                      style: TextStyle(
                        fontFamily: 'Roboto', // Usa a fonte default ou custom
                        fontSize: 52,
                        fontWeight: FontWeight.bold,
                        color: goldColor,
                        letterSpacing: 4,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // --- O SLOGAN ---
                  FadeTransition(
                    // O slogan aparece ligeiramente depois do logo
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
                      ),
                    ),
                    child: Text(
                      'O teu dinheiro, ao cêntimo.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(
                          255,
                          255,
                          255,
                          0.9,
                        ), // White com 0.9 opacidade
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// ============================================================================
// MoneyFlow - Aplicação de Gestão de Despesas Pessoais
// ============================================================================
//
// Este ficheiro contém o ponto de entrada da aplicação e a configuração
// inicial do Flutter e Firebase.
//
// Estrutura:
// - main(): Função de entrada que inicializa a aplicação
// - MyApp: Widget raiz que configura o MaterialApp
// - HomePage: Tela inicial temporária (será substituída por autenticação)
//
// ============================================================================

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

// ============================================================================
// PONTO DE ENTRADA DA APLICAÇÃO
// ============================================================================

/// Função principal que inicia a aplicação MoneyFlow.
///
/// Esta é a primeira função executada quando a aplicação é iniciada.
/// Realiza as seguintes operações em sequência:
///
/// 1. **Inicialização do Flutter**: Garante que o binding do Flutter está
///    pronto antes de usar qualquer plugin nativo.
///
/// 2. **Inicialização do Firebase**: Configura o Firebase com as opções
///    específicas da plataforma (Android/iOS/Web) definidas em
///    `firebase_options.dart`.
///
/// 3. **Execução da aplicação**: Inicia a árvore de widgets com [MyApp]
///    como raiz.
///
/// **Nota Técnica**: A função é `async` porque [Firebase.initializeApp]
/// retorna um `Future` que deve ser aguardado antes de continuar.
///
/// **Exemplo de fluxo**:
/// ```
/// main() → WidgetsFlutterBinding → Firebase → runApp(MyApp)
/// ```
void main() async {
  // Garante que o Flutter está inicializado antes de usar plugins nativos.
  // Necessário quando se usa código assíncrono antes de runApp().
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as configurações específicas da plataforma.
  // As opções são geradas automaticamente pelo FlutterFire CLI.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inicia a aplicação com MyApp como widget raiz
  runApp(const MyApp());
}

// ============================================================================
// WIDGET RAIZ DA APLICAÇÃO
// ============================================================================

/// Widget raiz da aplicação MoneyFlow.
///
/// Esta classe configura o [MaterialApp] com todas as definições globais
/// da aplicação, incluindo tema, título e navegação inicial.
///
/// **Responsabilidades**:
/// - Configurar o tema visual (cores, tipografia, Material Design 3)
/// - Definir o título da aplicação
/// - Estabelecer a rota inicial ([HomePage])
/// - Configurar opções de debug
///
/// **Tipo**: [StatelessWidget] - não mantém estado mutável porque as
/// configurações são estáticas.
///
/// **Futuras melhorias**:
/// - Adicionar suporte para temas claro/escuro
/// - Implementar internacionalização (i18n)
/// - Configurar rotas nomeadas para navegação
class MyApp extends StatelessWidget {
  /// Cria uma instância de [MyApp].
  ///
  /// O parâmetro [key] é opcional e usado pelo Flutter para otimizar
  /// a reconstrução da árvore de widgets.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título da aplicação (visível no task switcher do Android/iOS)
      title: 'MoneyFlow',

      // Remove o banner "DEBUG" no canto superior direito em modo debug
      debugShowCheckedModeBanner: false,

      // ========================================================================
      // CONFIGURAÇÃO DO TEMA
      // ========================================================================
      theme: ThemeData(
        // Gera um esquema de cores completo a partir de uma cor base.
        // deepPurple é usada como cor primária, e o Flutter gera
        // automaticamente variações para secondary, tertiary, etc.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        // Ativa Material Design 3 (Material You) para componentes modernos
        // e animações melhoradas
        useMaterial3: true,
      ),

      // Define a tela inicial da aplicação
      home: const HomePage(),
    );
  }
}

// ============================================================================
// TELA INICIAL (TEMPORÁRIA)
// ============================================================================

/// Tela inicial temporária da aplicação MoneyFlow.
///
/// Esta é uma tela de boas-vindas simples que será substituída por um
/// sistema de autenticação completo no futuro.
///
/// **Estado atual**:
/// - Exibe o logo da aplicação (ícone de carteira)
/// - Mostra o nome e descrição da aplicação
/// - Usa um layout centralizado e minimalista
///
/// **Roadmap futuro**:
/// 1. Implementar verificação de autenticação
/// 2. Redirecionar para:
///    - Tela de login/registro se não autenticado
///    - Dashboard principal se autenticado
/// 3. Adicionar animações de entrada
/// 4. Implementar splash screen adequado
///
/// **Tipo**: [StatelessWidget] - não precisa de estado por enquanto,
/// mas será convertida para [StatefulWidget] quando adicionar lógica
/// de autenticação.
class HomePage extends StatelessWidget {
  /// Cria uma instância de [HomePage].
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ========================================================================
      // BARRA SUPERIOR (AppBar)
      // ========================================================================
      appBar: AppBar(
        title: const Text('MoneyFlow'),
        // Usa a cor inversa da primária para contraste adequado
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      // ========================================================================
      // CORPO DA PÁGINA
      // ========================================================================
      body: const Center(
        child: Column(
          // Centraliza os elementos verticalmente
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícone principal da aplicação
            Icon(
              Icons.account_balance_wallet,
              size: 100,
              color: Colors.deepPurple,
            ),

            // Espaçamento vertical
            SizedBox(height: 20),

            // Título principal
            Text(
              'MoneyFlow',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            // Espaçamento vertical
            SizedBox(height: 10),

            // Subtítulo/descrição
            Text(
              'Gestão de Despesas Pessoais',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

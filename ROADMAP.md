# 🚀 Roadmap de Desenvolvimento - Penny

> **Companheiro Financeiro Inteligente**  
> Especificação Técnica Completa & Plano de Implementação

---

## 📋 Índice

1. [Resumo Executivo](#resumo-executivo)
2. [Estado Atual](#estado-atual)
3. [Visão Geral da Arquitetura](#visão-geral-da-arquitetura)
4. [Roadmap de Desenvolvimento](#roadmap-de-desenvolvimento)
5. [Especificações Detalhadas](#especificações-detalhadas)
6. [Requisitos Técnicos](#requisitos-técnicos)
7. [Estratégia de Testes](#estratégia-de-testes)
8. [Plano de Deployment](#plano-de-deployment)
9. [Estimativas de Tempo](#estimativas-de-tempo)

---

## 1. Resumo Executivo

**Penny** é uma aplicação moderna de gestão financeira construída com Flutter, desenhada para ajudar os utilizadores a tomar controlo das suas finanças pessoais através de tracking intuitivo, orçamentação e insights. A app segue os princípios de **Clean Architecture** com padrões de design **SOLID**, garantindo escalabilidade, manutenibilidade e testabilidade.

### 🏆 Conquistas Principais

- ✅ Domain Layer completa com 7 use cases implementados
- ✅ Data Layer completa com padrão Repository e integração Firebase
- ✅ Backend da Presentation Layer (7 providers Riverpod + AuthController)
- ✅ Splash Screen profissional com animações coordenadas
- ✅ Logo minimalista de moeda dourada desenhado com IA
- ✅ Documento de Design de 29 páginas com especificação completa do MVP
- ✅ Implementação Clean Architecture seguindo princípios SOLID

### 📍 Próximo Marco

Completar UI de Autenticação e Funcionalidades Core de Transações

---

## 2. Estado Atual

### Progresso Geral: **25-30% Completo**

| Componente | Estado | Progresso |
|-----------|--------|-----------|
| Domain Layer | ✅ Completa | 100% |
| Data Layer | ✅ Completa | 100% |
| Presentation - Backend | ✅ Completa | 100% |
| Presentation - UI | 🚧 Em Progresso | 5% |
| Ecrãs de Autenticação | 🚀 Por Iniciar | 0% |
| Dashboard | 🚀 Por Iniciar | 0% |
| Transações | 🚀 Por Iniciar | 0% |
| Categorias | 🚀 Por Iniciar | 0% |
| Gráficos & Análises | 🚀 Por Iniciar | 0% |
| Sistema de Orçamentos | 🚀 Por Iniciar | 0% |
| Dark Mode | 🚀 Por Iniciar | 0% |
| Testes | 🚀 Por Iniciar | 0% |

---

## 3. Visão Geral da Arquitetura

### 3.1 Camadas Clean Architecture

O projeto segue a Clean Architecture do Uncle Bob, organizada em três camadas distintas com dependências claras a fluir para dentro.

| Camada | Componentes | Estado | Progresso |
|--------|------------|--------|-----------|
| **1. Domain** (Lógica de Negócio) | • Entities (User, Transaction) • Use Cases (7 implementados) • Repository Interfaces | ✅ Completa | 100% |
| **2. Data** (Gestão de Dados) | • Models (UserModel, etc.) • Repository Implementations • Remote Data Source | ✅ Completa | 100% |
| **3. Presentation** (UI & Estado) | • Providers (7 Riverpod) • Controllers (AsyncNotifier) • Screens & Widgets | 🚧 Em Progresso | 50% |

### 3.2 Stack Tecnológico

| Categoria | Tecnologia | Versão |
|-----------|-----------|--------|
| Framework | Flutter | 3.x |
| Linguagem | Dart | 3.x |
| State Management | Riverpod | 2.6.1 |
| Backend | Firebase Auth | Latest |
| Base de Dados | Cloud Firestore | Latest |
| Code Generation | Build Runner | Latest |
| Arquitetura | Clean Architecture | — |
| Princípios | SOLID | — |

---

## 4. Roadmap de Desenvolvimento

### 4.1 Sprint 1: Autenticação & Navegação (1-2 semanas)

**Objetivo:** Completar o fluxo de autenticação de utilizadores e estabelecer a estrutura de navegação da app.

#### Tarefas

- [ ] **Ecrã de Login**
  - Campos email/password
  - Validação de inputs
  - Tratamento de erros
  - Estados de loading

- [ ] **Ecrã de Registo**
  - Formulário de registo completo
  - Confirmação de password
  - Verificação de email
  - Validação de força de password

- [ ] **Lógica Splash Screen**
  - Deteção de estado de autenticação
  - Navegação automática

- [ ] **Setup de Navegação**
  - GoRouter ou Navigator 2.0
  - Rotas protegidas
  - Deep linking

- [ ] **Shell do Dashboard**
  - Layout básico
  - Navegação inferior
  - Conteúdo placeholder

- [ ] **Ecrã de Perfil**
  - Ver perfil
  - Funcionalidade logout
  - Acesso a definições

**Entregáveis:** Fluxo de autenticação totalmente funcional, estrutura de navegação da app  
**Tempo Estimado:** 7-14 dias (part-time)

---

### 4.2 Sprint 2: Funcionalidades Core de Transações (2-3 semanas)

**Objetivo:** Implementar a funcionalidade core da app - gestão de transações e categorias.

#### Tarefas

- [ ] **Ecrã Adicionar Transação**
  - Toggle rendimento/despesa
  - Input de valor
  - Picker de categoria
  - Seletor de data
  - Campo de descrição

- [ ] **Lista de Transações**
  - Lista scrollable com agrupamento por data
  - Pesquisa e filtros
  - Ações de swipe (editar/apagar)
  - Pull to refresh
  - Estado vazio

- [ ] **Detalhes da Transação**
  - Ver/editar transações individuais
  - Funcionalidade apagar
  - Histórico de alterações

- [ ] **Sistema de Categorias**
  - Categorias predefinidas
  - CRUD de categorias personalizadas
  - Ícones & cores personalizáveis

- [ ] **Integração Firestore**
  - Estrutura de coleções
  - Operações CRUD
  - Sync em tempo real

- [ ] **Armazenamento Local**
  - Hive/SharedPreferences
  - Capacidade offline

- [ ] **Conteúdo Dashboard**
  - Saldo total
  - Transações recentes
  - Estatísticas rápidas

**Entregáveis:** Gestão completa de transações com categorias e persistência de dados  
**Tempo Estimado:** 14-21 dias (part-time)

---

### 4.3 Sprint 3: Polimento & Funcionalidades Avançadas (2-3 semanas)

**Objetivo:** Adicionar polimento visual, visualização de dados e funcionalidades avançadas.

#### Tarefas

- [ ] **Dark Mode**
  - ThemeData light/dark
  - Theme provider
  - Persistência de preferência
  - Toggle nas definições

- [ ] **Gráficos & Análises**
  - Gráfico circular (despesas por categoria)
  - Gráfico de linhas (tendências)
  - Gráfico de barras (mensal)

- [ ] **Sistema de Orçamentos**
  - Definir limites de orçamento
  - Indicadores de progresso
  - Alertas de overspending
  - Reset mensal automático

- [ ] **Ecrã de Definições**
  - Seleção de moeda
  - Idioma (PT/EN)
  - Preferências da app

- [ ] **Gestão de Perfil**
  - Editar perfil
  - Mudar password
  - Apagar conta

- [ ] **Tratamento de Erros**
  - Tratamento global de erros
  - Mensagens user-friendly
  - Mecanismos de retry

- [ ] **Otimização de Performance**
  - Virtualização de listas
  - Caching de imagens
  - Otimização de queries

- [ ] **Suite de Testes**
  - Testes unitários (Domain Layer)
  - Testes de widgets (UI)
  - Testes de integração

**Entregáveis:** MVP polido e feature-complete pronto para testes beta  
**Tempo Estimado:** 14-21 dias (part-time)

---

## 5. Especificações Detalhadas

### 5.1 Ecrãs de Autenticação

#### Requisitos do Ecrã de Login

- [ ] TextField de Email com validação
- [ ] TextField de Password com toggle obscureText
- [ ] Checkbox "Lembrar-me"
- [ ] Link "Esqueceu a password?"
- [ ] Botão "Entrar" com estado de loading
- [ ] Link "Não tem conta? Registar"
- [ ] Tratamento de erros com mensagens user-friendly
- [ ] Auto-focus no campo de email
- [ ] Validação de formulário antes de API call

#### Requisitos do Ecrã de Registo

- [ ] TextField de Nome Completo
- [ ] TextField de Email com validação
- [ ] TextField de Password com indicador de força
- [ ] TextField de Confirmar Password com validação
- [ ] Checkbox de Termos & Condições
- [ ] Botão "Criar Conta" com estado de loading
- [ ] Link "Já tem conta? Entrar"
- [ ] Display de requisitos de password
- [ ] Mensagem de sucesso e navegação automática

---

### 5.2 Dashboard & Navegação

#### Layout do Dashboard

```
┌─────────────────────────┐
│ Header (User + Avatar)  │
├─────────────────────────┤
│   Total Balance Card    │
├─────────────────────────┤
│  Quick Stats (3 cols)   │
├─────────────────────────┤
│ Recent Transactions     │
├─────────────────────────┤
│ Quick Actions (Buttons) │
└─────────────────────────┘
```

#### Barra de Navegação Inferior

- Início (Dashboard)
- Transações
- **+ Adicionar** (Centrado, elevado)
- Orçamento
- Perfil

---

### 5.3 Gestão de Transações

#### Estrutura Firestore

```
users/{userId}/transactions/{transactionId}
├── amount: double
├── type: string ("income" | "expense")
├── categoryId: string
├── description: string
├── date: timestamp
├── createdAt: timestamp
└── updatedAt: timestamp
```

#### Funcionalidades

- [ ] Adicionar rendimento/despesa
- [ ] Editar transação existente
- [ ] Apagar transação
- [ ] Listar com agrupamento por data
- [ ] Pesquisa e filtros (data, categoria, tipo)
- [ ] Ordenação (data, valor)
- [ ] Ações de swipe

---

### 5.4 Sistema de Categorias

#### Categorias Predefinidas

**Despesas:** Alimentação & Refeições, Transportes, Compras, Entretenimento, Contas & Utilidades, Saúde, Educação, Viagens, Outros

**Rendimentos:** Salário, Freelance, Negócio, Investimentos, Prendas, Outros

#### Estrutura Firestore

```
users/{userId}/categories/{categoryId}
├── name: string
├── icon: string
├── color: string
├── type: string ("income" | "expense")
├── isDefault: boolean
└── createdAt: timestamp
```

---

### 5.5 Gestão de Orçamentos

- [ ] Definir limite de orçamento mensal
- [ ] Suporte por categoria
- [ ] Barras de progresso visual
- [ ] Indicadores de cor (Verde/Amarelo/Vermelho)
- [ ] Alertas de overspending
- [ ] Reset mensal automático
- [ ] Histórico de meses passados

---

### 5.6 Gráficos & Análises

#### Tipos de Gráfico

1. **Gráfico Circular** - Despesas por Categoria
   - Breakdown percentual
   - Interativo (tocar para detalhes)
   - Legenda com valores

2. **Gráfico de Linhas** - Tendências ao Longo do Tempo
   - Vistas Diária, Semanal, Mensal
   - Rendimentos vs Despesas
   - Tooltips nos pontos

3. **Gráfico de Barras** - Comparação Mensal
   - Mês atual vs histórico
   - Barras agrupadas
   - Scrollable

#### Package Recomendado

```dart
dependencies:
  fl_chart: ^0.68.0
```

#### Funcionalidades de Análises

- Rendimento total (mês, ano, todo o tempo)
- Despesas totais (mês, ano, todo o tempo)
- Taxa de poupança líquida
- Top categorias de gastos
- Padrões de gastos
- Exportar dados (CSV/PDF)

---

## 6. Requisitos Técnicos

### 6.1 Requisitos de Performance

- ⚡ Tempo de arranque: < 2 segundos (dispositivos mid-range)
- 🎬 Transições: 60 FPS animações suaves
- 📜 Scroll de listas: 60 FPS com 1000+ transações
- 🔌 API Firestore: < 500ms maioria operações
- 🖼️ Imagens: Carregamento progressivo com placeholders
- 💾 Memória: < 150MB em média

### 6.2 Requisitos de Dados

- 📱 Arquitetura offline-first (armazenamento local + sync Firestore)
- 🔐 Encriptação de dados (em repouso e em trânsito)
- 💾 Backup automático para Firebase
- 📊 Exportação de dados (CSV, PDF)
- ⚖️ Conformidade RGPD (eliminação, exportação)

### 6.3 Requisitos de Segurança

- 🔑 Firebase Authentication (email/password)
- 🛡️ Armazenamento seguro para dados sensíveis
- ✅ Validação de input em todos formulários
- 🚫 Prevenção XSS e injection
- 🔒 Apenas HTTPS para API calls
- 🔳 Autenticação biométrica (futuro)

### 6.4 Requisitos de Acessibilidade

- 📢 Suporte para screen reader (Semantics)
- 👆 Tamanho mínimo touch target: 48x48 dp
- 🎨 Contraste de cor suficiente (WCAG AA)
- 📏 Suporte para escala de fonte do sistema
- ⌨️ Navegação por teclado

---

## 7. Estratégia de Testes

### Pirâmide de Testes

```
        △
       / \      Integration Tests
      /   \     (Fluxos Chave)
     /-----\
    /       \   Widget Tests
   /         \  (UI Components)
  /-----------\
 /             \ Unit Tests
/----- --------- (Domain, Logic)
```

### Metas de Cobertura

| Tipo | Meta | Prioridade |
|------|------|-----------|
| Testes Unitários | 80%+ | 🔴 Crítica |
| Testes de Widgets | 60%+ | 🟠 Alta |
| Testes de Integração | Fluxos Chave | 🟠 Alta |
| Golden Tests | Ecrãs Principais | 🟡 Média |

### Escopo

- **Unitários:** Use cases, validação, lógica de negócio
- **Widgets:** Componentes UI, interações, validação de formulários
- **Integração:** Autenticação, CRUD, navegação
- **Golden:** Regressão visual de ecrãs principais
- **Manuais:** Casos limite, fluxos reais, dispositivos físicos

---

## 8. Plano de Deployment

### 8.1 Fase de Testes Beta (Após Sprint 3)

- [ ] Testes internos com 5-10 utilizadores
- [ ] Firebase App Distribution para builds beta
- [ ] Recolher feedback e relatórios de bugs
- [ ] Corrigir issues críticas
- **Duração:** 1-2 semanas

### 8.2 Requisitos das App Stores

- [ ] Ícone da App (1024x1024 PNG)
- [ ] Screenshots (5-10 por plataforma)
- [ ] Descrição (Português + Inglês)
- [ ] Política de Privacidade hospedada
- [ ] Termos de Serviço
- [ ] Otimização de listagem (ASO)

### 8.3 Estratégia de Release

1. **Fase 1:** Android (Google Play - aprovação mais fácil)
2. **Fase 2:** iOS (App Store - review rigoroso)
3. **Release Inicial:** Mercado português
4. **Rollout Gradual:** 10% → 50% → 100%
5. **Monitorização:** Crash rates e feedback

### 8.4 Pós-Lançamento

- [ ] Monitorizar Firebase Analytics e Crashlytics
- [ ] Responder a reviews em 24h
- [ ] Releases semanais de correção (se necessário)
- [ ] Updates mensais de funcionalidades

---

## 9. Estimativas de Tempo

### 9.1 Timeline de Conclusão do MVP

| Modo de Trabalho | Horas/Dia | Total Horas | Tempo Calendário |
|------------------|-----------|------------|-----------------|
| Full-Time | 8 horas | 240-320 | 4-6 semanas |
| Part-Time | 4 horas | 240-320 | 8-12 semanas |
| Casual | 2 horas | 240-320 | 16-20 semanas |

### 9.2 Estimativas Feature por Feature

| Funcionalidade | Complexidade | Horas |
|----------------|-------------|-------|
| Ecrãs Login/Registo | Baixa | 12-16h |
| Setup de Navegação | Média | 8-12h |
| Layout Dashboard | Média | 16-20h |
| Adicionar Transação | Média | 12-16h |
| Lista de Transações | Alta | 20-24h |
| Sistema de Categorias | Média | 16-20h |
| Integração Firestore | Alta | 24-32h |
| Dark Mode | Baixa | 8-12h |
| Gráficos (3 tipos) | Alta | 24-32h |
| Sistema de Orçamentos | Alta | 24-32h |
| Perfil/Definições | Baixa | 12-16h |
| Suite de Testes | Alta | 32-40h |
| Correções & Polimento | — | 24-32h |
| **TOTAL** | — | **240-320h** |

---

## 10. Guias de Design

### 10.1 Paleta de Cores

| Nome | Hex | Utilização |
|------|-----|-----------|
| Indigo Primário | #6366F1 | Botões primários, headers, estados ativos |
| Roxo Secundário | #8B5CF6 | Botões secundários, acentos, gradientes |
| Dourado | #FFD700 | Logo, destaques, sucesso |
| Dourado Claro | #FFE082 | Destaques de texto, acentos |
| Fundo Claro | #FFFFFF | Fundo modo claro |
| Fundo Escuro | #1F2937 | Fundo modo escuro |
| Texto Primário | #111827 | Texto principal |
| Texto Secundário | #6B7280 | Texto secundário, hints |
| Vermelho Erro | #EF4444 | Erros, ações destrutivas |
| Verde Sucesso | #10B981 | Sucesso, rendimentos |

### 10.2 Tipografia

**Família:** San Francisco (iOS) / Roboto (Android)

| Estilo | Tamanho | Peso | Cor |
|--------|--------|------|-----|
| H1 (Título) | 32pt | Bold | Primária |
| H2 (Cabeçalho) | 24pt | Bold | Primária |
| H3 (Card) | 18pt | SemiBold | Texto Primário |
| Body | 16pt | Regular | Texto Primário |
| Caption | 14pt | Regular | Texto Secundário |
| Button | 16pt | SemiBold | Maiúsculas |

### 10.3 Componentes

#### Botões
- Altura mínima: 48dp
- Border radius: 12dp
- Padding: 16dp horizontal, 12dp vertical

#### Cards
- Border radius: 16dp
- Elevation: 2dp (sombra subtil)
- Padding: 16dp
- Margem entre: 16dp

#### Campos de Input
- Border radius: 12dp
- Altura: 56dp
- Label flutuante
- Estado erro: borda vermelha

#### Listas
- Altura de item: 72dp mínimo
- Divisores: 1dp cinzento
- Ações swipe: esquerda/direita

---

## 📌 Próximos Passos Imediatos

1. ✅ Rever e aprovar este roadmap
2. ⏳ Configurar ambiente de desenvolvimento
3. ⏳ Começar Sprint 1: Login Screen
4. ⏳ Estabelecer procedimentos de testes
5. ⏳ Configurar CI/CD (opcional)

---

## 📝 Notas

Este é um **documento vivo**. À medida que o desenvolvimento progride, as estimativas e especificações serão atualizadas baseadas na experiência real e feedback dos utilizadores.

**Documento preparado para:** Equipa de Desenvolvimento Penny  
**Última atualização:** 14 de Fevereiro de 2026  
**Versão:** 2.0

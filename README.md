<div align="center">
  
  # 🦊 Centi
  
  ### The AI-Powered Finance Tracker

  
  ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
  ![Riverpod](https://img.shields.io/badge/Riverpod-3DDC84?style=for-the-badge)
  ![Clean Architecture](https://img.shields.io/badge/Clean%20Architecture-6C47FF?style=for-the-badge)
  
  **Status:** 🚧 In Development
  
  [Features](#-features) • [Tech Stack](#-tech-stack) • [Architecture](#-architecture) • [Progress](#-current-progress) • [Getting Started](#-getting-started)
  
</div>

---

## 🎯 About

**Centi** is a comprehensive personal finance management application built with Flutter following **Clean Architecture** principles. This project demonstrates professional-grade code structure, SOLID principles, and modern Flutter development practices.

### ✨ Key Highlights

- 🏗️ **Clean Architecture** - Separation of concerns with Domain, Data, and Presentation layers
- 📊 **Beautiful Visualizations** - Interactive charts and graphs to understand spending patterns
- 💰 **Budget Management** - Set and track budgets per category
- 🔥 **Firebase Integration** - Cloud sync, authentication, and real-time updates
- 📱 **Cross-Platform** - Works on Android, iOS, and Web
- 🔒 **Secure** - Firebase Authentication with email/password
- ☁️ **Cloud Sync** - Data synced across all devices
- 🎨 **Material Design 3** - Modern and intuitive UI

---

## 🚀 Features

### ✅ Completed
- [x] **Project Setup**
  - Clean Architecture structure (Domain/Data/Presentation)
  - Firebase integration (Auth, Firestore)
  - Git workflow with professional commits
- [x] **Domain Layer (Auth Feature)**
  - User Entity with validation and immutability
  - AuthRepository Interface (login, register, logout, getCurrentUser)
  - 4 Use Cases: LoginUser, RegisterUser, LogoutUser, GetCurrentUser
  - Dependency Injection pattern
- [x] **Data Layer (Auth Feature - In Progress)**
  - UserModel with JSON and Firebase conversion
  - fromFirebase, fromJson, toJson methods

- [x] **Data Layer (Auth Feature)**
  - [x] AuthRemoteDataSource (Firebase calls)
  - [x] AuthRepositoryImpl (Repository implementation)
- [x] **Presentation Layer (Auth Feature)**
  - [x] Splash Screen (Animated)
  - [x] Login Screen (UI + Logic)
  - [x] Register Screen (UI implementation)
  - [x] State management with Riverpod
- [x] **Core**
  - [x] App Theme (Indigo + Gold palette)
  - [x] GoRouter (Centralized navigation)
- [x] **Dashboard (UI completo — dados placeholder)**
  - [x] BalanceCard widget (estilo fintech — efeito vidro, setas néon)
  - [x] TransactionItem widget (ícones, cores receita/despesa)
  - [x] Transactions list (placeholder data)
  - [x] Header com gradiente indigo/roxo
  - [x] SingleChildScrollView (sem overflow)
  - [x] Pacote `intl` instalado (datas em português)

### 🚧 In Progress
- [x] **Transactions Feature (Domain Layer)** ✅
  - [x] Transaction entity (id, amount, type, category, date, userId)
  - [x] TransactionRepository interface
  - [x] Use Cases: AddTransaction, GetTransactions, DeleteTransaction
- [ ] **Transactions Feature (Data Layer)**
  - [ ] TransactionModel (fromFirestore, toFirestore)
  - [ ] TransactionRemoteDataSource (Firestore calls)
  - [ ] TransactionRepositoryImpl
- [ ] **Dashboard — Pendente após Transactions**
  - [ ] Data dinâmica + nome real do utilizador
  - [ ] Drawer lateral moderno (perfil, definições, MVP Portugal)
  - [ ] Speed Dial FAB (↑ Receita / ↓ Despesa)
  - [ ] Dados reais do Firestore

### 🔮 Planned (MVP Portugal)

**🏆 Differentiators (Why users switch)**
- [ ] **🇵🇹 IRS Refund Gamification** - Live progress bar for tax benefits (15% VAT)
- [ ] **💳 MB WAY Smart Decoder** - Aliases for phone numbers (e.g. 9123... -> "Landlord")
- [ ] **🍽️ Meal Card Tracker** - Separated balance with "Quick Lunch" button
- [ ] **📈 Savings Certificates** - Auto-calculation for Series E/F interest

**🛡️ Essentials (Trust & Security)**
- [ ] **🔒 Privacy First** - Local-only database (SQLite/Isar) option
- [ ] **🏦 Open Banking** - Connect to PT Banks (CGD, BCP, Activo) via GoCardless
- [ ] **🔐 Biometric Security** - FaceID / TouchID
- [ ] **💶 Multi-Currency** - Auto-convert GBP/CHF/PLN to EUR

**⚓ Retention (Daily Use)**
- [ ] **📅 Subscription Detector** - Alerts for tomorrow's Netflix/Spotify charge
- [ ] **🚦 Traffic Light Budgets** - Visual limits (Green/Yellow/Red)
- [ ] **📊 Smart Analytics** - Spending by category & evolution charts

### 🔐 Security & Compliance (EU/GDPR)
- **Database Encryption**: AES-256 via Isar/Hive + `flutter_secure_storage` for keys.
- **SSL Pinning**: Prevent Man-in-the-Middle attacks for API calls.
- **Biometric Enforcement**: Mandatory FaceID/TouchID via `local_auth`.
- **Legal**: In-app Privacy Policy & "Not Financial Advice" Terms.

---

## 🛠️ Tech Stack

### Core
- **Framework:** Flutter 3.x
- **Language:** Dart 3.x
- **State Management:** Riverpod 3.x
- **Navigation:** GoRouter 17.x
- **Architecture:** Clean Architecture

### Backend & Database
- **Authentication:** Firebase Auth
- **Cloud Database:** Cloud Firestore
- **Storage:** Firebase Storage (planned)
- **Local Cache:** Hive (planned)

### Development Practices
- **Version Control:** Git & GitHub
- **Code Style:** Dart conventions
- **Architecture Patterns:** Repository Pattern, Dependency Injection, Use Cases
- **Principles:** SOLID, DRY, Clean Code

### UI Polish Packages (Phase 3 — após funcionalidade completa)
> Regra: Funcionalidade → Dados reais → Polimento UI

| Package | Uso no Centi | Prioridade |
|---|---|---|
| `salomon_bottom_bar` | Bottom navigation animada (estilo fintech) | ⭐ Alta |
| `loading_animation_widget` | Substituir `CircularProgressIndicator` no login/register | ⭐ Alta |
| `awesome_snackbar_content` | SnackBars animados de sucesso/erro | 🔶 Média |
| `top_snackbar_flutter` | ❌ Duplica `awesome_snackbar_content` — não usar | — |
| `animated_bottom_navigation_bar` | ❌ `salomon_bottom_bar` é melhor para fintech | — |
| `card_swiper` | Onboarding swipe — não está no roadmap atual | 🔷 Baixa |
| `avatar_glow` | Glow animado em avatares/ícones | 🔷 Baixa |

---

## 🏗️ Architecture

This project follows **Clean Architecture** principles with strict separation of concerns:
```
lib/
├── core/                       # Shared code
│   ├── constants/             # App constants
│   ├── theme/                 # ✅ App Theme & Colors
│   ├── utils/                 # Utility functions
│   └── errors/                # Custom errors
│
└── features/
    ├── auth/                   # Authentication feature
    │   │
    │   ├── domain/             # ✅ COMPLETE - Business Logic Layer
    │   │   ├── entities/
    │   │   │   └── user.dart                    # User entity with validation
    │   │   ├── repositories/
    │   │   │   └── auth_repository.dart         # Repository interface
    │   │   └── usecases/
    │   │       ├── login_user.dart              # Login use case
    │   │       ├── register_user.dart           # Register use case
    │   │       ├── logout_user.dart             # Logout use case
    │   │       └── get_current_user.dart        # Get current user use case
    │   │
    │   ├── data/               # ✅ COMPLETE - Data Layer
    │   │   ├── models/
    │   │   │   └── user_model.dart              # User model with conversions
    │   │   ├── datasources/
    │   │   │   └── auth_remote_datasource.dart  # Firebase calls
    │   │   └── repositories/
    │   │       └── auth_repository_impl.dart    # Repository implementation
    │   │
    │   └── presentation/       # 🚧 IN PROGRESS - UI Layer
    │       ├── controllers/    # Riverpod Notifiers (AuthController)
    │       ├── providers/      # Dependency Injection
    │       └── screens/        # Login, Register, Splash
    │
    └── dashboard/              # 🚧 IN PROGRESS - Dashboard Feature
        └── presentation/
            ├── screens/        # DashboardScreen
            └── widgets/        # BalanceCard, TransactionItem
```

### Architecture Benefits

✅ **Testability** - Each layer can be tested independently  
✅ **Maintainability** - Clear structure, easy to navigate  
✅ **Scalability** - Easy to add new features  
✅ **Flexibility** - Can change implementations without affecting other layers  
✅ **Independence** - Domain layer has zero dependencies on external frameworks  

### Layer Responsibilities

**🎯 Domain Layer (Business Logic)**
- Defines what the app does
- Contains entities (business objects)
- Defines repository contracts
- Implements use cases (business rules)
- Framework-independent (pure Dart)

**💾 Data Layer (Data Management)**
- Implements repository contracts
- Handles data sources (Firebase, APIs, local DB)
- Converts between models and entities
- Manages caching and synchronization

**🎨 Presentation Layer (User Interface)**
- Displays data to users
- Handles user interactions
- Manages UI state with Riverpod
- Calls use cases, never repositories directly

---

## 📊 Current Progress

### Domain Layer - Auth Feature ✅ 100%

**User Entity**
- Immutable data class with id, email, displayName
- Constructor validation (empty checks, email format)
- copyWith method for updates
- Proper equals and hashCode

**Repository Interface**
- login(email, password) → Future<User>
- register(email, password, displayName?) → Future<User>
- logout() → Future<void>
- getCurrentUser() → Future<User?>

**Use Cases**
- LoginUser - Handles user login
- RegisterUser - Handles user registration  
- LogoutUser - Handles logout
- GetCurrentUser - Gets currently logged in user
- All use cases implement Dependency Injection

**Concepts Applied**
- Clean Architecture principles
- SOLID principles
- Repository Pattern
- Dependency Injection
- Use Case Pattern
- Future/async/await
- Immutability

### Data Layer - Auth Feature ✅ 100%

**UserModel**
- Extends User entity
- fromFirebase(firebase_auth.User) - Converts Firebase user
- fromJson(Map) - Converts from JSON
- toJson() - Converts to JSON
- Factory constructors for conversions

**Repositories & DataSources**
- AuthRemoteDataSource - Implemented with Firebase Auth
- AuthRepositoryImpl - Connects Domain to Data layers

### Presentation Layer - Auth Feature ✅ 100%

**Screens**
- Splash Screen: Animated with auth check, Timer dispose ✅
- Login Screen: UI, Validation, GoRouter, mounted guard ✅
- Register Screen: UI, Validation, GoRouter, mounted guard ✅

**State Management**
- AuthController (AsyncNotifierProvider) handles all logic
- Global Error Handling via SnackBars
- GoRouter centralized navigation

### Domain Layer - Transactions Feature ✅ 100%

**Transaction Entity**
- `TransactionType` enum (income / expense)
- Immutable data class com 7 campos
- Validações: id, userId, amount > 0, category
- `copyWith` para atualizações imutáveis

**Repository Interface**
- `addTransaction(Transaction)` → Future<void>
- `getTransactions(userId)` → Stream<List<Transaction>>
- `deleteTransaction(transactionId)` → Future<void>

**Use Cases**
- `AddTransaction` — guarda transação via repository
- `GetTransactions` — Stream em tempo real por userId
- `DeleteTransaction` — apaga pelo id

### Presentation Layer - Dashboard Feature 🚧 70%

**Widgets**
- BalanceCard: efeito vidro, gradiente, setas néon, formato europeu ✅
- TransactionItem: ícone circular, cor por tipo ✅

**Screens**
- DashboardScreen: header gradiente + scroll + lista placeholder ✅
- Data dinâmica + nome utilizador 🚧
- Drawer lateral + Speed Dial FAB 🚧 (aguarda Transactions)

---

## 🗺️ Roadmap

### Phase 1 - Foundation (Week 1-2) ✅ 100%
- [x] Project setup with Clean Architecture
- [x] Firebase configuration and integration
- [x] Domain Layer complete (Entity, Repository, Use Cases)
- [x] UserModel with conversions
- [x] DataSource and Repository implementation
- [x] Authentication screens (Login/Register/Splash)
- [x] GoRouter centralized navigation

### Phase 2 - Core Features (Week 3-4) 🚧 60%
- [x] Dashboard base with BalanceCard and TransactionItem
- [x] Dashboard redesign moderno (gradiente + scroll + fintech style)
- [x] **Transactions Domain Layer** (entity + repository + use cases)
- [ ] **Transactions Data Layer** (Firestore + model)
- [ ] **Transactions Presentation** (Speed Dial + formulário + providers)
- [ ] Dashboard com dados reais + Drawer + Perfil
- [ ] Category system
- [ ] Basic statistics

### Phase 3 - Advanced Features (Week 5-6)
- [ ] Budget tracking and alerts
- [ ] Charts and visualizations
- [ ] Data export (PDF, CSV)
- [ ] Dark mode

### Phase 4 - Polish & Deploy (Week 7-8)
- [ ] Animations and UI polish
- [ ] Testing (Unit, Widget, Integration)
- [ ] Performance optimization
- [ ] Deploy to Google Play / App Store

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>= 3.0.0)
- Dart SDK (>= 3.0.0)
- Firebase project configured
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/CLopes86/centi.git
cd centi
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Configure Firebase**
   - Create a Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Enable Email/Password authentication
   - Create Firestore database
   - Download and add `google-services.json` (Android) to `android/app/`
   - Download and add `GoogleService-Info.plist` (iOS) to `ios/Runner/`

4. **Run the app**
```bash
flutter run
```

---

## 📚 Learning Journey

This project showcases professional Flutter development practices:

### Concepts Mastered ✅
- **Clean Architecture** - Three-layer separation (Domain/Data/Presentation)
- **SOLID Principles** - Single Responsibility, Dependency Inversion, etc.
- **Repository Pattern** - Abstract data sources behind interfaces
- **Use Cases** - Isolated business logic
- **Dependency Injection** - Loose coupling between layers
- **Factory Constructors** - Object creation patterns
- **async/await** - Asynchronous programming
- **Future & Stream** - Reactive programming concepts

### Currently Learning 🚧
- **Riverpod** - Modern state management
- **Firebase Integration** - Auth, Firestore, Storage
- **Testing** - Unit tests, widget tests
- **Error Handling** - Either type, custom exceptions

### Next Steps 🔮
- **Advanced UI** - Animations, custom painters
- **ML Kit** - OCR for receipt scanning
- **Performance** - Optimization techniques
- **CI/CD** - Automated testing and deployment

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

<div align="center">
  <img src="https://github.com/CLopes86.png" width="150" style="border-radius: 50%; border: 3px solid #0366d6;" alt="Cesaltino Lopes"/>
  
  ### **Cesaltino Lopes**
  
  🎓 3rd Year - Informatica & Multimedia @ IPCB  
  💻 Mobile Developer | Flutter Enthusiast  
  🚒 Volunteer Firefighter since 2023  
  🚀 Building professional-grade applications
  
  [![GitHub](https://img.shields.io/badge/GitHub-CLopes86-181717?style=for-the-badge&logo=github)](https://github.com/CLopes86)
  [![LinkedIn](https://img.shields.io/badge/LinkedIn-Cesaltino%20Lopes-0077B5?style=for-the-badge&logo=linkedin)](https://linkedin.com/in/cesaltino-lopes-55274b176)
  [![Email](https://img.shields.io/badge/Email-clopes86cv-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:clopes86cv@gmail.com)
  
  📍 Portugal | 🌐 Open to opportunities
  
</div>

---

<div align="center">

### 💡 "Building the future, one line of code at a time"

**Made with 💙, Flutter, and Clean Architecture**

⭐ **Star this repo if you find it useful!**

---

### 📈 Project Stats

![Commits](https://img.shields.io/github/commit-activity/m/CLopes86/money-flow?style=flat-square)
![Last Commit](https://img.shields.io/github/last-commit/CLopes86/money-flow?style=flat-square)
![Code Size](https://img.shields.io/github/languages/code-size/CLopes86/money-flow?style=flat-square)

</div>

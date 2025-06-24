# Woodiex - Furniture E-Commerce App

A modern Flutter-based furniture e-commerce application built with clean architecture principles, featuring user authentication, product catalog, shopping cart, order management, and more.

## 📱 Screenshots

<div align="center">
  <img src="https://github.com/user-attachments/assets/4e442118-64bc-463d-b7dd-5b913243cbde" width="200" alt="Onboarding"/>
  <img src="https://github.com/user-attachments/assets/dd933c8b-794d-4402-bba1-754908870a69" width="200" alt="Login"/>
  <img src="https://github.com/user-attachments/assets/6c6cb443-6b10-42fa-bb76-e7b8ccb62ece" width="200" alt="Home"/>
  <img src="https://github.com/user-attachments/assets/44eb6696-592a-41cd-b08e-0d19dfccab71" width="200" alt="Product Details"/>
</div>

<div align="center">
  <img src="https://github.com/user-attachments/assets/dfd54d54-7ae7-410e-8ea7-5fc8569127b2" width="200" alt="Cart"/>
  <img src="https://github.com/user-attachments/assets/d1c8b491-17d3-40c0-a607-efd23df71296" width="200" alt="Checkout"/>
  <img src="https://github.com/user-attachments/assets/e91fa303-c24c-454d-be17-7ccc06bfa4ab" width="200" alt="Profile"/>
  <img src="https://github.com/user-attachments/assets/b9c3cbfe-3f71-41a3-aa7f-371d78a7c43d" width="200" alt="Orders"/>
</div>

<div align="center">
  <img src="https://github.com/user-attachments/assets/09945ed8-7706-41eb-afb9-687ba26bc62d" width="200" alt="Reviews"/>
  <img src="https://github.com/user-attachments/assets/09d9d0c0-2c7e-419d-b6e7-6e252ec9ec3d" width="200" alt="Shipping Address"/>
  <img src="https://github.com/user-attachments/assets/b39f7fcc-c1a2-40ac-8036-fa3b45191369" width="200" alt="Notifications"/>
  <img src="https://github.com/user-attachments/assets/5fc65c68-3a80-4847-86d0-c4f86c19494b" width="200" alt="Settings"/>
</div>

<div align="center">
  <img src="https://github.com/user-attachments/assets/51a601dd-987b-4110-9f5b-4142c69c9a15" width="200" alt="Wishlist"/>
  <img src="https://github.com/user-attachments/assets/d65091bd-b51e-410f-a929-b62e44fec74f" width="200" alt="Payment"/>
  <img src="https://git![Boarding (1)](https://github.com/user-attachments/assets/468b5a96-2e86-4b04-89d2-625c674cd935)
<img width="375" alt="Sign up" src="https://github.com/user-attachments/assets/8c8a1c92-687e-454f-b09a-57765a31c1c3" />
<img width="375" alt="Log in (1)" src="https://github.com/user-attachments/assets/532cb018-6b4f-4ff9-a198-bb229ea63f1e" />
hub.com/user-attachments/assets/47fc28d7-9ee9-426a-8ad9-b9bcf898ad2e" width="200" alt="Success"/>
</div>

## 🚀 Features

- **Authentication**: User login and registration with secure token management
- **Product Catalog**: Browse furniture with filtering and search capabilities
- **Product Details**: Detailed product views with images, descriptions, and reviews
- **Shopping Cart**: Add/remove items with quantity management
- **Checkout Process**: Seamless order placement with address selection
- **Order Management**: Track order history and status
- **User Profile**: Manage personal information and profile picture
- **Reviews & Ratings**: Add and view product reviews
- **Shipping Address**: Manage multiple delivery addresses
- **Wishlist**: Save favorite products for later
- **Notifications**: Stay updated with order and app notifications
- **Multi-flavor Support**: Development and production environments

## 🏗️ Architecture

The app follows **Clean Architecture** principles with a feature-based modular structure:
![Editor _ Mermaid Chart-2025-06-24-161323](https://github.com/user-attachments/assets/435f81c0-d4b3-4d89-870f-4de4b8b70713)

```
lib/
├── core/                          # Core functionality
│   ├── animations/                # Custom animations
│   ├── di/                        # Dependency injection
│   ├── helpers/                   # Utility functions
│   ├── network/                   # API services and error handling
│   ├── providers/                 # Global state providers
│   ├── routing/                   # App navigation
│   ├── screens/                   # Common screens
│   ├── theming/                   # App theme and styles
│   └── widgets/                   # Reusable UI components
│
├── features/                      # Feature modules
│   ├── auth/                      # Authentication
│   │   ├── login/
│   │   │   ├── data/             # Models and repositories
│   │   │   ├── logic/            # Business logic (Riverpod)
│   │   │   └── ui/               # Screens and widgets
│   │   └── sign_up/
│   │
│   ├── home/                      # Product catalog
│   │   ├── data/
│   │   ├── logic/
│   │   └── ui/
│   │
│   ├── cart/                      # Shopping cart
│   ├── profile/                   # User profile management
│   │   ├── orders/               # Order history
│   │   ├── profile/              # Profile info
│   │   ├── reviews/              # User reviews
│   │   └── shipping_address/     # Address management
│   │
│   ├── wishlist/                  # Wishlist functionality
│   ├── notifications/             # Push notifications
│   ├── onboarding/               # App introduction
│   ├── splash/                   # Splash screen
│   └── layout/                   # Main app layout
│
├── firebase_options.dart          # Firebase configuration
├── main_development.dart          # Development entry point
├── main_production.dart           # Production entry point
└── woodiex.dart                  # Main app widget
```

### Architecture Patterns

- **Clean Architecture**: Separation of concerns with data, domain, and presentation layers
- **Repository Pattern**: Abstraction of data sources
- **State Management**: Riverpod for reactive state management
- **Dependency Injection**: GetIt for service location
- **Code Generation**: Freezed for immutable models and JSON serialization

## 🛠️ Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Riverpod
- **Dependency Injection**: GetIt
- **Networking**: Dio
- **Local Storage**: SharedPreferences
- **Navigation**: GoRouter
- **Code Generation**: build_runner, freezed, json_annotation
- **Backend**: Firebase (Authentication, App Distribution)
- **CI/CD**: GitHub Actions + Fastlane

## 📦 CI/CD Pipeline

### GitHub Actions Workflow

The app uses GitHub Actions for continuous integration and deployment:

```yaml
name: Android Fastlane with Firebase App Distribution Workflow

on:
  push:
    branches:
      - development

jobs:
  distribute_to_firebase:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up JDK 17
        uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'

      - name: Install Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: stable
          cache: true

      - name: Accept Android SDK Licenses
        run: |
          yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses

      - name: Install Flutter dependencies
        run: flutter pub get

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.3.5'
          bundler-cache: true
          working-directory: android

      - name: Build and Distribute App
        env:
          FIREBASE_CLI_TOKEN: ${{ secrets.FIREBASE_CLI_TOKEN }}
        run: bundle exec fastlane android firebase_distribution
        working-directory: android
```

### Fastlane Configuration

The app uses Fastlane for automated building and distribution:

```ruby
default_platform(:android)

platform :android do
  desc "Lane for Android Firebase App Distribution"
  lane :firebase_distribution do
    sh "flutter clean"
    sh "flutter build apk --release --flavor production -t lib/main_production.dart --no-tree-shake-icons"
   
    firebase_app_distribution(
      app: "1:816882805153:android:b404de2f03a9f38aa883e0",
      firebase_cli_token: ENV["FIREBASE_CLI_TOKEN"], 
      android_artifact_type: "APK",
      android_artifact_path: "../build/app/outputs/flutter-apk/app-production-release.apk",
      testers: "elsayedmahmoud763@gmail.com,gamalwork81@gmail.com",
      release_notes: "This is a new release of the app for testing purposes. Please provide feedback.",
      upload_timeout: 600
    )
  end
end
```

### Pipeline Features

- **Automated Builds**: Triggers on push to development branch
- **Flutter Integration**: Latest stable Flutter version with caching
- **Android SDK**: Automatic license acceptance and setup
- **Firebase Distribution**: Automatic APK distribution to testers
- **Environment Support**: Production and development flavors
- **Error Handling**: Dependency validation and build verification

### Setup Instructions

1. **Firebase Setup**:
   - Create a Firebase project
   - Enable App Distribution
   - Generate Firebase CLI token: `firebase login:ci`
   - Add token to GitHub Secrets as `FIREBASE_CLI_TOKEN`

2. **GitHub Repository Secrets**:
   ```
   FIREBASE_CLI_TOKEN: <your-firebase-cli-token>
   ```

3. **Fastlane Setup**:
   ```bash
   cd android
   bundle install
   ```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable version)
- Android Studio / VS Code
- Android SDK
- Firebase CLI (for distribution)
- Ruby & Bundler (for Fastlane)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/woodiex.git
   cd woodiex
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Generate code**:
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**:
   ```bash
   # Development flavor
   flutter run --flavor development -t lib/main_development.dart
   
   # Production flavor
   flutter run --flavor production -t lib/main_production.dart
   ```

### Build Commands

```bash
# Development APK
flutter build apk --flavor development -t lib/main_development.dart

# Production APK
flutter build apk --release --flavor production -t lib/main_production.dart

# Development App Bundle
flutter build appbundle --flavor development -t lib/main_development.dart

# Production App Bundle
flutter build appbundle --release --flavor production -t lib/main_production.dart
```

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Integration tests
flutter drive --target=test_driver/app.dart
```

## 📝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **Development Team**: Elsayed Mahmoud, Gamal
- **Contact**: elsayedmahmoud763@gmail.com, gamalwork81@gmail.com

## 🔗 Links

- [Firebase Console](https://console.firebase.google.com/)
- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev/)
- [Fastlane Documentation](https://fastlane.tools/)

---

Made with ❤️ by the Woodiex Team

# 🍳 Cook Buddy - AI Recipe Assistant

[![Flutter](https://img.shields.io/badge/Flutter-3.7.2+-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Provider](https://img.shields.io/badge/Provider-State--Management-blue?style=for-the-badge)](https://pub.dev/packages/provider)
[![Gemini AI](https://img.shields.io/badge/AI-Gemini--Google-orange?style=for-the-badge)](https://ai.google.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Remote--Config-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com/)

**Cook Buddy** is a modern, AI-powered recipe assistant built with Flutter. It helps users discover delicious recipes by simply entering a dish name or a list of available ingredients. Using **Google Gemini AI**, it provides detailed instructions and ingredient lists in both **English and Hindi**.

---

## 📸 Screenshots

| Splash Screen | Main Screen | Loading State |
| :---: | :---: | :---: |
| ![Splash](screenshot/splash%20screen.jpg) | ![Main](screenshot/main%20screen.jpg) | ![Loading](screenshot/loading%20screen.jpg) |

| Search by Name | English Recipe | Hindi Recipe |
| :---: | :---: | :---: |
| ![Search Name](screenshot/search%20dish%20by%20name.jpg) | ![English](screenshot/english%20recipe%20and%20ingridents.jpg) | ![Hindi](screenshot/hindi%20recipe%20and%20ingridents.jpg) |

| Search by Ingredients |
| :---: |
| ![Search Ing](screenshot/search%20by%20ingridents.jpg) |

---

## ✨ Features

- 🤖 **AI-Powered Discovery**: Powered by Google Gemini for high-quality recipe suggestions.
- 🥗 **Ingredient-Based Search**: Input what's in your fridge, and get recipe ideas instantly.
- 🌐 **Bilingual Support**: Toggle between English and Hindi for recipes and instructions.
- ⚡ **Dynamic Configuration**: Uses Firebase Remote Config to manage API endpoints and keys without app updates.
- 📱 **Responsive Design**: Clean UI with a focus on ease of use in the kitchen.

---

## 🛠️ Project Structure

The project follows a clean **MVVM-inspired** architecture using the **Provider** pattern:

```text
lib/
├── model/           # Data structures (RecipeResponse, etc.)
├── services/        # API calls & Firebase Remote Config
│   ├── auto_config.dart
│   └── services.dart
├── view/            # UI Screens (Stateless/Stateful widgets)
│   ├── home.dart
│   └── splash.dart
├── viewmodel/       # State Management (Notifiers)
│   ├── recipe_view_model.dart
│   └── language_view_model.dart
├── utils/           # Shared constants, colors, and styles
│   ├── colors.dart
│   └── text_style.dart
└── main.dart        # Entry point
```

---

## ⚙️ Installation & Setup

### Prerequisites
- Flutter SDK (v3.7.2 or higher)
- Android Studio / VS Code
- A Google Gemini API Key

### Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/bhatiachirag2002/CookBuddy_using_Flutter_and_Provider-State-Management.git
   cd CookBuddy_using_Flutter_and_Provider-State-Management
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a project on [Firebase Console](https://console.firebase.google.com/).
   - Add an Android app and download `google-services.json`.
   - Place `google-services.json` in `android/app/`.
   - Enable **Remote Config** in Firebase and add a parameter `api_url` with your Gemini API endpoint.

4. **Run the App**
   ```bash
   flutter run
   ```

---

## 🔌 API Details

This project uses the **Google Gemini Pro API**. The prompt logic is designed to return structured JSON, which the app parses into the `RecipeResponse` model.

**Example Request Flow:**
1. App fetches `api_url` from **Firebase Remote Config**.
2. User enters query $\rightarrow$ `RecipeViewModel` calls `GeminiApiService`.
3. AI returns JSON containing `type`, `title`, `ingredients`, and `steps`.
4. UI updates instantly via `notifyListeners()`.

---

## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

---

## 👨‍💻 Developed By
**Chirag Bhatia**  
Feel free to reach out for collaborations or feedback!

---
*If you like this project, give it a ⭐ on GitHub!*

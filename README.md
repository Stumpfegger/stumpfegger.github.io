# AI Storybook - Flutter App

Egy gyerekeknek szóló AI mesegenerátor alkalmazás, amely **Ollama** segítségével készít egyedi meséket lokálisan, internetkapcsolat nélkül!

## 🚀 Funkciók

- **Lokális AI Mese Generálás**: Ollama AI modellek által generált egyedi, kreatív mesék
- **Automatikus Illusztrációk**: Színes placeholder képek minden oldalhoz
- **Interaktív Mesekönyv**: Lapozható mese megjelenítés
- **Lokális Könyvtár**: Mentett mesék tárolása és kezelése
- **Keresés**: Keresés a mentett mesék között
- **Gyerekbarát UI**: Színes, modern Material 3 dizájn
- **100% Offline**: Internetkapcsolat nélkül működik!

## 📱 Képernyők

1. **Főképernyő**: Üdvözlő képernyő a fő funkciókkal
2. **Mese Generálás**: Téma bevitel és AI generálás
3. **Mese Megjelenítés**: Lapozható mesekönyv nézet
4. **Könyvtár**: Mentett mesék listája és kezelése

## 🛠️ Technológiai Stack

- **Flutter**: 3.0+ (null safety)
- **Ollama**: Lokális AI model futtatás
- **Hive**: Lokális adatbázis
- **PageView**: Lapozható mese nézet
- **Material 3**: Modern UI dizájn

## 📋 Előfeltételek

- Flutter SDK 3.0.0 vagy újabb
- Dart 3.0.0 vagy újabb
- **Ollama telepítve és fut** (lásd: [OLLAMA_SETUP.md](OLLAMA_SETUP.md))
- Android Studio / VS Code

## ⚙️ Telepítés

### 1. Klónozás és függőségek telepítése

```bash
git clone <repository-url>
cd ai_storybook
flutter pub get
```

### 2. Ollama telepítése és beállítása

**Fontos**: Az alkalmazás használatához Ollama-t kell telepíteni!

Lásd a részletes útmutatót: [OLLAMA_SETUP.md](OLLAMA_SETUP.md)

Röviden:
```bash
# Ollama telepítése
# Windows: https://ollama.ai/download
# macOS/Linux: curl -fsSL https://ollama.ai/install.sh | sh

# Model letöltése
ollama pull llama2

# Ollama indítása
ollama serve
```

### 3. Hive model generálás

```bash
flutter packages pub run build_runner build
```

### 4. Alkalmazás futtatása

```bash
flutter run
```

## 🔧 Konfiguráció

### Ollama AI Mese Rendszer

Az alkalmazás a következő AI funkciókat biztosítja:

- **Lokális AI Modellek**: Ollama segítségével futtatott modellek
- **Chat API**: Modern chat formátum a jobb mese generáláshoz
- **Teljes Mesék**: Folyamatos, oldalakra nem bontott történetek
- **Szöveges Formátum**: Tisztán szöveges mesék, kép nélkül
- **Gyors Generálás**: Optimalizált teljesítmény
- **System Promptok**: Strukturált, gyerekbarát meseírás
- **Gyerekbarát Promptok**: Magyar nyelvű, korosztályhoz igazított mesék
- **Fallback Rendszer**: Kreatív mesék ha az AI nem elérhető
- **Offline Működés**: Internetkapcsolat nélkül is működik

### Alapértelmezett Beállítások

- **Ollama URL**: `http://127.0.0.1:11434`
- **Alapértelmezett Model**: `llama2`
- **Nyelv**: Magyar
- **Célközönség**: 3-8 éves gyerekek

### Model Változtatás

Más model használatához szerkeszd a `lib/services/openai_service.dart` fájlt:

```dart
// A generateStory metódusban:
'model': 'llama2', // Változtasd ezt a kívánt modellre

// Példák:
// 'llama2' - alapértelmezett
// 'llama3.2' - újabb verzió
// 'phi3:3.8b' - gyorsabb, kisebb modell
// 'mistral' - hatékony modell
```

## 📖 Használat

### 1. Új mese generálása

1. **Indítsd el Ollama-t** és győződj meg róla, hogy fut
2. Nyisd meg az alkalmazást
3. Kattints az "Új mese generálása" gombra
4. Írd be a mese témáját (pl. "kiskutya", "macska", "robot")
5. Kattints a "Generálás" gombra
6. Várj, amíg az AI elkészíti a mesét

### 2. Mese olvasása

- Használd a bal/jobb nyilakat a lapozáshoz
- A pontok jelzik az aktuális oldalt
- Minden oldal tartalmazza az illusztrációt és a szöveget

### 3. Mese mentése

- A mese megjelenítése közben kattints a "Mentés a könyvtárba" gombra
- A mese automatikusan mentésre kerül a lokális könyvtárba

### 4. Könyvtár kezelése

- A "Könyvtáram" menüpontban találod a mentett meséket
- Keresés a mesék között
- Egyedi vagy összes mese törlése
- Kattints egy mesére a megnyitáshoz

## 🎨 UI/UX Jellemzők

- **Színséma**: Kék alapú Material 3 dizájn
- **Gyerekbarát**: Nagy gombok, olvasható betűtípusok
- **Reszponzív**: Különböző képernyőméretek támogatása
- **Animációk**: Smooth átmenetek és loading állapotok
- **Hozzáférhetőség**: Világos kontrasztok és olvasható szövegek

## 🔒 Biztonság

- **100% Lokális**: Minden adat a saját gépeden marad
- **Nincs API kulcs**: Ollama lokálisan fut
- **Adatvédelem**: Nincs adatküldés harmadik feleknek
- **Offline**: Internetkapcsolat nélkül is működik

## 🐛 Hibaelhárítás

### Gyakori problémák

1. **"Ollama connection failed" hiba**
   - Ellenőrizd, hogy Ollama fut-e: `ollama list`
   - Indítsd újra Ollama-t: `ollama serve`
   - Ellenőrizd a port 11434 elérhetőségét

2. **"Model not found" hiba**
   - Töltsd le a modellt: `ollama pull llama2`
   - Ellenőrizd a letöltött modelleket: `ollama list`

3. **Lassú mese generálás**
   - Használj kisebb modelleket: `ollama pull llama2:7b`
   - Zárj be más alkalmazásokat a RAM felszabadításához

4. **Hive hiba**
   - Futtasd: `flutter packages pub run build_runner build`
   - Töröld az alkalmazást és telepítsd újra

### Debug mód

```bash
flutter run --debug
```

## 📱 Platform Támogatás

- ✅ Android (API 21+)
- ✅ iOS (12.0+)
- ✅ Web (Chrome, Firefox, Safari)
- ✅ Desktop (Windows, macOS, Linux)

## 🤝 Közreműködés

1. Fork a projektet
2. Hozz létre egy feature branch-et (`git checkout -b feature/amazing-feature`)
3. Commit a változtatásokat (`git commit -m 'Add amazing feature'`)
4. Push a branch-et (`git push origin feature/amazing-feature`)
5. Nyiss egy Pull Request-et

## 📄 Licenc

Ez a projekt MIT licenc alatt van. Lásd a `LICENSE` fájlt részletekért.

## 📞 Kapcsolat

Ha kérdésed van vagy problémába ütközöl:
- Nyiss egy Issue-t a GitHub-on
- Vagy írj emailt: pappzoltan.p@gmail.com

## 🙏 Köszönet

- **Ollama csapat** a lokális AI model futtatásért
- **Flutter csapat** a remek keretrendszerért
- **Hive csapat** a lokális adatbázis megoldásért

---

**Megjegyzés**: Ez az alkalmazás **Ollama**-t használ, amely ingyenes és lokálisan fut. Nincs szükség internetkapcsolatra vagy API kulcsokra a mese generáláshoz!

AI Storybook - Flutter App

A children’s AI story generator application that creates unique stories locally with Ollama, without an internet connection!

🚀 Features

Local AI Story Generation: Unique, creative stories generated by Ollama AI models

Automatic Illustrations: Colorful placeholder images for every page

Interactive Storybook: Page-flip story presentation

Local Library: Save and manage generated stories

Search: Find stories in the library

Child-Friendly UI: Colorful, modern Material 3 design

100% Offline: Works without an internet connection!

📱 Screens

Home Screen: Welcome screen with main functions

Story Generation: Enter topic and generate with AI

Story Display: Page-flip storybook view

Library: List and manage saved stories

🛠️ Technology Stack

Flutter: 3.0+ (null safety)

Ollama: Local AI model execution

Hive: Local database

PageView: Page-flip story view

Material 3: Modern UI design

📋 Prerequisites

Flutter SDK 3.0.0 or newer

Dart 3.0.0 or newer

Ollama installed and running (see: OLLAMA_SETUP.md
)

Android Studio / VS Code

⚙️ Installation
1. Clone and install dependencies
git clone <repository-url>
cd ai_storybook
flutter pub get

2. Install and set up Ollama

Important: You need Ollama installed to use the app!

See the detailed guide: OLLAMA_SETUP.md

Quick start:

# Install Ollama
# Windows: https://ollama.ai/download
# macOS/Linux: curl -fsSL https://ollama.ai/install.sh | sh

# Download model
ollama pull llama2

# Start Ollama
ollama serve

3. Hive model generation
flutter packages pub run build_runner build

4. Run the app
flutter run

🔧 Configuration
Ollama AI Story System

The application provides the following AI features:

Local AI Models: Models run locally with Ollama

Chat API: Modern chat format for better story generation

Full Stories: Continuous narratives, not split into pages by default

Text-Only Format: Plain text stories without images

Fast Generation: Optimized performance

System Prompts: Structured, child-friendly storytelling

Child-Friendly Prompts: Hungarian prompts tailored to age groups

Fallback System: Creative backup stories if AI is unavailable

Offline Operation: Works fully without internet access

Default Settings

Ollama URL: http://127.0.0.1:11434

Default Model: llama2

Language: Hungarian

Target Audience: Children aged 3–8

Changing Models

To use another model, edit the lib/services/openai_service.dart file:

// In the generateStory method:
'model': 'llama2', // Change this to the desired model

// Examples:
// 'llama2' - default
// 'llama3.2' - newer version
// 'phi3:3.8b' - smaller, faster model
// 'mistral' - efficient model

📖 Usage
1. Generate a new story

Start Ollama and make sure it is running

Open the application

Click on “Generate New Story”

Enter a topic (e.g., “puppy”, “cat”, “robot”)

Press “Generate”

Wait for the AI to create the story

2. Read a story

Use left/right arrows to flip pages

Dots indicate the current page

Each page includes an illustration and text

3. Save a story

While viewing a story, press “Save to Library”

The story will automatically be saved locally

4. Manage the library

Open “My Library” to see saved stories

Search through stories

Delete individual or all stories

Tap on a story to open it

🎨 UI/UX Features

Color Scheme: Blue-based Material 3 design

Child-Friendly: Large buttons, readable fonts

Responsive: Supports various screen sizes

Animations: Smooth transitions and loading states

Accessibility: Clear contrasts and readable text

🔒 Security

100% Local: All data stays on your device

No API Keys: Ollama runs locally

Data Privacy: No data sent to third parties

Offline: Works without internet access

🐛 Troubleshooting
Common Issues

“Ollama connection failed” error

Check if Ollama is running: ollama list

Restart Ollama: ollama serve

Verify port 11434 is available

“Model not found” error

Download model: ollama pull llama2

Check installed models: ollama list

Slow story generation

Use smaller models: ollama pull llama2:7b

Close other applications to free up RAM

Hive error

Run: flutter packages pub run build_runner build

Reinstall the app if needed

Debug mode
flutter run --debug

📱 Platform Support

✅ Android (API 21+)

✅ iOS (12.0+)

✅ Web (Chrome, Firefox, Safari)

✅ Desktop (Windows, macOS, Linux)

🤝 Contribution

Fork the project

Create a feature branch (git checkout -b feature/amazing-feature)

Commit changes (git commit -m 'Add amazing feature')

Push to branch (git push origin feature/amazing-feature)

Open a Pull Request

📄 License

This project is licensed under the MIT License. See the LICENSE file for details.

📞 Contact

If you have questions or issues:

Open an issue on GitHub

Or send an email: pappzoltan.p@gmail.com

🙏 Acknowledgements

Ollama team for local AI model execution

Flutter team for the framework

Hive team for the local database solution

Note: This application uses Ollama, which runs locally for free. No internet connection or API keys are required for story generation!

✅ Private: No data sent to third parties

✅ Customizable: You can use any model you want


- ✅ **Privát**: Nincs adatküldés harmadik feleknek
- ✅ **Testreszabható**: Bármilyen modellt használhatsz

# NearEats 🍽️

A Flutter mobile app for discovering restaurants near your current location.

## Team
- Iván Pérez Veiga
- Roger Ferrer Mora

## Tech Stack
- **Framework**: Flutter (Dart)
- **Platform**: Android
- **Local storage**: SharedPreferences
- **APIs**: OpenWeatherMap API, Geolocator

## Features
-  User authentication (login & register)
-  Home feed with restaurant list sorted by distance
-  Search with cuisine filters
-  Save favourite restaurants (persisted locally)
-  Profile screen with settings (dark mode, notifications, language)
-  Location services — detects current position and sorts restaurants by distance
-  Weather widget — shows current weather via OpenWeatherMap API
-  Design tokens — centralized colors, typography, spacing
-  Animations — card entrance animations and press micro-interactions
-  Responsive design — adapts layout for phone and tablet

## Project Structure
lib/
├── main.dart              # App entry point
├── theme/
│   └── app_theme.dart     # Design tokens (colors, typography, spacing)
├── screens/
│   ├── login_screen.dart
│   ├── main_screen.dart
│   ├── home_screen.dart
│   ├── search_screen.dart
│   ├── saved_screen.dart
│   ├── profile_screen.dart
│   └── restaurant_detail_screen.dart
├── services/
│   ├── location_service.dart
│   ├── weather_service.dart
│   └── saved_service.dart
└── models/
## Setup

### Requirements
- Flutter 3.44+
- Android Studio + Android SDK
- Android emulator or physical device

### Installation
1. Clone the repository:
```bash
   git clone https://github.com/ivanperezveiga-a11y/neareats.git
   cd neareats
```
2. Install dependencies:
```bash
   flutter pub get
```
3. Run the app:
```bash
   flutter run
```

## Git Branch Strategy
- `main` — stable releases
- `develop` — active development
- `feature/*` — individual features

## Screenshots
> App running on Android emulator (Pixel 8, API 35)
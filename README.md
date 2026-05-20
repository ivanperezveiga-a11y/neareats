# NearEats

A Flutter mobile app for discovering restaurants near your current location.

![Flutter](https://img.shields.io/badge/Flutter-3.44-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![Android](https://img.shields.io/badge/Platform-Android-green?logo=android)
![Tests](https://img.shields.io/badge/Tests-10%2F10%20passing-brightgreen)

## About

NearEats is a mobile application built with Flutter that helps users discover restaurants near their current location. The app shows real-time weather conditions, allows saving favourite restaurants, and provides an intuitive search experience with cuisine filters.

## Team

| Name | GitHub |
|------|--------|
| Ivan Pérez Veiga | [@ivanperezveiga-a11y](https://github.com/ivanperezveiga-a11y) |
| Roger Ferrer Mora | — |

## Features

- Authentication — Login and register screens with validation
- Home feed — Restaurant list sorted by real GPS distance
- Search — Real-time search with cuisine category filters
- Saved favourites — Persisted locally with SharedPreferences
- Restaurant detail — Info, opening hours, save/unsave
- Profile — Settings (dark mode, notifications, language)
- Location services — GPS-based restaurant sorting
- Weather API — Live weather via OpenWeatherMap
- Design tokens — Centralized colors, typography, spacing
- Animations — Card entrance animations and press micro-interactions
- Responsive — Adaptive layout for phone and tablet
- Unit tests — 10/10 passing (SavedService and WeatherService)

## Architecture

lib/
├── main.dart
├── theme/
│   └── app_theme.dart
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

## Getting Started

### Requirements

- Flutter 3.44+
- Dart 3.x
- Android Studio with Android SDK
- Android emulator or physical device (API 21+)

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
4. Run unit tests:
```bash
flutter test
```

## Dependencies

| Package | Purpose |
|---------|---------|
| `geolocator` | GPS location services |
| `shared_preferences` | Local data persistence |
| `http` | HTTP requests (Weather API) |

## Git Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Stable releases |
| `develop` | Active development |


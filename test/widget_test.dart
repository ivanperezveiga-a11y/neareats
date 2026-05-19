import 'package:flutter_test/flutter_test.dart';
import 'package:neareats/services/saved_service.dart';
import 'package:neareats/services/weather_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('SavedService tests', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    test('getSaved returns empty list initially', () async {
      final saved = await SavedService.getSaved();
      expect(saved, isEmpty);
    });

    test('saveRestaurant adds a restaurant', () async {
      final restaurant = {
        'name': 'La Piazza',
        'cuisine': 'Italian',
        'rating': 4.5,
        'distance': '0.3 km',
        'image': '🍕',
        'open': true,
      };
      await SavedService.saveRestaurant(restaurant);
      final saved = await SavedService.getSaved();
      expect(saved.length, 1);
      expect(saved.first['name'], 'La Piazza');
    });

    test('saveRestaurant does not add duplicates', () async {
      final restaurant = {
        'name': 'La Piazza',
        'cuisine': 'Italian',
        'rating': 4.5,
        'distance': '0.3 km',
        'image': '🍕',
        'open': true,
      };
      await SavedService.saveRestaurant(restaurant);
      await SavedService.saveRestaurant(restaurant);
      final saved = await SavedService.getSaved();
      expect(saved.length, 1);
    });

    test('removeRestaurant removes a restaurant', () async {
      final restaurant = {
        'name': 'La Piazza',
        'cuisine': 'Italian',
        'rating': 4.5,
        'distance': '0.3 km',
        'image': '🍕',
        'open': true,
      };
      await SavedService.saveRestaurant(restaurant);
      await SavedService.removeRestaurant('La Piazza');
      final saved = await SavedService.getSaved();
      expect(saved, isEmpty);
    });

    test('isSaved returns true for saved restaurant', () async {
      final restaurant = {
        'name': 'La Piazza',
        'cuisine': 'Italian',
        'rating': 4.5,
        'distance': '0.3 km',
        'image': '🍕',
        'open': true,
      };
      await SavedService.saveRestaurant(restaurant);
      final result = await SavedService.isSaved('La Piazza');
      expect(result, isTrue);
    });

    test('isSaved returns false for unsaved restaurant', () async {
      final result = await SavedService.isSaved('Burger House');
      expect(result, isFalse);
    });
  });

  group('WeatherService tests', () {
    test('getWeatherEmoji returns correct emoji for Clear', () {
      expect(WeatherService.getWeatherEmoji('Clear'), '☀️');
    });

    test('getWeatherEmoji returns correct emoji for Rain', () {
      expect(WeatherService.getWeatherEmoji('Rain'), '🌧️');
    });

    test('getWeatherEmoji returns correct emoji for Snow', () {
      expect(WeatherService.getWeatherEmoji('Snow'), '❄️');
    });

    test('getWeatherEmoji returns default emoji for unknown', () {
      expect(WeatherService.getWeatherEmoji('Unknown'), '🌤️');
    });
  });
}
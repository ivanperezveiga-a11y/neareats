import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  static const String _apiKey = '588bd777286f9f798de79eecc8030180';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  static Future<Map<String, dynamic>?> getWeather(double lat, double lon) async {
    try {
      final url = Uri.parse('$_baseUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'temp': data['main']['temp'].round(),
          'description': data['weather'][0]['description'],
          'icon': data['weather'][0]['main'],
        };
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static String getWeatherEmoji(String icon) {
    switch (icon) {
      case 'Clear': return '☀️';
      case 'Clouds': return '☁️';
      case 'Rain': return '🌧️';
      case 'Snow': return '❄️';
      case 'Thunderstorm': return '⛈️';
      case 'Drizzle': return '🌦️';
      default: return '🌤️';
    }
  }
}
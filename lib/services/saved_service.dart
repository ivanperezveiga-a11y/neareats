import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SavedService {
  static const String _key = 'saved_restaurants';

  static Future<List<Map<String, dynamic>>> getSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(_key);
    if (data == null) return [];
    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> saveRestaurant(Map<String, dynamic> restaurant) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = await getSaved();
    final exists = saved.any((r) => r['name'] == restaurant['name']);
    if (!exists) {
      saved.add(restaurant);
      await prefs.setString(_key, jsonEncode(saved));
    }
  }

  static Future<void> removeRestaurant(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final saved = await getSaved();
    saved.removeWhere((r) => r['name'] == name);
    await prefs.setString(_key, jsonEncode(saved));
  }

  static Future<bool> isSaved(String name) async {
    final saved = await getSaved();
    return saved.any((r) => r['name'] == name);
  }
}
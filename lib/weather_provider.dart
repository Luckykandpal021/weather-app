import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherProvider with ChangeNotifier {
  Map<String, dynamic>? weatherData;
  bool isLoading = false;
  String? error;

  // Fetch weather data for a given city
  Future<void> fetchWeather(String city) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      weatherData = await WeatherService().fetchWeather(city);
      await _saveCity(city); // Save the searched city
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveCity(String city) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('lastCity', city); // Save city to SharedPreferences
  }

  Future<String?> loadLastCity() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('lastCity'); // Return last searched city
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WeatherService {
  static String? apiKey = dotenv.env['WEATHER_API_KEY'];

  static const String baseUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  // Fetch weather data for a given city from the OpenWeatherMap API
  Future<Map<String, dynamic>> fetchWeather(String city) async {
    print("apikey:- ${apiKey}");
    if (apiKey != null && apiKey!.isNotEmpty) {
      final url = '$baseUrl?q=$city&appid=$apiKey&units=metric';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          print("response Body: ${response.body}");
          // Parse and return the JSON response
          return json.decode(response.body);
        } else {
          // Throw an exception if the response is not successful
          throw Exception(
              'Failed to fetch weather data: ${response.statusCode}');
        }
      } catch (e) {
        // Handle network errors or other exceptions
        print("Exception while fetching weather data: $e");
        throw Exception('Failed to fetch weather data: $e');
      }
    } else {
      throw Exception(
          'API key not found or empty. Please check your .env file.');
    }
  }
}

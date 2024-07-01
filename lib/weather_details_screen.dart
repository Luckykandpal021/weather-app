import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';
import 'home_screen.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final String city;

  WeatherDetailsScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    // Create an instance of WeatherProvider and fetch weather data for the given city
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider()..fetchWeather(city),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weather Details'),
          actions: [
            // Add a search button to the AppBar for navigating back to the HomeScreen
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
              },
            ),
          ],
        ),
        body: Consumer<WeatherProvider>(
          // Rebuild the UI based on the state of WeatherProvider
          builder: (context, provider, _) {
            // Show loading indicator while fetching weather data
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            // Show error message if there was an error fetching data

            if (provider.error != null) {
              return Center(child: Text(provider.error!));
            }
            // Get weather data from the provider
            final weatherData = provider.weatherData;
            if (weatherData == null) {
              return const Center(child: Text('No data available'));
            }

            // Display weather details
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('City: ${weatherData['name']}'),
                  Text('Temperature: ${weatherData['main']['temp']}°C'),
                  Text('Weather: ${weatherData['weather'][0]['description']}'),
                  Image.network(
                    'https://openweathermap.org/img/wn/${weatherData['weather'][0]['icon']}@2x.png',
                  ),
                  Text('Humidity: ${weatherData['main']['humidity']}%'),
                  Text('Wind Speed: ${weatherData['wind']['speed']} m/s'),
                  const SizedBox(height: 20),
                  // Button to refresh the weather data
                  ElevatedButton(
                    onPressed: () => provider.fetchWeather(city),
                    child: const Text('Refresh'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

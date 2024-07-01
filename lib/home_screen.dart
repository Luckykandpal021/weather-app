import 'package:flutter/material.dart';
import 'weather_details_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _cityController =
      TextEditingController(); //TextField Controller for Manipulating their content

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Enter city name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Getting text content from TextField Controller name _cityController,
                //if not Empty Then Navigating to WeatherDetailsScreen with passing city as their parameter
                final city = _cityController.text;
                if (city.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeatherDetailsScreen(city: city),
                    ),
                  );
                }
              },
              child: const Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_provider.dart';
import 'home_screen.dart';
import 'weather_details_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Setup ChangeNotifierProvider to manage the state of WeatherProvider
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      // Uses Consumer to rebuild the widget tree when WeatherProvider's state changes
      child: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Weather App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),

            // Uses FutureBuilder to handle asynchronous loading of last searched city from weatherProvider
            home: FutureBuilder<String?>(
              future: weatherProvider.loadLastCity(),
              builder: (context, snapshot) {
                // Displaying loading indicator while waiting for the future to complete
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  // Navigate to WeatherDetailsScreen if a last searched city is found
                  if (snapshot.data != null) {
                    return WeatherDetailsScreen(city: snapshot.data!);
                  } else {
                    // Navigating to HomeScreen if a last searched city is not found
                    return HomeScreen();
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }
}

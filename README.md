# weather_app (A Flutter Weather App)

A weather_app that fetches weather data using the OpenWeatherMap API based on user input. 
This app demonstrates integration with APIs, state management using Provider, and environment variable handling with `dotenv`.

## Features

- Search for weather by city name
- Display current weather conditions including temperature, weather description, humidity, and wind speed
- Refresh weather data and persist last searched city using `SharedPreferences`

## Requirements

- Flutter SDK (>= 3.22.2)

## Installation

1. **Clone the repository**

   git clone [https://github.com/Luckykandpal021/weather-app.git]

Api key is in .env Folder

## Run App on Device

Enable USB Debugging on Your Device

On your Android device, go to Settings > About phone > tap Build number seven times to enable Developer options.
Go back to Settings > Developer options > enable USB debugging.

Connect your device to your computer via USB or start an Android emulator.
Open the project in Android Studio.
Build and run the app using the green play button (Run).

## Dependencies
http: For making HTTP requests to fetch weather data.
provider: For state management and dependency injection.
flutter_dotenv: For loading environment variables from a .env file.


##  Project Structure
lib/main.dart: Entry point of the application.
lib/screens/: Contains HomeScreen.dart and WeatherDetailsScreen.dart.
lib/services/WeatherService.dart: Service for fetching weather data from OpenWeatherMap API.
lib/providers/WeatherProvider.dart: Provider class for managing weather data state.

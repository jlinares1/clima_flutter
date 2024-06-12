import 'package:clima_flutter/services/location.dart';
import 'package:clima_flutter/services/networking.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final openApiKey = dotenv.env['API_Key'];

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        urlPath: 'api.openweathermap.org',
        unEncodedPath: '/data/2.5/weather',
        queryParameters: {
          'q': cityName,
          'appid': openApiKey,
          'units': 'imperial'
        });

    return await networkHelper.getData();
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        urlPath: 'api.openweathermap.org',
        unEncodedPath: '/data/2.5/weather',
        queryParameters: {
          'lat': location.latitude.toString(),
          'lon': location.longitude.toString(),
          'appid': openApiKey,
          'units': 'imperial'
        });
    return await networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    switch (condition) {
      case < 300:
        return '🌩';
      case < 400:
        return '🌧';
      case < 600:
        return '☔️';
      case < 700:
        return '☃️';
      case < 800:
        return '🌫';
      case == 800:
        return '☀️';
      case <= 804:
        return '☁️';
      default:
        return '🤷‍';
    }
  }

  String getMessage(int temp) {
    switch (temp) {
      case > 75:
        return 'It\'s 🍦 time';
      case > 65:
        return 'Time for shorts and 👕';
      case < 50:
        return 'You\'ll need 🧣 and 🧤';
      default:
        return 'Bring a 🧥 just in case';
    }
  }
}

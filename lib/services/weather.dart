import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:http/http.dart' as http;

const apiKey = '0a5227a6517cdbb992e80d52aa318dec';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    Network networkProvider = Network(
        uri: Uri.https('api.openweathermap.org', '/data/2.5/weather',
            {'q': cityName, 'appid': apiKey, 'units': 'metric'}));

    var weatherData = await networkProvider.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherInformation() async {
    LocationManager locationManager = LocationManager();
    await locationManager.getCurrentLocation();

    Network networkProvider = Network(
        uri: Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': locationManager.getLatitude.toString(),
      'lon': locationManager.getLongitude.toString(),
      'appid': apiKey,
      'units': 'metric'
    }));

    var weatherData = await networkProvider.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}

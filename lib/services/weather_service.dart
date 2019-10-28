import '../services/location_service.dart';
import '../services/network_sercive.dart';
import '../constants.dart';

class WeatherService {
  Future<dynamic> getLocationWeather() async {
    try {
      LocationService location = LocationService();
      await location.getCurrentLocation();

      NetworkService networkHelper = NetworkService(
        '$kOpenWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$kApiKey&units=metric',
      );

      var weatherData = await networkHelper.getData();
      return weatherData;
    } catch (err) {
      print("Error (getLocationWeather): ${err.message}");
    }
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

  String getMessage(dynamic temp) {
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

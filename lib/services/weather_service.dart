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
}

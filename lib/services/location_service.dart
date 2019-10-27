import 'package:geolocator/geolocator.dart';

class LocationService {
  double latitude, longitude;

  Future<void> getCurrentLocation() async {
    try {
      Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;

      Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.lowest,
      );

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (err) {
      print("Error (getCurrentLocation): ${err.message}");
    }
  }
}

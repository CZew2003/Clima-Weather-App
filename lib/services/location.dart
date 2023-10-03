import 'package:geolocator/geolocator.dart';

class LocationManager {
  double? _lat, _long;

  Future<void> getCurrentLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _lat = position.latitude;
      _long = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  double? get getLatitude => _lat;
  double? get getLongitude => _long;
}

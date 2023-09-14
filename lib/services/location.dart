import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;
  Future<void> getLocation() async
  // futures because void func gives error when called in loading screen "This expression has a type of 'void' so its value can't be used."
  {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      print(e);
    }
  }
}

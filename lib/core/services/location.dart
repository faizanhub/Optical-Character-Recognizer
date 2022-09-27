import 'package:geolocator/geolocator.dart';

class Location {
  ///Get Current Location
  Future<Position> getCurrentLocation() async {
    try {
      // await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);

      return position;
    } catch (e) {
      print(e);
      throw Exception('Something wrong occurred');
    }
  }
}

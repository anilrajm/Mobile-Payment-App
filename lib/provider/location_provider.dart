//
// import 'package:geolocator/geolocator.dart';
//
// class LocationService {
//   Future<Position> getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw 'Location services are disabled.';
//     }
//
//     // Check if app has permission to access location
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       throw 'Location permissions are permanently denied, we cannot request permissions.';
//     }
//
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
//         throw 'Location permissions are denied (actual value: $permission).';
//       }
//     }
//
//     // Get current location
//     return await Geolocator.getCurrentPosition();
//   }
// }

 import 'package:geolocator/geolocator.dart';

class LocationProvider {
  String location = '';




Future<String> getLocation() async {
    bool serviceEnabled;
   LocationPermission permission;
   // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }
    // Check if app has permission to access location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }
        if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        throw 'Location permissions are denied (actual value: $permission).';
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      location = '${position.latitude},${position.longitude}';

    } catch (e) {
      print(e);
    }
        return location;
  }
}

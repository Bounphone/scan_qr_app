import 'package:location/location.dart';

Future<LocationData> getLocation() async {
  try {
    // create an instance of the Location class
    Location location = Location();

// check if location services are enabled
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw ('Can not enable location service');
      }
    }

// check if the app has permission to access location
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw ('Your permission is not enable');
      }
    }

// get the device's current location
    _locationData = await location.getLocation();
    return _locationData;
  } catch (e) {
    rethrow;
  }
}

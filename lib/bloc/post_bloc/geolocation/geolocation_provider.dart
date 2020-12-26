import 'package:geolocator/geolocator.dart';
import 'package:pokapp/bloc/post_bloc/geolocation/geolocation_exception.dart';
import 'package:pokapp/model/post.dart';

class GeolocationProvider {
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw new GeolocationDisabledException("Geolocation is disabled!");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      throw new GeolocationDeniedForeverException("Geolocation is denied! "
          " check settings");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        throw new GeolocationDeniedException("Geolocation is denied!");
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
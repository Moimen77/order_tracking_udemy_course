import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

class MapPickerRepository {
  Future<Either<String, Position>> getCurrentLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return left(
          'Location service is disabled.',
        );
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return left(
            'Location permission denied.',
          );
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return left(
          'Location permission permanently denied.',
        );
      }

      final position = await Geolocator.getCurrentPosition();

      return right(position);
    } catch (e) {
      return left(e.toString());
    }
  }
}

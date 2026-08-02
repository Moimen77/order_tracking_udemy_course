import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:practical_google_maps_example/features/PlacePicker/data/PlaceModel.dart';

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

  Future<Either<String, List<PlaceModel>>> searchPlaces(
    String query,
  ) async {
    try {
      final uri = Uri.https(
        'nominatim.openstreetmap.org',
        '/search',
        {
          'q': query,
          'format': 'json',
          'addressdetails': '1',
          'limit': '5',
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'practical_google_maps_example/1.0',
        },
      );

      if (response.statusCode != 200) {
        return left(
          'Failed to search places',
        );
      }

      final List<dynamic> data = jsonDecode(response.body);

      final places = data
          .map(
            (json) => PlaceModel.fromJson(json),
          )
          .toList();

      return right(places);
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, String>> getAddressFromLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      final uri = Uri.https(
        'nominatim.openstreetmap.org',
        '/reverse',
        {
          'lat': latitude.toString(),
          'lon': longitude.toString(),
          'format': 'json',
          'addressdetails': '1',
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'practical_google_maps_example/1.0',
        },
      );

      if (response.statusCode != 200) {
        return left(
          'Failed to get address',
        );
      }

      final data = jsonDecode(response.body);

      final address = data['display_name'] as String?;

      if (address == null || address.isEmpty) {
        return left(
          'Address not found',
        );
      }

      return right(address);
    } catch (e) {
      return left(e.toString());
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:googlemaps/src/.env.dart';
import 'package:googlemaps/src/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio = Dio();

  Future<Directions> getDirections({
    @required LatLng? origin,
    @required LatLng? destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin!.latitude},${origin.longitude}',
        'destination': '${destination!.latitude},${destination.longitude}',
        'key': googleAPIKey,
      },
    );

    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return throw "response not successful";
  }
}

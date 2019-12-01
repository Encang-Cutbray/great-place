import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyCHicCY8Oao_qeu4dIZbC5vGrx4IwOhOp4';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?' +
        'center=$latitude,$longitude' +
        '&zoom=16&size=600x300&maptype=roadmap' +
        '&markers=color:red%7Clabel:A%7C$latitude,$longitude' +
        '&key=$GOOGLE_API_KEY';
  }

  static Future<http.Response> _greatLocation(
      {double latitude, double longitude}) async {
    final googleGeo =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$GOOGLE_API_KEY';
    return await http.get(googleGeo);
  }

  static Future<String> getAddress(double latitude, double longitude) async {
    final response = await LocationHelper._greatLocation(
        latitude: latitude, longitude: longitude);
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}

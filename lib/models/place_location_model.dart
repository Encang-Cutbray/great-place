import 'package:flutter/foundation.dart';

class PlaceLocationModel {
  final double latitiude;
  final double longitude ;
  final String address;

  const PlaceLocationModel({
    @required this.latitiude,
    @required this.longitude,
    this.address,
  });
}

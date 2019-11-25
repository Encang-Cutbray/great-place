import 'package:flutter/foundation.dart';

class PlaceLocationModel {
  final double latitiude;
  final double logtitude;
  final String address;

  const PlaceLocationModel({
    @required this.latitiude,
    @required this.logtitude,
    this.address,
  });
}

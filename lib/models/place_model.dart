import 'dart:io';

import 'package:flutter/foundation.dart';

import './place_location_model.dart';

class PlaceModel {
  final String id;
  final String title;
  final PlaceLocationModel location;
  final File image;

  PlaceModel({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}

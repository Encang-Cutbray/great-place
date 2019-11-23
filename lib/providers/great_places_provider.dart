import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place_model.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<PlaceModel> _item = [];

  List<PlaceModel> get item {
    return [..._item];
  }

  void addPlace(String titlePlace, File imagePlace) {
    final newPlace = PlaceModel(
      id: DateTime.now().toIso8601String(),
      title: titlePlace,
      image: imagePlace,
      location: null,
    );
    _item.add(newPlace);
    notifyListeners();
  }
}

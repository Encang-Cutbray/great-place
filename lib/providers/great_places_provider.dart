import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/db_helper_dart.dart';
import '../models/place_model.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<PlaceModel> _item = [];

  List<PlaceModel> get item {
    return [..._item];
  }

  void addPlace(String titlePlace, File imagePlace) async {
    final newPlace = PlaceModel(
      id: DateTime.now().toIso8601String(),
      title: titlePlace,
      image: imagePlace,
      location: null,
    );
    _item.add(newPlace);
    await _insertToDatabase(newPlace);
    notifyListeners();
  }

  Future<void> fetchAndSetPlaces() async {
    final listPlaces = await DBHelper.getPlaces(DBHelper.userPlaces);
    _item = listPlaces
        .map(
          (places) => PlaceModel(
            id: places['id'],
            title: places['title'],
            location: null,
            image: File(
              places['image_path'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> _insertToDatabase(PlaceModel dataNewPlace) async {
    await DBHelper.insert(
      DBHelper.userPlaces,
      {
        'id': dataNewPlace.id,
        'title': dataNewPlace.title,
        'image_path': dataNewPlace.image.path
      },
    );
  }
}

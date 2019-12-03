import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/db_helper_dart.dart';
import '../helpers/location_helper.dart';

import '../models/place_model.dart';
import '../models/place_location_model.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<PlaceModel> _item = [];

  List<PlaceModel> get item {
    return [..._item];
  }

  PlaceModel findById(String id){
    return _item.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(String titlePlace, File imagePlace,
      PlaceLocationModel pickedLocation) async {
    final address = await LocationHelper.getAddress(
      pickedLocation.latitiude,
      pickedLocation.longitude,
    );

    final latLangWithAddress = PlaceLocationModel(
      latitiude: pickedLocation.latitiude,
      longitude: pickedLocation.longitude,
      address: address,
    );

    final newPlace = PlaceModel(
      id: DateTime.now().toIso8601String(),
      title: titlePlace,
      image: imagePlace,
      location: latLangWithAddress,
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
             image: File(
              places['image_path'],
            ),
            location: PlaceLocationModel(
              latitiude: places['latitude'],
              longitude: places['longitude'],
              address: places['address'],
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
        'image_path': dataNewPlace.image.path,
        'latitude': dataNewPlace.location.latitiude,
        'longitude': dataNewPlace.location.longitude,
        'address': dataNewPlace.location.address
      },
    );
  }
}

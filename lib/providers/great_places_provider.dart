import 'package:flutter/foundation.dart';

import '../models/place_model.dart';

class GreatPlaceProvider with ChangeNotifier {
  List<PlaceModel> _item = [];

  List<PlaceModel> get item {
    return [..._item];
  }
}

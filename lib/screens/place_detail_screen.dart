import 'package:flutter/material.dart';
import 'package:flutter_places/models/place_location_model.dart';
import 'package:provider/provider.dart';

import '../providers/great_places_provider.dart';

import '../screens/map_screen.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final userPlaceId = ModalRoute.of(context).settings.arguments;

    final selectedPlace =
        Provider.of<GreatPlaceProvider>(context, listen: false)
            .findById(userPlaceId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            child: Text("View On Map"),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              print(selectedPlace.location.latitiude);
              print(selectedPlace.location.longitude);
              // return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    isSelecting: false,
                    initialLocation: PlaceLocationModel(
                      latitiude: selectedPlace.location.latitiude,
                      longitude: selectedPlace.location.longitude,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

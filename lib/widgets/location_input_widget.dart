import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../helpers/alert_error_helper.dart';
import '../screens/map_screen.dart';

class LocationInputWidget extends StatefulWidget {
  final Function onSelectePlace;

  LocationInputWidget(this.onSelectePlace);

  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String _previewImageUrl;

  _showPreview(double lat, double long) {
    final staticMapImagePreview = LocationHelper.generateLocationPreviewImage(
        latitude: lat, longitude: long);
    setState(() {
      _previewImageUrl = staticMapImagePreview;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final currentLocation = await Location().getLocation();
      _showPreview(currentLocation.latitude, currentLocation.longitude);
      widget.onSelectePlace(
        currentLocation.latitude,
        currentLocation.longitude,
      );
    } on PlatformException catch (e) {
      await AlertErrorHelper.showDialogError(context, e);
    }
  }

  Future<void> _selectOnMap() async {
    LatLng locationWasSelect;

    final selectedLocation =
        await Navigator.of(context).pushNamed(MapScreen.routeName);
    if (selectedLocation == null) {
      return;
    }
    locationWasSelect = selectedLocation;
    _showPreview(locationWasSelect.latitude, locationWasSelect.longitude);
    widget.onSelectePlace(
      locationWasSelect.latitude,
      locationWasSelect.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No Location Chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              onPressed: _getCurrentLocation,
              textColor: Theme.of(context).primaryColor,
              label: Text('Refresh Location'),
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              onPressed: _selectOnMap,
              textColor: Theme.of(context).primaryColor,
              label: Text('Select On Map'),
            )
          ],
        )
      ],
    );
  }
}
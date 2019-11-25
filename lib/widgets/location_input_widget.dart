import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../helpers/alert_error_helper.dart';
import '../screens/map_screen.dart';

class LocationInputWidget extends StatefulWidget {
  @override
  _LocationInputWidgetState createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String _previewImageUrl;
  bool _hasDefaultLocation = true;

  Future<void> _getCurrentLocation() async {
    try {
      final currentLocation = await Location().getLocation();
      final staticMapImagePreview = LocationHelper.generateLocationPreviewImage(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude);
      setState(() {
        _previewImageUrl = staticMapImagePreview;
      });
    } on PlatformException catch (e) {
      print(e);
      await AlertErrorHelper.showDialogError(context, e);
    }
  }

  Future<void> _selectOnMap() async {
    final selectedLocation =
        await Navigator.of(context).pushNamed(MapScreen.routeName);
    if (selectedLocation == null) {
      return;
    }

    /* 
      Todo: Parsing Value To LatLngObject
      .............................
    */

  }

  @override
  void didChangeDependencies() {
    if (_hasDefaultLocation) {
      _getCurrentLocation();
    }
    setState(() {
      _hasDefaultLocation = false;
    });
    super.didChangeDependencies();
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

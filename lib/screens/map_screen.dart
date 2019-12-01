import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place_location_model.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocationModel initialLocation;
  final bool isSelecting;

  Future<LocationData> getDefaultLocation() async {
    return await Location().getLocation();
  }

  MapScreen({
    this.initialLocation = const PlaceLocationModel(
      latitiude: 37.4219983,
      logtitude: -122.084,
    ),
    this.isSelecting = true,
  });

  static const routeName = '/map-screen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedLocation;

  void _selectLocation(LatLng position) {
    setState(() => _pickedLocation = position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _pickedLocation == null
                  ? null
                  : () => Navigator.of(context).pop(_pickedLocation),
            )
        ],
        title: Text('Awesome Location'),
      ),
      body: Container(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.initialLocation.latitiude,
              widget.initialLocation.logtitude,
            ),
            zoom: 16,
          ),
          onTap: widget.isSelecting ? _selectLocation : null,
          markers: _pickedLocation == null && widget.isSelecting
              ? null
              : {
                  Marker(
                    markerId: MarkerId('marker-id'),
                    position: _pickedLocation,
                  ),
                },
        ),
      ),
    );
  }
}

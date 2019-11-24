import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Awesome Location'),),
    );
  }
}
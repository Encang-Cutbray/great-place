import 'package:flutter/material.dart';
import 'package:flutter_places/screens/place_add_screen.dart';


class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(PlaceAddScreen.routeName);
            },
          )
        ],
      ),
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}

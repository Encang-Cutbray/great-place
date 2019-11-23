import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './place_add_screen.dart';
import '../providers/great_places_provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final greatListPlaces = Provider.of<GreatPlaceProvider>(context).item;

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
      body: greatListPlaces.length <= 0
          ? Center(
              child: const Text('Add new awesome places'),
            )
          : ListView.builder(
              itemCount: greatListPlaces.length,
              itemBuilder: (ctx, index) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(greatListPlaces[index].image),
                ),
                title: Text(greatListPlaces[index].title),
              ),
            ),
    );
  }
}

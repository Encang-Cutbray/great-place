import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './place_add_screen.dart';
import '../providers/great_places_provider.dart';

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
      body: FutureBuilder(
        future: Provider.of<GreatPlaceProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaceProvider>(
                builder: (_, listGreatPlace, child) =>
                    listGreatPlace.item.length <= 0
                        ? Center(
                            child: Text('Add Some Great Places'),
                          )
                        : ListView.builder(
                            itemCount: listGreatPlace.item.length,
                            itemBuilder: (ctx, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(listGreatPlace.item[index].image),
                              ),
                              title: Text(listGreatPlace.item[index].title),
                            ),
                          ),
              ),
      ),
      // greatListPlaces.length <= 0
      //     ? Center(
      //         child: const Text('Add new awesome places'),
      //       )
      //     : ListView.builder(
      //         itemCount: greatListPlaces.length,
      //         itemBuilder: (ctx, index) => ListTile(
      //           leading: CircleAvatar(
      //             backgroundImage: FileImage(greatListPlaces[index].image),
      //           ),
      //           title: Text(greatListPlaces[index].title),
      //         ),
      //       ),
    );
  }
}

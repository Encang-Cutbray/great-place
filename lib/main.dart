import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './helpers/page_transition_helper.dart';
import './providers/great_places_provider.dart';

import './screens/places_list_screen.dart';
import './screens/place_add_screen.dart';
import './screens/place_detail_screen.dart';

import './screens/map_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GreatPlaceProvider(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: PageTransitionHelper(),
              TargetPlatform.iOS: PageTransitionHelper(),
            }),
          ),
          home: PlacesList(),
          routes: {
            PlaceAddScreen.routeName: (_) => PlaceAddScreen(),
            MapScreen.routeName: (_) => MapScreen(),
            PlaceDetailScreen.routeName: (_) => PlaceDetailScreen(),
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import './providers/great_places_provider.dart';
import './models/place_location_model.dart';
import './helpers/page_transition_helper.dart';
import './helpers/alert_error_helper.dart';

import './screens/places_list_screen.dart';
import './screens/place_add_screen.dart';
import './screens/place_detail_screen.dart';
import './screens/map_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PlaceLocationModel currentLatitude;

  Future<void> _getCurrentLocation(BuildContext context) async {
    try {
      final currentLocation = await Location().getLocation();
        currentLatitude = PlaceLocationModel(
            latitiude: currentLocation.latitude,
            longitude: currentLocation.longitude);
    } on PlatformException catch (e) {
      await AlertErrorHelper.showDialogError(context, e);
    }
  }

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void didChangeDependencies() async{
    await _getCurrentLocation(context);
    print('build $currentLatitude');
    super.didChangeDependencies();
  }
  

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
            MapScreen.routeName: (_) => MapScreen(
                  initialLocation: currentLatitude,
                  isSelecting: true,
                ),
            PlaceDetailScreen.routeName: (_) => PlaceDetailScreen(),
          }),
    );
  }
}

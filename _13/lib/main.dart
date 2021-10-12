import 'package:_13/providers/great_places.dart';
import 'package:_13/screens/add_place_screen.dart';
import 'package:_13/screens/places_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          colorScheme: ThemeData.light().colorScheme.copyWith(
                secondary: Colors.amber,
              ),
          // textTheme: ThemeData.light().textTheme.copyWith(
          //       button: ThemeData.light().textTheme.button?.copyWith(
          //             color: Colors.black,
          //           ),
          // ),
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
        },
      ),
    );
  }
}

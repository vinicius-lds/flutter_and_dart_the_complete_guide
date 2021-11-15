import 'package:_13/providers/great_places.dart';
import 'package:_13/screens/add_place_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<GreatPlaces>(
            child: const Center(
              child: Text('Got no places yet. Start adding some!'),
            ),
            builder: (ctx, greatPlaces, child) {
              if (greatPlaces.items.isEmpty) {
                return child!;
              } else {
                return ListView.builder(
                  itemBuilder: (ctx, idx) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(
                          greatPlaces.items[idx].image,
                        ),
                      ),
                      title: Text(greatPlaces.items[idx].title),
                      onTap: () {},
                    );
                  },
                  itemCount: greatPlaces.items.length,
                );
              }
            },
          );
        },
      ),
    );
  }
}

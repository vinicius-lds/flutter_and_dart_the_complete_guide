import 'dart:io';

import 'package:_13/helpers/db_helper.dart';
import 'package:_13/models/place.dart';
import 'package:flutter/foundation.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace({
    required String title,
    required File image,
  }) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      location: const PlaceLocation(
        latitude: 0,
        longitude: 0,
        address: null,
      ),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: const PlaceLocation(
              latitude: 0,
              longitude: 0,
              address: null,
            ),
            image: File(item['image']),
          ),
        )
        .toList();
    notifyListeners();
  }
}

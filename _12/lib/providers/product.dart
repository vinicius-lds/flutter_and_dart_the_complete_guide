import 'dart:convert';

import 'package:_12/models/http_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final uri = Uri.https(
        'flutter-the-complete-guide-default-rtdb.firebaseio.com',
        'userFavorites/$userId/$id.json',
        {
          'auth': token,
        },
      );
      final response =
          await http.put(uri, body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        throw const HttpException('Putting failed');
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}

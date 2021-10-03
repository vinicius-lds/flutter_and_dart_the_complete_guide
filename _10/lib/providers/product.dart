import 'dart:convert';

import 'package:_10/models/http_exception.dart';
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

  Future<void> toggleFavorite() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final uri = Uri.https(
        'flutter-the-complete-guide-default-rtdb.firebaseio.com',
        'products/$id.json',
      );
      final response =
          await http.patch(uri, body: json.encode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        throw const HttpException('Patching failed');
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}

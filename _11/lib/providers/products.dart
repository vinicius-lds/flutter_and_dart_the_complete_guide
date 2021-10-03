import 'dart:convert';

import 'package:_11/models/http_exception.dart';
import 'package:_11/providers/product.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items;
  String token;
  String userId;

  Products(this.token, this._items, this.userId);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favorites {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return items.firstWhere((product) => product.id == id);
  }

  Future<void> fetchAndSetProducts({bool filterByUser = false}) async {
    Map<String, String> _getParams(bool filterByUser) {
      if (filterByUser) {
        return {
          'auth': token,
          'orderBy': '"creator"',
          'equalTo': '"$userId"',
        };
      } else {
        return {
          'auth': token,
        };
      }
    }

    final uri = Uri.https(
      'flutter-the-complete-guide-default-rtdb.firebaseio.com',
      'products.json',
      _getParams(filterByUser),
    );
    try {
      final Map<String, dynamic>? response =
          json.decode((await http.get(uri)).body);
      _items = [];
      if (response != null) {
        final uri = Uri.https(
          'flutter-the-complete-guide-default-rtdb.firebaseio.com',
          'userFavorites/$userId.json',
          {
            'auth': token,
          },
        );
        final favoritesResponse = await http.get(uri);
        final favoritesData =
            json.decode(favoritesResponse.body) as Map<String, dynamic>?;
        response.forEach((key, value) {
          final product = Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isFavorite: favoritesData == null || favoritesData[key] == null
                ? false
                : favoritesData[key]['isFavorite'] ?? false,
          );
          _items.add(product);
        });
      }
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final uri = Uri.https(
        'flutter-the-complete-guide-default-rtdb.firebaseio.com',
        'products.json',
        {
          'auth': token,
        },
      );
      final response = await http.post(
        uri,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': false,
          'creator': userId,
        }),
      );
      final responseBody = json.decode(response.body);
      _items.add(Product(
        id: responseBody['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      ));
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final uri = Uri.https(
        'flutter-the-complete-guide-default-rtdb.firebaseio.com',
        'products/$id.json',
        {
          'auth': token,
        },
      );
      await http.patch(
        uri,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'price': newProduct.price,
          'imageUrl': newProduct.imageUrl,
          'isFavorite': newProduct.isFavorite,
        }),
      );
      _items[productIndex] = Product(
        id: newProduct.id,
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl,
        isFavorite: newProduct.isFavorite,
      );
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    final existingProduct = _items[productIndex];
    _items.removeAt(productIndex);
    notifyListeners();
    try {
      final uri = Uri.https(
        'flutter-the-complete-guide-default-rtdb.firebaseio.com',
        'products/$id',
        {
          'auth': token,
        },
      );
      final response = await http.delete(uri);
      if (response.statusCode >= 400) {
        throw const HttpException('Could not delete product');
      }
    } catch (error) {
      print(error);
      _items.insert(productIndex, existingProduct);
      notifyListeners();
      rethrow;
    }
  }
}

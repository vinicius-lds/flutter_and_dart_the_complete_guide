import 'dart:convert';

import 'package:_10/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  const OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final uri = Uri.https(
      'flutter-the-complete-guide-default-rtdb.firebaseio.com',
      'orders.json',
    );
    try {
      final Map<String, dynamic>? response =
          json.decode((await http.get(uri)).body);
      _orders = [];
      response!.forEach((key, value) {
        final product = OrderItem(
          id: key,
          amount: value['amount'],
          products: (value['products'] as List<dynamic>).map((item) {
            return CartItem(
              id: item['id'],
              title: item['title'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
          dateTime: DateTime.parse(value['dateTime']),
        );
        _orders.insert(0, product);
      });
      notifyListeners();
    } catch (err) {
      rethrow;
    }
  }

  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    final uri = Uri.https(
      'flutter-the-complete-guide-default-rtdb.firebaseio.com',
      'orders.json',
    );
    final dateTime = DateTime.now();
    final response = await http.post(
      uri,
      body: json.encode({
        'amount': total,
        'products': cartItems.map((item) {
          return {
            'id': item.id,
            'title': item.title,
            'quantity': item.quantity,
            'price': item.price,
          };
        }).toList(),
        'dateTime': dateTime.toIso8601String(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartItems,
        dateTime: dateTime,
      ),
    );
    notifyListeners();
  }
}

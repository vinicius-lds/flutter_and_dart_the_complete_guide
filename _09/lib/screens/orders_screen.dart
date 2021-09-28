import 'package:_09/providers/orders.dart' show Orders;
import 'package:_09/widgets/app_drawer.dart';
import 'package:_09/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (bContext, index) => OrderItem(
          orderItem: orders.orders[index],
        ),
      ),
    );
  }
}

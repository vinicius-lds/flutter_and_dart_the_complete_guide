import 'package:_12/providers/orders.dart' show Orders;
import 'package:_12/widgets/app_drawer.dart';
import 'package:_12/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Future<void>? _fetchOrders;

  @override
  void initState() {
    _fetchOrders =
        Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your orders'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: _fetchOrders,
        builder: (bContext, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.hasError) {}
            return Consumer<Orders>(
              builder: (bContext, orders, child) {
                return ListView.builder(
                  itemCount: orders.orders.length,
                  itemBuilder: (bContext, index) => OrderItem(
                    orderItem: orders.orders[index],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

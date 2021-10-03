import 'package:_12/helpers/custom_route.dart';
import 'package:_12/providers/auth.dart';
import 'package:_12/providers/orders.dart';
import 'package:_12/screens/orders_screen.dart';
import 'package:_12/screens/products_overview_screen.dart';
import 'package:_12/screens/user_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ProductsOverviewScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            // onTap: () => Navigator.of(context)
            //     .pushReplacementNamed(OrdersScreen.routeName),
            onTap: () {
              Navigator.of(context).pushReplacement(
                CustomRoute(builder: (bContext) => const OrdersScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Manage products'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}

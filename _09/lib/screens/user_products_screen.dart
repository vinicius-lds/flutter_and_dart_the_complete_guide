import 'package:_09/providers/products.dart';
import 'package:_09/screens/edit_product_screen.dart';
import 'package:_09/widgets/app_drawer.dart';
import 'package:_09/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = '/user-products';

  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (bContext, index) {
            return Column(
              children: [
                UserProductItem(
                  productId: products.items[index].id,
                  title: products.items[index].title,
                  imageUrl: products.items[index].imageUrl,
                ),
                const Divider(),
              ],
            );
          },
          itemCount: products.items.length,
        ),
      ),
    );
  }
}

import 'package:_11/providers/products.dart';
import 'package:_11/screens/edit_product_screen.dart';
import 'package:_11/widgets/app_drawer.dart';
import 'package:_11/widgets/user_product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = '/user-products';

  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(filterByUser: true);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (bContext, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: Consumer<Products>(
                builder: (bContext, products, child) {
                  return Padding(
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
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

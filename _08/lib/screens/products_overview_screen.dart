import 'package:_08/providers/cart.dart';
import 'package:_08/providers/products.dart';
import 'package:_08/screens/cart_screen.dart';
import 'package:_08/widgets/app_drawer.dart';
import 'package:_08/widgets/badge.dart';
import 'package:_08/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = '/';

  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool showOnlyFavorites = false;

  void onFilterSelection(FilterOptions option) {
    setState(() => showOnlyFavorites = option == FilterOptions.favorites);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: onFilterSelection,
            itemBuilder: (bContext) => const [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (bContext, cart, child) => Badge(
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName),
              ),
              value: '${cart.itemCount}',
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(
        showOnlyFavorites: showOnlyFavorites,
      ),
    );
  }
}

import 'package:_11/providers/cart.dart';
import 'package:_11/providers/products.dart';
import 'package:_11/screens/cart_screen.dart';
import 'package:_11/widgets/app_drawer.dart';
import 'package:_11/widgets/badge.dart';
import 'package:_11/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const String routeName = '/products-overview';

  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      setState(() => _isLoading = true);
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() => _isLoading = false);
      });
    }
    super.didChangeDependencies();
  }

  void onFilterSelection(FilterOptions option) {
    setState(() => _showOnlyFavorites = option == FilterOptions.favorites);
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(
              showOnlyFavorites: _showOnlyFavorites,
            ),
    );
  }
}

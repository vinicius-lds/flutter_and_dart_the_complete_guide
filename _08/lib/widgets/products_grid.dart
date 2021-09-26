import 'package:_08/providers/products.dart';
import 'package:_08/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key? key, this.showOnlyFavorites = false})
      : super(key: key);

  final bool showOnlyFavorites;

  // final List<Product> loadedProducts;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: showOnlyFavorites
          ? productsData.favorites.length
          : productsData.items.length,
      itemBuilder: (bContext, index) => ChangeNotifierProvider.value(
        value: showOnlyFavorites
            ? productsData.favorites[index]
            : productsData.items[index],
        child: const ProductItem(),
      ),
    );
  }
}

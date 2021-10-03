import 'package:_12/providers/product.dart';
import 'package:_12/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)!.settings.arguments as String;
    final Product product = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(product.title),
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(product.title),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 11,
                ),
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 11,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                  ),
                  width: double.infinity,
                  child: Text(
                    product.description,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 800,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

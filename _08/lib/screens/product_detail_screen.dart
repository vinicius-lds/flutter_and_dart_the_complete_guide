import 'package:_08/models/product.dart';
import 'package:_08/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/product-detail';

  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)!.settings.arguments as String;
    final String productTitle = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId).title;
    return Scaffold(
      appBar: AppBar(
        title: Text(productTitle),
      ),
    );
  }
}

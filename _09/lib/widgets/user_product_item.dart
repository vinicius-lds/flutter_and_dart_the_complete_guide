import 'package:_09/providers/products.dart';
import 'package:_09/screens/edit_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({
    Key? key,
    required this.productId,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  final String productId;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).pushNamed(
                EditProductScreen.routeName,
                arguments: productId,
              ),
              icon: const Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () => Provider.of<Products>(context, listen: false)
                  .deleteProduct(productId),
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}

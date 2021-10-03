import 'package:_11/providers/products.dart';
import 'package:_11/screens/edit_product_screen.dart';
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
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: SizedBox(
        width: 110,
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
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(productId);
                } catch (error) {
                  scaffold.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Deleting failed',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}

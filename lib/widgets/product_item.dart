import 'package:flutter/material.dart';
import 'package:newapp/utils/app_routes.dart';
import 'package:provider/provider.dart';
import '../exceptions/http_exception.dart';
import '../models/product.dart';
import '../models/product_list.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productForm,
                  arguments: product,
                );
              },
              color: Colors.purple,
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Tem certeza?'),
                    content: const Text("Quer remover o produto?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('Sim'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('Não'),
                      )
                    ],
                  ),
                ).then((value) {
                  if (value ?? false) {
                    try {
                      Provider.of<ProductList>(context, listen: false)
                          .removeProduct(product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Produto deletado com sucesso!"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } on HttpException catch (error) {
                      msg.showSnackBar(
                        SnackBar(
                          content: Text(
                            error.toString(),
                          ),
                        ),
                      );
                    }
                  }
                });
              },
              color: Colors.redAccent,
              icon: const Icon(Icons.delete),
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}

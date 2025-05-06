import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../provider/globalProvider.dart';
import '../screens/product_detail.dart';
import '../screens/login_page.dart';

class ProductViewShop extends StatelessWidget {
  final ProductModel data;

  const ProductViewShop(this.data, {super.key});

  void _onFavoriteTap(BuildContext context, GlobalProvider provider) {
    if (!provider.isLoggedIn) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
    } else {
      provider.toggleFavorite(data);
    }
  }

  void _onCartTap(BuildContext context, GlobalProvider provider) {
    if (!provider.isLoggedIn) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginPage()));
    } else {
      provider.addCartItems(data);
    }
  }

  void _requireLoginThen(
      BuildContext context, Function(GlobalProvider) action) {
    final provider = Provider.of<GlobalProvider>(context, listen: false);

    if (!provider.isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LoginPage(
            onSuccess: () {
              action(provider); // login хийсний дараа үйлдлийг гүйцэтгэнэ
            },
          ),
        ),
      );
    } else {
      action(provider); // шууд гүйцэтгэнэ
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);

    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => Product_detail(data)));
      },
      child: Card(
        elevation: 4.0,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data.image!),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      provider.favorites.contains(data)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      _requireLoginThen(context, (p) => p.toggleFavorite(data));
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${data.price!.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.green,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          _requireLoginThen(
                              context, (p) => p.addCartItems(data));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

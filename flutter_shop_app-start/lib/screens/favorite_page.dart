import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/globalProvider.dart';
import '../models/product_model.dart';
import '../screens/product_detail.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    final favorites = provider.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text("Таалагдсан бараанууд")),
      body: favorites.isEmpty
          ? const Center(child: Text("Таалагдсан бараа алга байна"))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final product = favorites[index];
                return ListTile(
                  leading: Image.network(product.image!, width: 50),
                  title: Text(product.title!),
                  subtitle: Text("\$${product.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => provider.toggleFavorite(product),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => Product_detail(product)),
                    );
                  },
                );
              },
            ),
    );
  }
}

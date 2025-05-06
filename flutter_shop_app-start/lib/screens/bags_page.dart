import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/globalProvider.dart';
import '../models/product_model.dart';

class BagsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GlobalProvider>(context);
    final cartItems = provider.cartItems;

    double total = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.price! * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('My Bag')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: Image.network(item.image!, width: 50),
                    title: Text(item.title!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Size: M'),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                provider.decreaseQuantity(item);
                              },
                            ),
                            Text('${item.quantity}'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                provider.increaseQauntity(item);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Text(
                        "\$${(item.price! * item.quantity).toStringAsFixed(2)}"),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Total Amount: \$${total.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12)),
                  child:
                      const Text("CHECK OUT", style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

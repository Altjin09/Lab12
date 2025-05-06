import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/globalProvider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<GlobalProvider>(context).currentUser;

    if (user == null) {
      return const Center(child: Text("Нэвтрээгүй байна."));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(radius: 30, child: Icon(Icons.person)),
            title: Text(user.fullName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(user.email),
          ),
          const Divider(),
          const ListTile(
              title: Text("My orders"), trailing: Icon(Icons.expand_more)),
          const ListTile(
              title: Text("Shipping addresses"),
              trailing: Icon(Icons.expand_more)),
          const ListTile(
              title: Text("Payment methods"),
              trailing: Icon(Icons.expand_more)),
          const ListTile(
              title: Text("Promotion codes"),
              trailing: Icon(Icons.expand_more)),
          const ListTile(
              title: Text("My reviews"), trailing: Icon(Icons.expand_more)),
          const ListTile(
              title: Text("Settings"), trailing: Icon(Icons.expand_more)),
        ],
      ),
    );
  }
}

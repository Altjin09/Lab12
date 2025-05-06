import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/users.dart';
import '../provider/globalProvider.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onSuccess;
  const LoginPage({super.key, this.onSuccess});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  Future<List<UserModel>> loadUsers() async {
    final data = await rootBundle.loadString('assets/users.json');
    final List<dynamic> jsonResult = json.decode(data);
    return jsonResult
        .map<UserModel>((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  void login() async {
    final email = emailController.text.trim();
    final users = await loadUsers();

    final matchedUser = users.firstWhere(
      (user) => user.email == email,
      orElse: () => UserModel(
          firstName: '', lastName: '', email: '', username: '', phone: ''),
    );

    if (matchedUser.email.isNotEmpty) {
      Provider.of<GlobalProvider>(context, listen: false).setUser(matchedUser);
      if (widget.onSuccess != null) {
        widget.onSuccess!();
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Хэрэглэгч олдсонгүй")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Email хаягаа оруулна уу"),
            TextField(controller: emailController),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text("Нэвтрэх")),
          ],
        ),
      ),
    );
  }
}

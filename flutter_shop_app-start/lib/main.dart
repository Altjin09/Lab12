import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/globalProvider.dart';
import '../../../screens/home_page.dart';
import 'package:shop_app/screens/login_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => GlobalProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: HomePage(),
    );
  }
}

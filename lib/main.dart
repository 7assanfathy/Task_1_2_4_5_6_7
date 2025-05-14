import 'package:flutter/material.dart';
import 'package:projects/favorite/favorite_model.dart';
import 'package:provider/provider.dart';
import 'add_item/item_model.dart';
import 'dashboard/dashboard_screen.dart';
import 'dashboard/nav_bar.dart';
import 'profile/user_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => ItemModel()),
        ChangeNotifierProvider(create: (_) => FavoriteModel()),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const NavBar(),
    );
  }
}

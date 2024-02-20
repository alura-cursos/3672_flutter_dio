import 'package:flutter/material.dart';
import 'package:flutter_listin/_core/listin_routes.dart';
import 'package:flutter_listin/_core/listin_theme.dart';
import 'package:flutter_listin/products/model/product.dart';
import "package:hive_flutter/hive_flutter.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listin',
      debugShowCheckedModeBanner: false,
      theme: ListinTheme.mainTheme,
      initialRoute: ListinRoutes.auth,
      onGenerateRoute: ListinRoutes.generateRoute,
    );
  }
}

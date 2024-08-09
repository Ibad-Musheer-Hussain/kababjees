import 'package:flutter/material.dart';
import 'package:kababjees/CartPage.dart';
import 'package:kababjees/HomeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kababjees/Introduction.dart';
import 'package:kababjees/itemPage.dart';
import 'package:provider/provider.dart';
import 'package:kababjees/cart_provider.dart';
import 'package:kababjees/StartPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/HomeScreen': (context) => Homescreen(),
        '/itemPage': (context) => Itempage(),
        '/introduction': (context) => Introduction(),
        '/cartPage': (context) => Cartpage()
      },
      home: StartPage(),
    );
  }
}

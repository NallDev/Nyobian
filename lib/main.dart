import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/splash_screen.dart';
import 'package:restaurant_app/utils/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      initialRoute: MySplashScreen.routeName,
      routes: {
        MySplashScreen.routeName: (context) => const MySplashScreen(),
        MyHomeScreen.routeName: (context) => const MyHomeScreen(),
        MyDetailScreen.routeName: (context) => MyDetailScreen(restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}
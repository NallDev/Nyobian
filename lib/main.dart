import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/network/api_service.dart';
import 'package:restaurant_app/provider/connectivity_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/splash_screen.dart';
import 'package:restaurant_app/utils/constant.dart';

import 'data/model/search_restaurant_response.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => RestaurantProvider(apiService: ApiService()),
      ),
      ChangeNotifierProvider(
        create: (_) => ConnectivityProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => DetailRestaurantProvider(apiService: ApiService()),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        MyDetailScreen.routeName: (context) => MyDetailScreen(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}

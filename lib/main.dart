import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/local/db_helper.dart';
import 'package:restaurant_app/data/network/api_service.dart';
import 'package:restaurant_app/main_screen.dart';
import 'package:restaurant_app/provider/connectivity_provider.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/provider/detail_restaurant_provider.dart';
import 'package:restaurant_app/provider/reminder_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/splash_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/constant.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import 'data/model/search_restaurant_response.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

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
      ChangeNotifierProvider(
        create: (_) => DbProvider(dbHelper: DbHelper()),
      ),
      ChangeNotifierProvider(
        create: (_) => ReminderProvider(),
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
        MainScreen.routeName: (context) => const MainScreen(),
        MySplashScreen.routeName: (context) => const MySplashScreen(),
        MyHomeScreen.routeName: (context) => const MyHomeScreen(),
        MyDetailScreen.routeName: (context) => MyDetailScreen(
            restaurant:
                ModalRoute.of(context)?.settings.arguments as Restaurant)
      },
    );
  }
}

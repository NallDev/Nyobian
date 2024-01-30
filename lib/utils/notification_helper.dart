import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_app/data/model/search_restaurant_response.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotificationWithAttachment(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurant) async {
    var bigPicturePath = await _downloadAndSaveFile(
        'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
        'banner.jpg');

    var bigPictureAndroidStyle =
        BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1',
      'channel_restaurant',
      channelDescription: 'new restaurant information',
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: bigPictureAndroidStyle,
    );

    var notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
        1,
        restaurant.name,
        'Visit our restaurant in ${restaurant.city} with restaurant rating ${restaurant.rating}',
        notificationDetails);
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

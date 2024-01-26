import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import '../data/network/api_service.dart';
import '../main.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().searchRestaurant("");
    var randomInt = Random().nextInt(result.restaurants.length);
    var content = result.restaurants[randomInt];

    print("PLUGIN + $flutterLocalNotificationsPlugin");
    print("CONTENT + ${content.name}");
    await notificationHelper.showNotificationWithAttachment(
        flutterLocalNotificationsPlugin, content);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
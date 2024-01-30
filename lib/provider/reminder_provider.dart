import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/background_service.dart';
import '../utils/date_time_helper.dart';

class ReminderProvider extends ChangeNotifier {
  bool _isSubscriber = false;

  bool get isSubscriber => _isSubscriber;

  bool _hasPermission = false;

  bool get hasPermission => _hasPermission;

  ReminderProvider() {
    _getSubscriber();
  }

  Future<void> requestNotificationPermission() async {
    final PermissionStatus permissionStatus =
        await Permission.notification.status;
    if (!permissionStatus.isGranted) {
      final PermissionStatus requestedStatus =
          await Permission.notification.request();
      _hasPermission = requestedStatus.isGranted;
      notifyListeners();
    } else {
      _hasPermission = true;
      notifyListeners();
    }
  }

  _getSubscriber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSubscriber = prefs.getBool('subscriber') ?? false;
    scheduledInformation(_isSubscriber);
    notifyListeners();
  }

  setSubscriber(bool value) async {
    _isSubscriber = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('subscriber', value);
    _getSubscriber();
  }

  Future<void> scheduledInformation(bool value) async {
    if (value) {
      notifyListeners();
      await AndroidAlarmManager.periodic(
          const Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      notifyListeners();
      await AndroidAlarmManager.cancel(1);
    }
  }
}

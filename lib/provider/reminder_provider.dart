import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../utils/background_service.dart';
import '../utils/date_time_helper.dart';

class ReminderProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  bool _hasPermission = false;

  bool get hasPermission => _hasPermission;

  Future<void> requestNotificationPermission() async {
    final PermissionStatus permissionStatus = await Permission.notification.status;
    if (!permissionStatus.isGranted) {
      final PermissionStatus requestedStatus = await Permission.notification.request();
      _hasPermission = requestedStatus.isGranted;
      notifyListeners();
    } else {
      _hasPermission = true;
      notifyListeners();
    }
  }

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling News Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
          const Duration(minutes: 1), 1, BackgroundService.callback,
          startAt: DateTime.now());
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}

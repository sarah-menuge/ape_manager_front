import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  NotificationService() {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> sendNotification({
    required String title,
    required String body,
    required String channelId,
    required String channelName,
    String? groupKey,
  }) async {
    final _notificationId = DateTime.now().millisecondsSinceEpoch % 2000000000;
    final AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.max,
      groupKey: groupKey ?? (_notificationId).toString(),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );
    await _flutterLocalNotificationsPlugin.show(
      _notificationId,
      title,
      body,
      platformChannelSpecifics,
    );

    if (groupKey != null) {
      await _createSummaryNotification(channelId, channelName, groupKey);
    }
  }

  Future<void> _createSummaryNotification(
      String channelId, String channelName, String groupKey) async {
    final int summaryId = groupKey.hashCode;

    final AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      channelId,
      channelName,
      importance: Importance.low,
      groupKey: groupKey,
      setAsGroupSummary: true,
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidDetails);

    await _flutterLocalNotificationsPlugin.show(
      summaryId,
      'Grouped Notifications',
      'You have new messages in this group',
      platformChannelSpecifics,
    );
  }
}

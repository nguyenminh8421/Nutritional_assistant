import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> scheduleDailyNotifications() async {
    scheduleDailyNotification(
      id: 0,
      title: 'Chào buổi sáng',
      body: 'Bạn đã ăn gì chưa, để mình gợi ý nhé!',
      hour: 7,
      minute: 0,
    );

    scheduleDailyNotification(
      id: 1,
      title: 'Chào buổi trưa',
      body: 'Chúc bạn buổi trưa vui vẻ, hôm nay bạn ăn món gì vậy?',
      hour: 11,
      minute: 0,
    );

    scheduleDailyNotification(
      id: 2,
      title: 'Chào buổi tối',
      body: 'Chúc bạn buổi tối vui vẻ, nhớ nhập thông tin nhé',
      hour: 19,
      minute: 0,
    );

    scheduleDailyNotification(
      id: 3,
      title: 'Chúc ngủ ngon',
      body: 'Chúc bạn ngủ ngon và có giấc mơ đẹp!',
      hour: 22,
      minute: 0,
    );
  }

  static Future<void> scheduleDailyNotification({required int id, required String title, required String body, required int hour, required int minute}) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _nextInstanceOfTime(hour, minute),
      const NotificationDetails(
        android: AndroidNotificationDetails('daily notification channel id', 'daily notification channel name',),
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}

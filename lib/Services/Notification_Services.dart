// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
//
// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   final AndroidInitializationSettings androidInitializationSettings =
//   const AndroidInitializationSettings("ic_launcher");
//   androidIntializeNotification()async  {
//     InitializationSettings initializationSettings = InitializationSettings(
//         android: androidInitializationSettings,
//         iOS: null,
//         macOS: null,
//         linux: null);
//   await  flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
//
//   sendNotification() async {
//     AndroidNotificationDetails androidNotificationDetails =
//     const AndroidNotificationDetails("channelId", "channelName",
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true);
//     NotificationDetails notificationDetails =
//     NotificationDetails(android: androidNotificationDetails);
//
//     await flutterLocalNotificationsPlugin.show(
//         0, "title", "bod", notificationDetails);
//   }
//
//   sendSheduleNotification(shedudelTime) async {
//     ;
//     AndroidNotificationDetails androidNotificationDetails =
//     const AndroidNotificationDetails("channelId", "channelName",
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true);
//     NotificationDetails notificationDetails =
//     NotificationDetails(android: androidNotificationDetails);
//
//     await   flutterLocalNotificationsPlugin
//         .zonedSchedule(0, "title", "body",
//         tz.TZDateTime.from(shedudelTime,tz.UTC), notificationDetails,
//         uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//         androidAllowWhileIdle: true);
//     // .show(
//     // 0, "title", "body", notificationDetails);
//   }
//   cancelNotification(){
//     flutterLocalNotificationsPlugin.cancel(0);
//   }
// }
//
//
//




import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;


class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings androidInitializationSettings =
  const AndroidInitializationSettings("ic_launcher.png");
  androidIntializeNotification() {
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: null,
        macOS: null,
        linux: null);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  sendNotification(title, body) async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails("channelId", "channelName",
        // channelAction: AndroidNotificationChannelAction.update,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
    );
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
        0, title, body, notificationDetails);
  }

  sendSheduleNotification(id,shedudelTime, title, body) async {
    ;
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails("channelId", "channelName",
        // ongoing: true,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,);
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.from(shedudelTime, tz.UTC), notificationDetails,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      // matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
    // .show(
    // 0, "title", "body", notificationDetails);
  }

  cancelNotification() {
    flutterLocalNotificationsPlugin.cancel(0);
  }
}

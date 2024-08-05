import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotifications{
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future init() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true
    );

    // get the device fcm token
    final token = await _firebaseMessaging.getToken();
    print("device token: $token");
  }

  static Future localNotificationsInit() async{
    const initilizationSettingsAndroid = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    final initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );

    final initializationSettingsLinux = LinuxInitializationSettings(
      defaultActionName: 'Open notification'
    );

    final initializationSettings = InitializationSettings(
      android: initilizationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      linux: initializationSettingsLinux
    );

    // request notification permissions for android 13 or above
    _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
      .requestNotificationsPermission();

    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: onNotificationTap
    );

  }

  static void onNotificationTap(NotificationResponse notificationResponse){

  }
}
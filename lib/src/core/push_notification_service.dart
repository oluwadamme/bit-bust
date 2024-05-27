import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static String? _token;

  static Future<void> deleteFCMToken() async {
    await _fcm.deleteToken();
  }

  static Future<void> registerNotification() async {
    NotificationSettings settings =
        await _fcm.requestPermission(alert: true, badge: true, provisional: false, sound: true, criticalAlert: true);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Helpers.logc('User granted permission');
      var token = await _fcm.getToken();
      setToken(token!);

      // Subscribe to topics
      await topicSubscriber();
    } else {
      Helpers.logc('User declined or has not accepted permission');
    }
  }

  static String? get token => _token;

  static void setToken(String token) {
    Helpers.logc("::: PUSH NOTIFICATION TOKEN ::: $token");
    _token = token;
  }

  static Future<void> topicSubscriber() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      Helpers.logc('notification received : ${message.notification?.title}');
      Helpers.logc('notification received : ${message.notification?.body}');
      Helpers.logc('notification data : ${message.toMap()}');

      bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
      if (!isAllowed) {
        isAllowed = await AwesomeNotifications().requestPermissionToSendNotifications(channelKey: 'basic_channel');
      }
      if (!isAllowed) return;
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: channelUniqueId(),
          channelKey: 'basic_channel',
          title: message.notification?.title,
          body: message.notification?.body,
          payload: Map.from(message.data),
          criticalAlert: true,
          wakeUpScreen: true,
          category: NotificationCategory.Call,
        ),
      );
    });
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      isAllowed = await AwesomeNotifications().requestPermissionToSendNotifications(channelKey: 'basic_channel');
    }
    if (!isAllowed) return;
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: channelUniqueId(),
        channelKey: 'basic_channel',
        title: message.notification?.title,
        body: message.notification?.body,
        payload: Map.from(message.data),
        criticalAlert: true,
        wakeUpScreen: true,
        category: NotificationCategory.Call,
      ),
    );
  }

  static Future<void> initializeLocalNotifications() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_logo',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Basic notifications for BitBust',
          defaultColor: AppColors.grey900,
          importance: NotificationImportance.High,
          playSound: true,
          enableLights: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
          channelShowBadge: true,
          enableVibration: true,
          defaultPrivacy: NotificationPrivacy.Public,
          onlyAlertOnce: false,
        ),
      ],
      debug: kDebugMode,
    );
  }
}

int channelUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(1);
}

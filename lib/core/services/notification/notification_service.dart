import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_example_notification_project/common/enums/screens.dart';
import 'package:flutter_example_notification_project/screens/first_screen/first_screen.dart';
import 'package:flutter_example_notification_project/screens/second_screen/second_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

// ignore: slash_for_doc_comments
/**
 * [registerNotificationListeners] NotificationListener ın init edilmesi ve gerekli ayarların yapılması için
 * gereken method
 * [messageHandler] notification ile gelen data da, belirtilen kullanıcı rolüne göre ekrana yönlendirir.
 * [requestPermission] -> IOS tarafında izin kontrolleri
 */

class NotificationService {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late FirebaseMessaging messaging;

  NotificationService() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    messaging = FirebaseMessaging.instance;
    initAsyncServices();
  }

  void initAsyncServices() async {
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      await registerNotificationListeners();
      await requestPermission();
    });
    messaging.getToken().then((value) {
      print('FCM DEVICE TOKEN ---->>' + value.toString());
    });
  }

  requestPermission() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        //Uygulama ön planda açıkken, bildirimler gösterilmez.
        await messaging.setForegroundNotificationPresentationOptions(
          alert: false,
          badge: false,
          sound: false,
        );
      }
    }
  }

  registerNotificationListeners() async {
    // ignore: prefer_const_constructors
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    IOSInitializationSettings iOSSettings = const IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    InitializationSettings initSetttings =
        InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: (message) async {
      //OnSelect Durumları için kullanılacak method
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print('Foreground --> mesaj alındı! ' + event.notification!.body!);
      Timer.run(() => Get.snackbar('NOTIFICATION', event.notification!.body!));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      messageHandler(message!);
    });
  }

  void messageHandler(RemoteMessage message) {
    final type = message.data['type'];
    if (type == describeEnum(Screens.FIRST)) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Get.to(() => FirstScreen(
              message: message,
            ));
      });
    } else if (type == describeEnum(Screens.SECOND)) {
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Get.to(() => SecondScreen(
              message: message,
            ));
      });
    }
  }
}

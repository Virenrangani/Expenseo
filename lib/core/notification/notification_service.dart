import 'dart:io';

import 'package:dio/dio.dart';
import 'package:expenseo/core/storage/shared_pref/shared_pref_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'expenseo_high_importance_channel',
    'High Importance Notifications',
    description:
        'Used for important transaction alerts, split payments, and reminders.',
    importance: Importance.max,
  );

  Future<void> initialize() async {
    await _requestPermissions();

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const darwinSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: darwinSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    _listenForegroundMessages();
  }

  Future<void> _requestPermissions() async {
    final settings = await _fcm.requestPermission();
    debugPrint('FCM Authorization status: ${settings.authorizationStatus}');
  }

  void _listenForegroundMessages() {
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel.id,
              _channel.name,
              channelDescription: _channel.description,
              importance: Importance.max,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: message.data.toString(),
        );
      }
    });
  }

  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification clicked with payload: ${response.payload}');
    // Deep-link routing can be injected here
  }

  Future<String?> getDeviceToken() async {
    try {
      if (Platform.isIOS) {
        final apnsToken = await _fcm.getAPNSToken();
        if (apnsToken == null) {
          await Future<void>.delayed(const Duration(seconds: 2));
        }
      }
      return await _fcm.getToken();
    } catch (e) {
      debugPrint('Error fetching FCM token: $e');
      return null;
    }
  }

  Future<void> registerTokenOnServer(String token) async {
    try {
      final dio = GetIt.I<Dio>();
      final deviceType = Platform.isAndroid ? 'android' : 'ios';
      await dio.post<Map<String, dynamic>>(
        '/api/users/fcm-token',
        data: {'fcmToken': token, 'deviceType': deviceType},
      );

      // persist locally
      await SharedPrefService.saveFcmToken(token);
    } catch (e) {
      debugPrint('Failed to register FCM token on server: $e');
    }
  }

  Future<void> removeTokenFromServer(String token) async {
    try {
      final dio = GetIt.I<Dio>();
      await dio.delete<Map<String, dynamic>>(
        '/api/users/fcm-token',
        data: {'fcmToken': token},
      );
      await SharedPrefService.saveFcmToken(null);
    } catch (e) {
      debugPrint('Failed to remove FCM token from server: $e');
    }
  }

  void listenTokenRefresh(
    Future<void> Function(String newToken) onTokenRefresh,
  ) {
    _fcm.onTokenRefresh.listen((newToken) async {
      debugPrint('FCM token refreshed by Google: $newToken');
      await onTokenRefresh(newToken);
    });
  }
}

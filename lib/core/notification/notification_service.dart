import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:expenseo/core/storage/shared_pref/shared_pref_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

import '../../features/split/domain/entity/group_entity.dart';
import '../../features/split/domain/use_case/split_use_case.dart';
import '../../features/split/presentation/cubit/split_cubit.dart';
import '../../features/split/presentation/page/group_details_page.dart';
import '../../features/split/presentation/page/split_expense.dart';
import '../../main.dart';
import '../utils/get_device.dart';

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

    const androidSettings = AndroidInitializationSettings('ic_notification');
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

    FirebaseMessaging.onMessageOpenedApp.listen(_onRemoteMessageTapped);
    final initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _onRemoteMessageTapped(initialMessage);
      });
    }

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
              icon: 'ic_notification',
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: jsonEncode(message.data),
        );
      }
    });
  }

  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification clicked with payload: ${response.payload}');
    if (response.payload == null || response.payload!.isEmpty) return;

    try {
      final decoded = jsonDecode(response.payload!);
      if (decoded is Map) {
        _handleNotificationData(Map<String, dynamic>.from(decoded));
      } else {
        debugPrint(
          'Notification payload is not a JSON object: ${decoded.runtimeType}',
        );
      }
    } catch (e) {
      debugPrint('Failed to parse notification payload: $e');
    }
  }

  void _onRemoteMessageTapped(RemoteMessage message) {
    debugPrint('onMessageOpenedApp: ${message.data}');
    _handleNotificationData(message.data);
  }

  Future<void> _handleNotificationData(Map<String, dynamic> data) async {
    try {
      final type = data['type']?.toString();
      if (type == 'group_expense') {
        final groupId = data['groupId']?.toString();
        if (groupId == null || groupId.isEmpty) return;

        for (var i = 0; i < 10; i++) {
          if (appNavigatorKey.currentState != null) break;
          await Future<void>.delayed(const Duration(milliseconds: 200));
        }

        try {
          final useCase = GetIt.I<SplitUseCase>();
          final groups = await useCase.getGroups();
          GroupEntity? group;
          for (final g in groups) {
            if (g.id == groupId) {
              group = g;
              break;
            }
          }

          if (group == null) {
            debugPrint('Group $groupId not found');
            appNavigatorKey.currentState?.push(
              MaterialPageRoute<void>(builder: (_) => const SplitExpense()),
            );
            return;
          }

          final cubit = GetIt.I<SplitCubit>();
          await cubit.loadGroupDetail(group);

          appNavigatorKey.currentState?.push(
            MaterialPageRoute<void>(
              builder: (_) {
                return BlocProvider.value(
                  value: cubit,
                  child: GroupDetailsPage(group: group!),
                );
              },
            ),
          );
        } catch (e) {
          debugPrint('Failed to navigate to group: $e');
          appNavigatorKey.currentState?.push(
            MaterialPageRoute<void>(builder: (_) => const SplitExpense()),
          );
        }
      }
    } catch (e) {
      debugPrint('Error handling notification data: $e');
    }
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
      await dio.post<Map<String, dynamic>>(
        '/users/fcm-token',
        data: {'fcmToken': token, 'deviceType': getDeviceType()},
      );

      await SharedPrefService.saveFcmToken(token);
    } catch (e) {
      debugPrint('Failed to register FCM token on server: $e');
    }
  }

  Future<void> removeTokenFromServer(String token) async {
    try {
      final dio = GetIt.I<Dio>();
      await dio.delete<Map<String, dynamic>>(
        '/users/fcm-token',
        data: {'fcmToken': token},
      );
      await SharedPrefService.saveFcmToken(null);
    } catch (e) {
      debugPrint('Failed to remove FCM token from server: $e');
    }
  }

  Future<bool> sendNotificationToUserIds(
    List<String> userIds, {
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final dio = GetIt.I<Dio>();
      final response = await dio.post<Map<String, dynamic>>(
        '/notifications/send',
        data: {
          'userIds': userIds,
          'title': title,
          'body': body,
          'data': data ?? {},
        },
      );

      debugPrint(
        'Notification API response: ${response.statusCode} ${response.data}',
      );
      return response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300;
    } on DioException catch (e) {
      debugPrint(
        'Failed to send notification via server: ${e.response?.data ?? e.message}',
      );
      return false;
    } catch (e) {
      debugPrint('Unexpected error sending notification: $e');
      return false;
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

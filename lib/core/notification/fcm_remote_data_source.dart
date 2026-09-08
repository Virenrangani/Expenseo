import 'dart:io';

import 'package:dio/dio.dart';

abstract class FcmRemoteDataSource {
  Future<void> syncFcmToken({required String token});
  Future<void> deleteFcmToken({required String token});
}

class FcmRemoteDataSourceImpl implements FcmRemoteDataSource {
  final Dio dio;

  FcmRemoteDataSourceImpl(this.dio);

  @override
  Future<void> syncFcmToken({required String token}) async {
    try {
      await dio.post<void>(
        '/users/fcm-token',
        data: {
          'fcmToken': token,
          'deviceType': Platform.isAndroid ? 'ANDROID' : 'IOS',
        },
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['message'] ?? 'Failed to register push token',
      );
    }
  }

  @override
  Future<void> deleteFcmToken({required String token}) async {
    try {
      await dio.delete<void>('/users/fcm-token', data: {'fcmToken': token});
    } catch (_) {}
  }
}

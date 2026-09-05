import 'package:dio/dio.dart';

class RefreshTokenResponse {
  final String accessToken;
  final String refreshToken;

  const RefreshTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}

class AuthApi {
  final Dio dio;

  AuthApi(this.dio);

  Future<RefreshTokenResponse> refreshToken(String refreshToken) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/auth/refresh', // Added /auth prefix
      data: {'refreshToken': refreshToken},
      options: Options(headers: {'Authorization': null}),
    );

    return RefreshTokenResponse.fromJson(response.data!);
  }
}

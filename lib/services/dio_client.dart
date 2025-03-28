import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../utils/secure_storage.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://cash-cue.onrender.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  DioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? accessToken = await SecureStorage.getAccessToken();

        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          log('Access token expired, trying to refresh...');

          String? newAccessToken = await _refreshToken();

          if (newAccessToken != null) {
            final opts = error.requestOptions;
            opts.headers['Authorization'] = 'Bearer $newAccessToken';

            try {
              final response = await _dio.fetch(opts);
              return handler.resolve(response);
            } catch (e) {
              return handler.reject(error);
            }
          }
        }
        return handler.reject(error);
      },
    ));
  }

  Dio get dio => _dio;

  Future<String?> _refreshToken() async {
    String? refreshToken = await SecureStorage.getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final response = await _dio.post('/user/refresh-token', 
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        String newAccessToken = response.data['accessToken'];
        await SecureStorage.updateAccessToken(newAccessToken);
        return newAccessToken;
      } else {
        await SecureStorage.deleteTokens();
        return null;
      }
    } catch (e) {
      await SecureStorage.deleteTokens();
      return null;
    }
  }
}

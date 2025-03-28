import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String accessToken, String refreshToken) async {
    await _storage.write(key: "accessToken", value: accessToken);
    await _storage.write(key: "refreshToken", value: refreshToken);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: "accessToken");
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: "refreshToken");
  }

  static Future<void> updateAccessToken(String accessToken) async {
    await _storage.write(key: "accessToken", value: accessToken);
  }

  static Future<void> deleteTokens() async {
    await _storage.delete(key: "accessToken");
    await _storage.delete(key: "refreshToken");
  }
}

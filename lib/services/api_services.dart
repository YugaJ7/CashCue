import 'dart:developer';

import 'package:dio/dio.dart';

import 'dio_client.dart';

class ApiService {
  final DioClient _dioClient = DioClient();

  Future<Response?> post(String endpoint, Map<String, dynamic> data) async {
    try {
      Response response = await _dioClient.dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      log("API Request failed: $e");
      return null;
    }
  }

  Future<Response?> get(String endpoint) async {
    try {
      Response response = await _dioClient.dio.get(endpoint);
      return response;
    } catch (e) {
      log("API Request failed: $e");
      return null;
    }
  }
}


// Usage example:
// final apiService = ApiService();

// // POST request
// apiService.post('/user/profile', {"name": "John Doe"});

// // GET request
// apiService.get('/transactions');

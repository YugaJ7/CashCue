import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> registerUser({required String name, required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('https://cash-cue.onrender.com/user/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return {'success': true, 'data': jsonDecode(response.body)};
    } else {
      final error = jsonDecode(response.body);
      return {'success': false, 'message': error['message'] ?? 'An error occurred'};
    }
  }
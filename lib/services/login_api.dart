import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

  Future<Map<String, dynamic>> loginUser(
      {required String email, required String password}) async {
        
    final Uri url = Uri.parse('https://cash-cue.onrender.com/user/signin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    print('API Status: ${response.statusCode}');
    print('API Response: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', data['token']);
      final username = await SharedPreferences.getInstance();
      await username.setString('username', data['data']['name']);
      print(username);
      List<String> groupList = [];
      if (data['data']['groups'] != null && data['data']['groups'] is List) {
        groupList = List<String>.from(data['data']['groups']);
      }
      else {
        groupList=["0"];
      }
      print('Group id = $groupList');
      final groupid = await SharedPreferences.getInstance();
      await groupid.setStringList('groups', groupList);
      print('Group id = $groupid');
      if (data['success'] == true) {
        return {'success': true, 'data': 'Login Done'};
      } else {
        return {'success': true, 'data': jsonDecode(response.body)?? 'Login failed'};
      }
    } else {
      return {'success': false, 'message': jsonDecode(response.body)};
    }
  }
// Future<Map<String, dynamic>> loginUser({
//   required String email,
//   required String password,
// }) async {
//   try {
//     final response = await http.post(
//       Uri.parse('https://cash-cue.onrender.com/user/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     // If response is not JSON, return error
//     if (!response.headers['content-type']!.contains('application/json')) {
//       return {'success': false, 'message': 'Unexpected server response'};
//     }

//     if (response.statusCode == 200) {
//       return {'success': true, 'data': jsonDecode(response.body)};
//     } else {
//       final error = jsonDecode(response.body);
//       return {'success': false, 'message': error['message'] ?? 'An error occurred'};
//     }
//   } catch (e) {
//     return {'success': false, 'message': 'Failed to connect to server: $e'};
//   }
// }



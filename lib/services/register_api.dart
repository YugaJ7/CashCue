import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> registerUser({required String name, required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('https://cash-cue.onrender.com/user/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final x = jsonDecode(response.body);
      if(x['status']=='FAILED'){
        return {'success': false, 'data': jsonDecode(response.body)};
      }
      else{
        return {'success': true, 'data': jsonDecode(response.body)};
      }
    } else {
      final error = jsonDecode(response.body);
      return {'success': false, 'message': error['message'] ?? 'An error occurred'};
    }
  }
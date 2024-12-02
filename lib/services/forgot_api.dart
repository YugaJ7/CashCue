import 'dart:convert';
import 'package:http/http.dart' as http;

  Future<Map<String, dynamic>> forgotPassword(
      {required String email}) async {
        
    final Uri url = Uri.parse('https://cash-cue.onrender.com/user/forgot-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
      }),
    );
    print('API Response: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        return {'success': true, 'data': 'Email send successful'};
      } else {
        return {'success': true, 'data': jsonDecode(response.body)?? 'Email sending failed'};
      }
    } else {
      return {'success': false, 'message': 'An error occurred. Please try again.'};
    }
  }
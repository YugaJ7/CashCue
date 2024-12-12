import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UsernameApi {
  static const String apiUrl = 'https://cash-cue.onrender.com/homepage/name';

  static Future<String> fetchUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json" 
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);
      return data['name']; 
    } else {
      throw Exception('Failed to load username');
    }
  }
}


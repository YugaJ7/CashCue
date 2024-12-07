import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SummaryService {
  Future<Map<String, dynamic>> fetchSummary() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final url = Uri.parse('https://cash-cue.onrender.com/homepage/home');
    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );
    print("Resonse====");
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      print("DATTA");
      print(data);
      return data;
    } else {
      throw Exception('Failed to load summary data');
    }
  }
}

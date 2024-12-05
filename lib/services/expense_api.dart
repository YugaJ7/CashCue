import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  final String apiUrl = "https://cash-cue.onrender.com/transaction/list";

  Future<List<Map<String, dynamic>>> fetchExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');

    if (token == null) throw Exception("Authentication token is missing");

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      if (decodedData is Map<String, dynamic> && decodedData['transactions'] != null) {
        print(decodedData['transactions']);
        return List<Map<String, dynamic>>.from(decodedData['transactions']);
      } else {
        throw Exception('Unexpected response format: Missing "transactions" key');
      }
    } else {
      throw Exception('Failed to load transactions. Status code: ${response.statusCode}');
    }
  }
}

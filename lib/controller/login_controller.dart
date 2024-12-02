import 'package:flutter/material.dart';
import '../services/login_api.dart';

Future<void> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    final result = await loginUser(email: email, password: password);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['data']['message'] ?? 'Login successful')),
      );
      //Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }


// Future<void> login({required BuildContext context, required String email,required String password}) async {
//   final Uri url = Uri.parse('https://cash-cue.onrender.com/user/signin');
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'email': email,
//         'password': password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       if (data['success'] == true) {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login successful')));
//         //Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data['message'] ?? 'Login failed')));
//       }
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An error occurred. Please try again.')));
//     }
// }
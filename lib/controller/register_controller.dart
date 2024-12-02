import 'package:flutter/material.dart';
import '../services/register_api.dart';

Future<void> register({required BuildContext context,required String name,required String email,required String password}) async {
  final result = await registerUser(name: name, email: email, password: password);
  
  if (result['success']) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['data']['message']))
     );
    Navigator.pushReplacementNamed(context, '/login');
  } 
  else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result['data']['message']))
      );
    }
  }

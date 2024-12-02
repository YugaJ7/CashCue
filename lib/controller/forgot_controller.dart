import 'package:flutter/material.dart';

import '../services/forgot_api.dart';

Future<void> forgot(
      {required BuildContext context,
      required String email,
      }) async {
    final result = await forgotPassword(email: email);

    if (result['success']) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['data']['message'] ?? 'Login successful')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }
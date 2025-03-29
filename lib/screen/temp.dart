import 'package:cashcue/services/auth_service.dart';
import 'package:flutter/material.dart';

class TempScreen extends StatelessWidget {
  TempScreen({super.key});
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Its Working'),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: _authService.logout, 
              child: const Text('LogOut'))
          ],
        ),
      ),
    );
  }
}
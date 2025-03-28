import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class LoginController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var obscureText = true.obs; 
  var isLoading = false.obs; 

  final AuthService _authService = AuthService();

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void login() async {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your password',
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }else {
      isLoading.value = true; 
      await _authService.login(emailController.text, passwordController.text); 
      isLoading.value = false; 
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
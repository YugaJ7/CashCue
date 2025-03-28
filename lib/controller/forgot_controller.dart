import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';


class ForgotController extends GetxController {
  var emailController = TextEditingController();
  final RxBool isLoading = false.obs;
  final AuthService _authService = AuthService();

  void confirmEmail() async{
    String email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      isLoading.value = true;
    await _authService.forgotpassword(email: email);
    isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
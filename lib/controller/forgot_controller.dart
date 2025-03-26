import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotController extends GetxController {
  var emailController = TextEditingController();

  void confirmEmail() {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your email',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // Perform email confirmation logic API call
      Get.toNamed('/otpverify'); 
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
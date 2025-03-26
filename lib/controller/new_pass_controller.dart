import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPassController extends GetxController {
  var passwordController = TextEditingController();
  var obscureText = true.obs;

  var hasMinLength = false.obs;
  var hasUpperLower = false.obs;
  var hasNumberOrSymbol = false.obs;
  var isButtonEnabled = false.obs;

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void validatePassword(String password) {
    hasMinLength.value = password.length >= 8;
    hasUpperLower.value = RegExp(r'(?=.*[a-z])(?=.*[A-Z])').hasMatch(password);
    hasNumberOrSymbol.value = RegExp(r'(?=.*\d)|(?=.*[!@#\$%^&*(),.?":{}|<>])').hasMatch(password);
    updateButtonState();
  }

  void updateButtonState() {
    isButtonEnabled.value = hasMinLength.value &&
        hasUpperLower.value &&
        hasNumberOrSymbol.value;
  }

  void confirmPassword() {
    if (passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a new password',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (!hasMinLength.value || !hasUpperLower.value || !hasNumberOrSymbol.value) {
      String errorMessage = 'Password must meet the following requirements:\n';
      if (!hasMinLength.value) errorMessage += '- At least 8 characters\n';
      if (!hasUpperLower.value) errorMessage += '- Both uppercase and lowercase letters\n';
      if (!hasNumberOrSymbol.value) errorMessage += '- At least one number or symbol';
      Get.snackbar(
        'Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      // Perform password confirmation logic API call
      Get.offAllNamed('/confirm'); 
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
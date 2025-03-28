import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';
import '../utils/validator.dart';

class NewPassController extends GetxController {
  var passwordController = TextEditingController();
  var obscureText = true.obs;
  final RxBool isLoading = false.obs;
  var hasMinLength = false.obs;
  var hasUpperLower = false.obs;
  var hasNumberOrSymbol = false.obs;
  var isButtonEnabled = false.obs;

final AuthService _authService = AuthService();

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }

  void validatePassword(String password) {
    hasMinLength.value = PasswordValidator.hasMinLength(password);
    hasUpperLower.value = PasswordValidator.hasUpperLower(password);
    hasNumberOrSymbol.value = PasswordValidator.hasNumberOrSymbol(password);
    updateButtonState();
  }

  void updateButtonState() {
    isButtonEnabled.value = hasMinLength.value &&
        hasUpperLower.value &&
        hasNumberOrSymbol.value;
  }

  void confirmPassword() async {
    String email = Get.arguments['email'];
    String newPassword = passwordController.text.trim();

    if (newPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a new password',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      String? validationError = PasswordValidator.validatePassword(newPassword);
      if (validationError != null) {
        Get.snackbar(
          'Error',
          validationError,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        isLoading.value = true;
        await _authService.passwordChange(email: email, newPassword: newPassword);
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}

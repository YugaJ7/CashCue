import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../utils/validator.dart';

class RegisterController extends GetxController {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var obscureText = true.obs;

  var hasMinLength = false.obs;
  var hasUpperLower = false.obs;
  var hasNumberOrSymbol = false.obs;
  var isChecked = false.obs;
  var isButtonEnabled = false.obs;
  var isLoading = false.obs; 

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
        hasNumberOrSymbol.value &&
        isChecked.value;
  }

  void signUp() async {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all fields',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      String? validationError = PasswordValidator.validatePassword(passwordController.text);
      if (validationError != null) {
        Get.snackbar(
          'Error',
          validationError,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (!isChecked.value) {
        Get.snackbar(
          'Error',
          'Please accept the privacy policy and terms of use',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        isLoading.value = true; 
        await _authService.registerUser(
          name: fullNameController.text,
          email: emailController.text,
          password: passwordController.text,
        );
        isLoading.value = false; 
      }
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

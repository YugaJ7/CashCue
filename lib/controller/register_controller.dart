import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    } else if (!isChecked.value) {
      Get.snackbar(
        'Error',
        'Please accept the privacy policy and term of use',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      isLoading.value = true; 
      // API CALL
      await Future.delayed(Duration(seconds: 2));
      Get.snackbar(
        'Verification Link Sent',
        'Please verify your email address before logining',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      isLoading.value = false; 
      Get.offNamed('/login'); 
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
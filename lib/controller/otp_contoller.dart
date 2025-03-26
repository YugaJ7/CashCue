import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final RxBool isLoading = false.obs;

  // Function to verify OTP
  void verifyOtp() {
    String otp = otpController.text.trim();

    if (otp.length < 4) {
      Get.snackbar(
        "Invalid OTP",
        "Please enter a 4-digit OTP",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    isLoading.value = true;

    // Simulate API Call
    Future.delayed(Duration(seconds: 2), () {
      isLoading.value = false;

      if (otp == "1234") { // Example OTP for testing
        Get.snackbar(
          "Success",
          "OTP Verified Successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        // Navigate to the next screen
        Get.offNamed('/newpassword');
      } else {
        Get.snackbar(
          "Error",
          "Invalid OTP. Please try again!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }
}

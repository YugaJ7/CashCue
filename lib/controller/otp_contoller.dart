import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/auth_service.dart';

class OtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final RxBool isLoading = false.obs;

  final AuthService _authService = AuthService();
  
  void verifyOtp(String previousRoute, String email) async {
    String otp = otpController.text.trim();

    if (otp.length < 6) {
      Get.snackbar(
        "Invalid OTP",
        "Please enter a valid OTP",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    log(otp);
    isLoading.value = true;
    await _authService.otpVerification(previousRoute: previousRoute, email: email, otp: otp);
    isLoading.value = false;
  }

  void resendOtp(String previousRoute, String email) async {
    await _authService.otpResend(previousRoute: previousRoute, email: email);
  }
}

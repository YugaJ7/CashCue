import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/secure_storage.dart';
import 'dio_client.dart';

class AuthService {
  final DioClient _dioClient = DioClient();
  //Login 
  Future login(String email, String password) async {
    try {
      dio.Response response = await _dioClient.dio.post(
        '/user/signin',
        data: {
          "email": email,
          "password": password,
        },
      );
      //log(response.data);
      if (response.statusCode == 200 && response.data['status'] == 'SUCCESS') {
        await SecureStorage.saveToken(
          response.data['accessToken'],
          response.data['refreshToken'],
        );
        Get.offAllNamed('/temp');
        return true;
      }
      else{
        Get.snackbar(
          'Login failed',
          response.data['message'] ?? 'Invalid credentials',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }

  //Register
  Future registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      dio.Response response = await _dioClient.dio.post(
        '/user/signup',
        data: {
          "name": name.trim(),
          "email": email.trim(),
          "password": password.trim(),
        },
      );
      //log(response.data);
      if (response.statusCode == 200 && response.data['status'] == 'SUCCESS') {
        Get.toNamed('/otpverify', arguments: {'previousRoute': '/register', 'email': email.trim()});

        return true;
      } else {
        Get.snackbar(
          'Signup failed',
          response.data['message'] ?? '',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }
  }
  //Logout
  Future<void> logout() async {
    await SecureStorage.deleteTokens();
  }

  //OTP Verification
  Future otpVerification({
    required String previousRoute,
    required String email,
    required String otp,
  }) async {
    try {
      String endpoint="";
      Map<String, dynamic> requestData = {"email": email, "otp": otp};

      if (previousRoute == '/register') {
        endpoint = "/user/verify-otp";
      } else if (previousRoute == '/forgotpassword') {
        endpoint = "/user/verify-otp1";
      }

      dio.Response response =
          await _dioClient.dio.post(endpoint, data: requestData);

      if (response.data["status"] == "SUCCESS") {
        if (previousRoute == '/register') {
          // Store tokens securely
          await SecureStorage.saveToken(
            response.data['accessToken'],
            response.data['refreshToken'],
          );

          Get.snackbar(
            "Success",
            "Signup successful!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );

          Get.offNamed('/home'); // Navigate to Home screen
        } else {
          Get.offNamed('/resetpassword',
              arguments: {"email": email}); // Navigate to Reset Password screen
        }
      } else {
        Get.snackbar(
          "Error",
          response.data["message"] ?? "OTP verification failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(), 
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //Resend OTP
  Future otpResend({required String previousRoute, required String email}) async {
    try {
      String endpoint="";
      Map<String, dynamic> requestData = {"email": email};
      if (previousRoute == '/register') {
        endpoint = "/user/resend-otp-signup";
      } else if (previousRoute == '/forgotpassword') {
        endpoint = "/user/resend-otp-forgot-password";
      }

      dio.Response response =
          await _dioClient.dio.post(endpoint, data: requestData);

      if (response.data["status"] == "SUCCESS") {
          Get.snackbar(
            "Success",
            "OTP resend successfully!",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
      } else {
        Get.snackbar(
          "Error",
          response.data["message"] ?? "OTP verification failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(), 
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  //Password change
  Future passwordChange({required String email, required String newPassword}) async {
    try {
          dio.Response response = await _dioClient.dio.post(
            '/user/reset-password',
            data: {
              "email": email,
              "newPassword": newPassword,
            },
          );

          if (response.data['status'] == 'SUCCESS') {
            Get.offAllNamed('/confirm');
          } else {
            //log(response.data);
            Get.snackbar(
              'Error',
              response.data['message'] ?? 'Password reset failed',
              snackPosition: SnackPosition.BOTTOM,
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        } catch (e) {
          Get.snackbar(
            'Error',
            'Something went wrong. Please try again later.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
  }

  //Forgot Password
  Future forgotpassword({required String email}) async {
    try {
      dio.Response response = await _dioClient.dio.post(
        '/user/forgot-password',
        data: {
          "email": email,
        },
      );

      if (response.data['status'] == 'SUCCESS') {
        Get.toNamed('/otpverify', arguments: {'previousRoute': '/forgotpassword', 'email': email});
      } else {
        Get.snackbar(
          'Error',
          response.data['message'] ?? 'Password reset failed',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

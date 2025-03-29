import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';

import '../utils/secure_storage.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> logoAnimation;
  late Animation<double> textOpacity;
  var showText = false.obs;
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    logoAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.1),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));

    Future.delayed(const Duration(seconds: 2), () {
      showText.value = true;
      controller.forward();
    });

    Future.delayed(const Duration(seconds: 5), checkLoginStatus);
  }

  void checkLoginStatus() async {
    String? token = await SecureStorage.getAccessToken();

    if (token != null) {
      bool isAuthenticated = await _authenticateUser();
      if (isAuthenticated) {
        Get.offAllNamed('/temp'); 
      } else {
        SystemNavigator.pop(); 
      }
    } else {
      Get.offAllNamed('/onboarding'); 
    }
  }

  Future<bool> _authenticateUser() async {
    if (_isAuthenticating) return false; 

    _isAuthenticating = true;
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Unlock your CashCue',
        options: const AuthenticationOptions(
          biometricOnly: false, 
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      _isAuthenticating = false;
      return authenticated;
    } catch (e) {
      //print("Error during authentication: $e");
      _isAuthenticating = false;
      return false;
    }
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

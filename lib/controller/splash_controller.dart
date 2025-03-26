import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SplashController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> logoAnimation;
  late Animation<double> textOpacity;
  var showText = false.obs;

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
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

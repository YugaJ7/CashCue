import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../components/style/button.dart';
import '../components/style/text.dart';
import '../components/widgets/buttons/elevated_button.dart';
import '../constants/app_colors.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashController controller = Get.find();

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: controller.logoAnimation,
                    child: SvgPicture.asset(
                      'assets/images/logos/splash_logo.svg',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  Obx(() => controller.showText.value
                      ? FadeTransition(
                          opacity: controller.textOpacity,
                          child: Column(
                            children: [
                              Text('Welcome to',
                                  style: TextStyles.withColor(
                                          textcolor: Colors.black)
                                      .headline1),
                              Text('CashChue',
                                  style: TextStyles.withColor(
                                          textcolor: Colors.black)
                                      .headline1),
                              const SizedBox(height: 20),
                              Text('Just take a look and take action!',
                                  style: TextStyles.withColor(
                                          textcolor: AppColors.coldgrey)
                                      .bodytext1),
                            ],
                          ),
                        )
                      : const SizedBox.shrink()),
                ],
              ),
            ),
          ),
          Obx(() => controller.showText.value
              ? FadeTransition(
                  opacity: controller.textOpacity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 40.0, left: 24.0, right: 24.0),
                    child: Center(
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: CustomElevatedButton(
                          text: 'Let\'s Start',
                          buttonStyle: ButtonStyles.withColor(color: AppColors.lightpink).filledprimarybutton,
                          textStyle: TextStyles.withColor(textcolor: Colors.white).buttontext2,
                          onPressed: () {
                            Get.offNamed('/login_register');
                          },
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}

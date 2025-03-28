import 'package:cashcue/components/style/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../components/style/button.dart';
import '../components/widgets/buttons/smalloutlinedbutton.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.find();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        var data = controller.onboardingPages[controller.currentIndex.value];
        return Stack(
          children: [
            SizedBox(
                height: height,
                width: width,
                child: SvgPicture.asset(data.image, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: SvgPicture.asset(
                                "assets/images/logos/splash_logo.svg")),
                        SizedBox(height: height * 0.1),
                        Text(
                          data.title,
                          style: TextStyles.withColor(textcolor: Colors.black)
                              .onboardinghead,
                        ),
                        const SizedBox(height: 10),
                        Text(data.description,
                            style: TextStyles.withColor(
                                    textcolor:
                                        const Color.fromRGBO(106, 104, 104, 1))
                                .onboardingtitle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Skip Button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24),
                child: SmallOutlinedButton(
                  text: 'Skip Intro',
                  onPressed: () => Get.offAllNamed('/login_register'),
                  textStyle:
                      TextStyles.withColor(textcolor: Colors.black).buttontext2,
                  buttonStyle: ButtonStyles.withColor(color: Colors.black)
                      .outlinedsmallprimary,
                ),
              ),
            ),
            //Next Button
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 18, height * 0.05),
                child: ElevatedButton(
                  onPressed: controller.nextPage,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(15),
                    backgroundColor: Colors.black,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

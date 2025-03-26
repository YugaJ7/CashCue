import 'package:cashcue/components/style/button.dart';
import 'package:cashcue/components/style/text.dart';
import 'package:cashcue/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../components/widgets/buttons/elevated_button.dart';

class LoginRegisterScreen extends StatelessWidget {
  const LoginRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
            height: height,
            width:  width,
            child: Image.asset(
              "assets/images/background/welcome.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.32), 
                SvgPicture.asset("assets/images/logos/splash_logo.svg"),
                SizedBox(height: height * 0.15), 
                SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Login', 
                    onPressed: () => Get.toNamed('/login'), 
                    textStyle: TextStyles.withColor(textcolor: Colors.white).buttontext2,
                    buttonStyle: ButtonStyles.withColor(color: AppColors.lightpink).filledprimarybutton,
                    ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: 'Register', 
                    onPressed: () => Get.toNamed('/register'), 
                    textStyle: TextStyles.withColor(textcolor: AppColors.lightpink).buttontext2,
                    buttonStyle: ButtonStyles.withColor(color: AppColors.lightpink).outlinedprimarybutton,
                  ),
                )
              ],
            ),
          )
      ],
    );
  }
}
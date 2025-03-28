import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../components/style/button.dart';
import '../components/style/text.dart';
import '../components/widgets/buttons/elevated_button.dart';
import '../components/widgets/buttons/social_button.dart';
import '../components/widgets/textfield/text_field.dart';
import '../constants/app_colors.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.find();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.05),
              Row(
                children: [
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: SvgPicture.asset('assets/images/icons/back_icon.svg', width: 41,height: 41),
                  ),
                ],
              ),
              SizedBox(height: height * 0.036),
              Text(
                "Welcome back! Glad to see you, Again",
                style: TextStyles.withColor(textcolor: AppColors.black).headline1,
                maxLines: 2,
              ),
              SizedBox(height: height * 0.04),
          
              //Email Text Field
              AuthTextField(
                label: 'E-mail',
                hint: 'Enter your e-mail here',
                icon: 'assets/images/icons/email.png',
                controller: controller.emailController,
                obscureText: false.obs,
              ),
              const SizedBox(height: 20),
          
              //Password Text Field
              AuthTextField(
                label: 'Password',
                hint: 'Enter your password',
                icon: 'assets/images/icons/locked.png',
                controller: controller.passwordController,
                obscureText: controller.obscureText,
                toggleObscureText: controller.toggleObscureText,
              ),
              
              //Forgot Password Text Button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.toNamed('/forgotpassword'),
                  child: Text(
                    'Forgot your password?',
                    style: TextStyles.withColor(textcolor: AppColors.darkgrey).buttontext2,
                  ),
                ),
              ),
              SizedBox(height: height * 0.2),
          
              //Login Elevated Button
              Obx(() => SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text:
                          controller.isLoading.value ? 'Logging in...' : 'Log in',
                      buttonStyle: ButtonStyles.withColor(color: AppColors.lightpink).filledprimarybutton,
                      textStyle: TextStyles.withColor(textcolor: Colors.white).buttontext2,
                      onPressed: controller.isLoading.value? null:controller.login,
                    ),
                  )),
              const SizedBox(height: 20),
          
              Row(
                children: [
                  const Expanded(
                      child: Divider(color: AppColors.lightgrey, thickness: 1.5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Or Login with",
                      style: TextStyles.withColor(textcolor: AppColors.darkgrey).bodytext2,
                    ),
                  ),
                  const Expanded(
                      child: Divider(color: AppColors.lightgrey, thickness: 1.5)),
                ],
              ),
              const SizedBox(height: 20),
          
              //Social Login Buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialButton(assetPath: 'assets/images/logos/facebook.png'),
                  SizedBox(width: 50),
                  SocialButton(assetPath: 'assets/images/logos/google.png'),
                  SizedBox(width: 50),
                  SocialButton(assetPath: 'assets/images/logos/apple.png'),
                ],
              ),
              const SizedBox(height: 20),
          
              // //Sign Up Option
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       "Don't have an account yet? ",
              //       style: TextStyles.withColor(textcolor: AppColors.black).bodytext3,
              //     ),
              //     TextButton(
              //       onPressed: () => Get.offNamed('/signup'),
              //       child: Text(
              //         "Sign up",
              //         style: TextStyles.withColor(textcolor: AppColors.darkpurple).bodytext3,
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 45),
            ],
          ),
        ),
      ),
    );
  }
}

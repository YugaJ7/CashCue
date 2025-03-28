import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../components/style/button.dart';
import '../components/style/text.dart';
import '../components/widgets/buttons/elevated_button.dart';
import '../components/widgets/buttons/social_button.dart';
import '../components/widgets/textfield/text_field.dart';
import '../constants/app_colors.dart';
import '../controller/register_controller.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController controller = Get.find();

  RegisterScreen({super.key});

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
              SizedBox(height: height * 0.03),
              Text(
                "Welcome! to CashCue, Glad to see you!",
                style: TextStyles.withColor(textcolor: AppColors.black).headline1,
                maxLines: 2,
              ),
              SizedBox(height: height * 0.04),
          
              //Full Name Text Field
              AuthTextField(
                label: "Full Name",
                hint: "Enter your name",
                icon: 'assets/images/icons/profile.png',
                controller: controller.fullNameController,
                obscureText: false.obs,
              ),
              const SizedBox(height: 20),
              //Email Text Field
              AuthTextField(
                label: 'E-mail',
                hint: 'Enter your e-mail here',
                icon: 'assets/images/icons/email.png',
                controller: controller.emailController,
                obscureText: false.obs,
              ),
              const SizedBox(height: 20),
          
              //Password Field
              Text(
                "Password",
                style:
                    TextStyles.withColor(textcolor: AppColors.grey).bodytext1,
              ),
              const SizedBox(height: 4),
              Obx(() => TextField(
                    cursorColor: AppColors.darkgrey,
                    style: TextStyles.withColor(textcolor: AppColors.grey).bodytext1,
                    controller: controller.passwordController,
                    obscureText: controller.obscureText.value,
                    onChanged: (value) => controller.validatePassword(value),
                    decoration: InputDecoration(
                      hintText: "Place the password here",
                      hintStyle:
                          TextStyles.withColor(textcolor: AppColors.grey).bodytext1,
                      prefixIcon: Image.asset(
                        'assets/images/icons/locked.png',
                        scale: 3,
                      ),
                      suffixIcon: IconButton(
                        color: AppColors.grey,
                        icon: Icon(controller.obscureText.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined),
                        onPressed: controller.toggleObscureText,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFDADADA)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xFFDADADA)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      fillColor: const Color(0xFFF7F8F9),
                      filled: true,
                    ),
                  )),
              const SizedBox(height: 10),
          
              _buildValidationRow(
                  "At least 8 characters", controller.hasMinLength),
              const SizedBox(height: 8),
              _buildValidationRow(
                "Both uppercase and lowercase characters",
                controller.hasUpperLower,
              ),
              const SizedBox(height: 8),
              _buildValidationRow(
                "At least one number or symbol",
                controller.hasNumberOrSymbol,
              ),
              const SizedBox(height: 20),
              const Divider(color: AppColors.lightgrey, thickness: 1.5),
              const SizedBox(height: 20),
              Row(
                children: [
                  Obx(() => Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: const BorderSide(color: AppColors.darkgrey),
                        checkColor: AppColors.black,
                        value: controller.isChecked.value,
                        onChanged: (value) {
                          controller.isChecked.value = value ?? false;
                          controller.updateButtonState();
                        },
                      )),
                  Expanded(
                    child: Text(
                      "By continuing you accept our Privacy Policy and Term of Use",
                      style: TextStyles.withColor(textcolor: AppColors.darkgrey).bodytext3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
          
              //Register Elevated Button
              Obx(() => SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text:controller.isLoading.value
                          ? 'Signing up...'
                          : 'Sign Up',
                      buttonStyle: ButtonStyles.withColor(color: AppColors.lightpink).filledprimarybutton,
                      textStyle: TextStyles.withColor(textcolor: Colors.white).buttontext2,
                      onPressed: controller.isLoading.value? null:controller.signUp,
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
              //       "Already have an account? ",
              //       style: TextStyles.withColor(textcolor: AppColors.black).bodytext3,
              //     ),
              //     TextButton(
              //       onPressed: () => Get.offNamed('/register'),
              //       style: TextButton.styleFrom(
              //         padding: EdgeInsets.zero,
              //         minimumSize: Size.zero,
              //         tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              //         foregroundColor: Colors.transparent,
              //         backgroundColor: Colors.transparent,
              //       ),
              //       child: Text(
              //         "Login",
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
  Widget _buildValidationRow(String text, RxBool isValid) {
    return Obx(() => Row(
          children: [
            Icon(isValid.value ? Icons.check : Icons.close,
                color: isValid.value ? Colors.green : Colors.red),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style:
                    TextStyles.withColor(textcolor: AppColors.darkgrey).bodytext3,
                maxLines: 2,
              ),
            ),
          ],
        ));
  }
}

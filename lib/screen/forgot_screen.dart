import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../components/style/button.dart';
import '../components/style/text.dart';
import '../components/widgets/buttons/elevated_button.dart';
import '../components/widgets/textfield/text_field.dart';
import '../constants/app_colors.dart';
import '../controller/forgot_controller.dart';

class ForgotScreen extends StatelessWidget {
  final ForgotController controller = Get.find();

  ForgotScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                "Forgot Password?",
                style: TextStyles.withColor(textcolor: AppColors.black).headline1,
                maxLines: 2,
              ),
              SizedBox(height: height * 0.02),
            Text(
              'Don\'t worry! It occurs. Please enter the email address linked with your account.',
              style:
                  TextStyles.withColor(textcolor: AppColors.grey).bodytext3,
              maxLines: 2,
            ),
            SizedBox(height: height * 0.05),
            //Email Text Field
            AuthTextField(
              label: 'E-mail',
              hint: 'Enter your e-mail here',
              icon: 'assets/images/icons/email.png',
              controller: controller.emailController,
              obscureText: false.obs,
            ),
            SizedBox(height: height * 0.036),
            //Confirm Elevated Button
            Obx(() => SizedBox(
              height: 60,
              width: double.infinity,
              child: CustomElevatedButton(
                text: controller.isLoading.value?'Sending Code' :'Send Code',
                buttonStyle: ButtonStyles.withColor(color: AppColors.lightpink).filledprimarybutton,
                textStyle: TextStyles.withColor(textcolor: Colors.white).buttontext2,
                onPressed: controller.isLoading.value? null: controller.confirmEmail,
              ),
            ))
          ],
        ),
      ),
    );
  }
}

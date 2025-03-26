import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../components/style/button.dart';
import '../../components/widgets/buttons/elevated_button.dart';
import '../components/style/text.dart';
import '../constants/app_colors.dart';
import '../controller/new_pass_controller.dart';

class NewPassScreen extends StatelessWidget {
  final NewPassController controller = Get.put(NewPassController());

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
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset('assets/images/icons/back_icon.svg',
                      width: 41, height: 41),
                ),
              ],
            ),
            SizedBox(height: height * 0.036),
            Text(
              "Create new Password?",
              style: TextStyles.withColor(textcolor: AppColors.black).headline1,
              maxLines: 2,
            ),
            SizedBox(height: height * 0.02),
            Text(
              'Your new password must be unique from those previously used.',
              style: TextStyles.withColor(textcolor: AppColors.grey).bodytext3,
              maxLines: 2,
            ),
            SizedBox(height: height * 0.05),
            Text(
              "Password",
              style:
                  TextStyles.withColor(textcolor: AppColors.darkgrey).bodytext2,
            ),
            SizedBox(height: 4),
            Obx(() => TextField(
                  cursorColor: AppColors.darkgrey,
                  style:
                      TextStyles.withColor(textcolor: AppColors.grey).bodytext1,
                  controller: controller.passwordController,
                  obscureText: controller.obscureText.value,
                  onChanged: (value) => controller.validatePassword(value),
                  decoration: InputDecoration(
                    hintText: "Place the password here",
                    hintStyle: TextStyles.withColor(textcolor: AppColors.grey)
                        .bodytext1,
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
                      borderSide: BorderSide(color: Color(0xFFDADADA)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFDADADA)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fillColor: Color(0xFFF7F8F9),
                    filled: true,
                  ),
                )),
            SizedBox(height: 10),

            _buildValidationRow(
                "At least 8 characters", controller.hasMinLength),
            SizedBox(height: 8),
            _buildValidationRow(
              "Both uppercase and lowercase characters",
              controller.hasUpperLower,
            ),
            SizedBox(height: 8),
            _buildValidationRow(
              "At least one number or symbol",
              controller.hasNumberOrSymbol,
            ),
            SizedBox(height: height * 0.036),

            //Confirm Button
            SizedBox(
              height: 60,
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Confirm',
                buttonStyle: ButtonStyles.withColor(color: AppColors.lightpink)
                    .filledprimarybutton,
                textStyle:
                    TextStyles.withColor(textcolor: Colors.white).buttontext2,
                onPressed: controller.confirmPassword,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationRow(String text, RxBool isValid) {
    return Obx(() => Row(
          children: [
            Icon(isValid.value ? Icons.check : Icons.close,
                color: isValid.value ? Colors.green : Colors.red),
            SizedBox(width: 8),
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

class ConfirmScreen extends StatelessWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/icons/tick.svg'),
            SizedBox(height: height * 0.05),
            Center(
              child: Text(
                "Password Changed",
                style:
                    TextStyles.withColor(textcolor: AppColors.black).headline1,
                maxLines: 2,
              ),
            ),
            SizedBox(height: height * 0.02),
            Center(
              child: Text(
                'Your password has been changed successfully.',
                style:
                    TextStyles.withColor(textcolor: AppColors.grey).bodytext3,
                maxLines: 2,
              ),
            ),
            SizedBox(height: height * 0.03),

            //Confirm Elevated Button
            SizedBox(
              height: 60,
              width: double.infinity,
              child: CustomElevatedButton(
                text: 'Back to Login',
                buttonStyle: ButtonStyles.withColor(color: AppColors.lightpink)
                    .filledprimarybutton,
                textStyle:
                    TextStyles.withColor(textcolor: Colors.white).buttontext2,
                onPressed: () => Get.offNamed('/login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

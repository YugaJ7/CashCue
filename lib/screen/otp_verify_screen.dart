import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../components/style/text.dart';
import '../../constants/app_colors.dart';
import '../components/style/button.dart';
import '../controller/otp_contoller.dart';

class OtpVerificationScreen extends StatelessWidget {
  final OtpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(width);
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
            // Back Button
            Row(
              children: [
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    'assets/images/icons/back_icon.svg',
                    width: 41,
                    height: 41,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.036),
            Text(
              "OTP Verification",
              style: TextStyles.withColor(textcolor: AppColors.black).headline1,
            ),
            SizedBox(height: height * 0.02),
            Text(
              "Enter the verification code we just sent on your email address.",
              style: TextStyles.withColor(textcolor: AppColors.grey).bodytext3,
              maxLines: 2,
            ),
            SizedBox(height: height * 0.05),

            // OTP Fields
            Center(
              child: Pinput(
                length: 4,
                controller: controller.otpController,
                keyboardType: TextInputType.number,
                defaultPinTheme: PinTheme(
                  height: height*0.067,
                  width: width*0.18,
                  textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(247, 248, 249, 1),
                    border: Border.all(color: AppColors.lightgrey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                submittedPinTheme: PinTheme(
                  height: height*0.07,
                  width: width*0.18,
                  textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    border: Border.all(color: Color.fromRGBO(53, 194, 193, 1)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                showCursor: false,
                onCompleted: (value) {
                  print("Entered OTP: $value");
                },
              ),
            ),

            SizedBox(height: height * 0.036),

            // Verify Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value ? null : controller.verifyOtp,
                    style: ButtonStyles.withColor(color: AppColors.lightpink).filledprimarybutton,
                    child: controller.isLoading.value
                        ? Text(
                            "Verifying...",
                            style: TextStyles.withColor(textcolor: Colors.white).buttontext2,
                          )
                        : Text(
                            "Verify",
                            style: TextStyles.withColor(textcolor: Colors.white).buttontext2,
                          ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

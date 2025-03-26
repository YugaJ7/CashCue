import 'package:cashcue/screen/login_register_screen.dart';
import 'package:cashcue/screen/otp_verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/auth_bindings.dart';
import 'screen/forgot_screen.dart';
import 'screen/login_screen.dart';
import 'screen/new_passwor_screen.dart';
import 'screen/register.dart';
import 'screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen(), binding: SplashBinding()),
        // GetPage(name: '/onboarding', page: () => OnboardingScreen(), binding: OnboardingBinding()),
        GetPage(name: '/login_register', page: () => LoginRegisterScreen(),),
        GetPage(name: '/register', page: () => RegisterScreen(), binding: RegisterBinding()),
        GetPage(name: '/login', page: () => LoginScreen(), binding: LoginBinding()),
        GetPage(name: '/forgotpassword', page: () => ForgotScreen(), binding: ForgotBinding()),
        GetPage(name: '/otpverify', page: () =>  OtpVerificationScreen(), binding: OtpBinding()),
        GetPage(name: '/newpassword', page: () => NewPassScreen(), binding: NewPassBinding()),
        GetPage(name: '/confirm', page: () => const ConfirmScreen()),
        // GetPage(name: '/navbar', page: () => Navbar()),
      ],
    );
  }
}
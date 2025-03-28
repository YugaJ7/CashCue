import 'package:cashcue/screen/login_register_screen.dart';
import 'package:cashcue/screen/otp_verify_screen.dart';
import 'package:cashcue/screen/temp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bindings/auth_bindings.dart';
import 'screen/forgot_screen.dart';
import 'screen/login_screen.dart';
import 'screen/new_passwor_screen.dart';
import 'screen/onboarding_screen.dart';
import 'screen/register_screen.dart';
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
        GetPage(name: '/onboarding', page: () => const OnboardingScreen(), binding: OnboardingBinding()),
        GetPage(name: '/login_register', page: () => const LoginRegisterScreen()),
        GetPage(name: '/register', page: () => RegisterScreen(), binding: RegisterBinding()),
        GetPage(name: '/login', page: () => LoginScreen(), binding: LoginBinding()),
        GetPage(name: '/forgotpassword', page: () => ForgotScreen(), binding: ForgotBinding()),
        GetPage(name: '/otpverify', page: () =>  OtpVerificationScreen(), binding: OtpBinding()),
        GetPage(name: '/resetpassword', page: () => NewPassScreen(), binding: NewPassBinding()),
        GetPage(name: '/confirm', page: () => const ConfirmScreen()),
        GetPage(name: '/temp', page: () => const TempScreen()),
        // GetPage(name: '/navbar', page: () => Navbar()),
      ],
    );
  }
}
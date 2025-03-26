import 'package:cashcue/controller/new_pass_controller.dart';
import 'package:cashcue/controller/register_controller.dart';
import 'package:get/get.dart';

import '../controller/forgot_controller.dart';
import '../controller/login_controller.dart';
import '../controller/otp_contoller.dart';
import '../controller/splash_controller.dart';

// splash_binding.dart
class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}

// login_binding.dart
class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

// signup_binding.dart
class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
  }
}

// forgot_binding.dart
class ForgotBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotController());
  }
}

// forgot_binding.dart
class NewPassBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewPassController());
  }
}

//otp verification binding
class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}

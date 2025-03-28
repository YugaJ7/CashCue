import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentIndex = 0.obs;

  // List of Onboarding Pages
  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      image: 'assets/images/background/onboarding1.svg',
      title: 'Real-time \nExpense tracker',
      description: "Keep track of your expenses instantly with seamless updates across all your financial accounts. Stay in control of your spending anytime, anywhere!",
    ),
    OnboardingModel(
      image: 'assets/images/background/onboarding2.svg',
      title: 'Capture Expenses \nwith Ease',
      description: 'Scan receipts with OCR technology to automatically log your transactions—quick, simple, and error-free!',
    ),
    OnboardingModel(
      image: 'assets/images/background/onboarding3.svg',
      title: 'Designed for \nGroups',
      description: 'Split expenses with friends or groups hassle-free. Whether it\'s trips, events, or dinner bills—CashCue has you covered',
    ),
  ];

  void nextPage() {
    if (currentIndex.value < onboardingPages.length - 1) {
      currentIndex.value++;
    } else {
      Get.offAllNamed('/login_register'); 
    }
  }
}
class OnboardingModel {
  final String image;
  final String title;
  final String description;

  OnboardingModel({required this.image, required this.title, required this.description});
}

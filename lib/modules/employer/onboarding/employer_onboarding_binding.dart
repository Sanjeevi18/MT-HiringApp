import 'package:get/get.dart';
import 'employer_onboarding_controller.dart';

class EmployerOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployerOnboardingController>(() => EmployerOnboardingController());
  }
}
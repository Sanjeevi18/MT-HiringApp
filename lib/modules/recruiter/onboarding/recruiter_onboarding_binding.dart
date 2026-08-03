import 'package:get/get.dart';
import 'recruiter_onboarding_controller.dart';

class RecruiterOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecruiterOnboardingController>(
        () => RecruiterOnboardingController());
  }
}

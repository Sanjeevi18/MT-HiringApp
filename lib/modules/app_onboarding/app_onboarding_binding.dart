import 'package:get/get.dart';
import 'app_onboarding_controller.dart';

class AppOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppOnboardingController>(() => AppOnboardingController());
  }
}

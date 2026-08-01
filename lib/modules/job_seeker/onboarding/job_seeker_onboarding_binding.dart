import 'package:get/get.dart';
import 'job_seeker_onboarding_controller.dart';

class JobSeekerOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobSeekerOnboardingController>(
        () => JobSeekerOnboardingController());
  }
}

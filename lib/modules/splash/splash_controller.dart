import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  final loadingText = 'Initializing System...'.obs;

  @override
  void onReady() {
    super.onReady();
    _initializeApp();
  }

  void _initializeApp() async {
    await Future.delayed(const Duration(seconds: 1));
    loadingText.value = 'Checking Session...';

    await Future.delayed(const Duration(seconds: 1));

    // UPDATED: Now navigates to the App Walkthrough screens
    Get.offAllNamed(AppRoutes.APP_ONBOARDING);
  }
}

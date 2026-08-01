import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class AppOnboardingController extends GetxController {
  final PageController pageController = PageController();
  final currentPage = 0.obs;

  // Walkthrough Slide Data
  final List<Map<String, dynamic>> onboardingPages = [
    {
      'icon': Icons.work_outline_rounded,
      'title': 'Find the Perfect Blue Collar Job',
      'description':
          'Connect with verified employers instantly. Build your profile and get hired faster than ever.',
    },
    {
      'icon': Icons.auto_awesome_rounded,
      'title': 'AI-Powered Matching',
      'description':
          'Our smart AI engine matches your skills, location, and experience with the best available opportunities.',
    },
    {
      'icon': Icons.verified_user_outlined,
      'title': 'Verified & Secure Platform',
      'description':
          '100% verified employers and job seekers. A safe ecosystem for recruitment and career growth.',
    },
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < onboardingPages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      finishOnboarding();
    }
  }

  void finishOnboarding() {
    // Navigate to Auth Gateway and clear the backstack
    Get.offAllNamed(AppRoutes.AUTH_LOGIN);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

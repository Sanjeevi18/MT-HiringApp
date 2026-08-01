import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiring_app/modules/employer/onboarding/employer_onboarding_binding.dart';
import 'package:hiring_app/modules/employer/onboarding/employer_onboarding_view.dart';
import 'app_routes.dart';

// Splash
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';

// App Onboarding
import '../modules/app_onboarding/app_onboarding_binding.dart';
import '../modules/app_onboarding/app_onboarding_view.dart';

// Auth
import '../modules/auth/auth_binding.dart';
import '../modules/auth/auth_view.dart';

// Job Seeker
import '../modules/job_seeker/onboarding/job_seeker_onboarding_binding.dart';
import '../modules/job_seeker/onboarding/job_seeker_onboarding_view.dart';

class AppPages {
  static final routes = [
    // 1. Splash Screen
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),

    // 2. App Onboarding (Walkthrough)
    GetPage(
      name: AppRoutes.APP_ONBOARDING,
      page: () => const AppOnboardingView(),
      binding: AppOnboardingBinding(),
    ),

    // 3. Authentication Gateway
    GetPage(
      name: AppRoutes.AUTH_LOGIN,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),

    // 4. Job Seeker Onboarding Flow
    GetPage(
      name: AppRoutes.JOB_SEEKER_ONBOARDING,
      page: () => const JobSeekerOnboardingView(),
      binding: JobSeekerOnboardingBinding(),
    ),

    // ---------------------------------------------------------
    // PLACEHOLDERS FOR UNBUILT ROUTES TO PREVENT CRASHES DURING TESTING
    // ---------------------------------------------------------

    GetPage(
      name: AppRoutes.JOB_SEEKER_DASHBOARD,
      page: () => const Scaffold(
        body: Center(child: Text('Job Seeker Dashboard Under Construction')),
      ),
    ),

    GetPage(
      name: AppRoutes.EMPLOYER_DASHBOARD,
      page: () => const Scaffold(
        body: Center(child: Text('Employer Dashboard Under Construction')),
      ),
    ),

    GetPage(
      name: AppRoutes.EMPLOYER_ONBOARDING,
      page: () => const EmployerOnboardingView(),
      binding: EmployerOnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.ADMIN_DASHBOARD,
      page: () => const Scaffold(
        body: Center(child: Text('Admin Dashboard Under Construction')),
      ),
    ),
  ];
}

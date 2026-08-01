import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

enum AuthStep { phone, otp, role }

class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  // State management
  final isLoading = false.obs;
  final currentStep = AuthStep.phone.obs;
  final selectedRole = 'Job Seeker'.obs;

  // Dummy OTP for testing
  final String _dummyOtp = '1234';

  final List<String> availableRoles = [
    'Job Seeker',
    'Employer',
    'Recruiter',
  ];

  // --- Step 1: Request OTP ---
  void requestOtp() async {
    if (phoneController.text.isEmpty || phoneController.text.length < 10) {
      Get.snackbar(
          'Input Required', 'Please enter a valid 10-digit phone number',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Mock Network Call
    isLoading.value = false;

    currentStep.value = AuthStep.otp;

    Get.snackbar(
      'OTP Sent',
      'For testing, please use OTP: $_dummyOtp',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
    );
  }

  // --- Step 2: Verify OTP ---
  void verifyOtp() async {
    if (otpController.text != _dummyOtp) {
      Get.snackbar(
          'Verification Failed', 'Invalid OTP. Please enter $_dummyOtp',
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // Mock Verification Call
    isLoading.value = false;

    // Move to Role Selection
    currentStep.value = AuthStep.role;
  }

  // Helper: Go back to edit phone
  void resetToPhoneInput() {
    currentStep.value = AuthStep.phone;
    otpController.clear();
  }

  // --- Step 3: Complete Login & Route to Specific Onboarding ---
  void completeLogin() {
    // Check which role was selected and route to the corresponding onboarding module
    if (selectedRole.value == 'Employer') {
      Get.offAllNamed(AppRoutes.EMPLOYER_ONBOARDING);
    } else if (selectedRole.value == 'Job Seeker') {
      Get.offAllNamed(AppRoutes.JOB_SEEKER_ONBOARDING,
          arguments: {'role': 'Job Seeker'});
    } else {
      // Temporary fallback for Recruiter until that module is built
      Get.offAllNamed(AppRoutes.ADMIN_DASHBOARD);
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    otpController.dispose();
    super.onClose();
  }
}

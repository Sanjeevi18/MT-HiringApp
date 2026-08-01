import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class JobSeekerOnboardingController extends GetxController {
  final currentStep = 0.obs;
  late final String userRole;
  late final List<String> steps;

  final isSubmitting = false.obs;

  // ==========================================
  // JOB SEEKER FORM CONTROLLERS & STATES
  // ==========================================

  // Step 1: Basic & Contact
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final emailController = TextEditingController();
  final selectedGender = 'Male'.obs;

  // Step 2: Address
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();

  // Step 3: Skills
  final customSkillController = TextEditingController();
  final selectedSkills = <String>[].obs;
  final suggestedSkills = [
    'Electrician',
    'Plumber',
    'Driver',
    'Welder',
    'Carpenter',
    'Machine Operator',
    'Helper',
    'Flutter',
    'Java',
    'AWS'
  ];
  final languageController = TextEditingController();

  // Step 4: Experience
  final isFresher = false.obs;
  final companyController = TextEditingController();
  final roleController = TextEditingController();
  final expYearsController = TextEditingController();
  final currentSalaryController = TextEditingController();

  // Step 5: Preferences & Additional Details
  final prefRoleController = TextEditingController();
  final prefIndustryController = TextEditingController();
  final prefLocationController = TextEditingController();
  final expectedSalaryController = TextEditingController();

  final shiftPreference = 'Day'.obs;
  final employmentType = 'Full-time'.obs;
  final willingToRelocate = false.obs;
  final noticePeriod = 'Immediate'.obs;

  // ==========================================
  // EMPLOYER & RECRUITER CONTROLLERS
  // ==========================================
  final companyNameController = TextEditingController();
  final industryController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    userRole = Get.arguments?['role'] ?? 'Job Seeker';
    _initializeSteps();
  }

  void _initializeSteps() {
    if (userRole == 'Job Seeker') {
      steps = [
        'Basic Details',
        'Address Info',
        'Skills',
        'Experience',
        'Preferences',
        'Upload Resumes'
      ];
    } else if (userRole == 'Employer') {
      steps = [
        'Company Profile',
        'Company Documents',
        'Subscription',
        'Payment'
      ];
    } else {
      steps = ['Professional Profile', 'Verification'];
    }
  }

  void toggleSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
  }

  void addCustomSkill() {
    if (customSkillController.text.isNotEmpty) {
      selectedSkills.add(customSkillController.text.trim());
      customSkillController.clear();
    }
  }

  void nextStep() {
    if (currentStep.value < steps.length - 1) {
      currentStep.value++;
    } else {
      _completeOnboarding();
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  Future<void> _completeOnboarding() async {
    isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isSubmitting.value = false;

    if (userRole == 'Employer') {
      Get.offAllNamed(AppRoutes.EMPLOYER_DASHBOARD);
    } else if (userRole == 'Job Seeker') {
      Get.snackbar('Profile Submitted', 'Calculating AI Profile Score...',
          backgroundColor: Colors.blueAccent, colorText: Colors.white);
      Get.offAllNamed(AppRoutes.JOB_SEEKER_DASHBOARD);
    } else {
      Get.offAllNamed(AppRoutes.ADMIN_DASHBOARD);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    dobController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    districtController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    customSkillController.dispose();
    languageController.dispose();
    companyController.dispose();
    roleController.dispose();
    expYearsController.dispose();
    currentSalaryController.dispose();
    prefRoleController.dispose();
    prefIndustryController.dispose();
    prefLocationController.dispose();
    expectedSalaryController.dispose();
    companyNameController.dispose();
    industryController.dispose();
    super.onClose();
  }
}

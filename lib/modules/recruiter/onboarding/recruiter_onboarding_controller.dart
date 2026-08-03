import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class RecruiterOnboardingController extends GetxController {
  final currentStep = 0.obs;
  final isSubmitting = false.obs;

  final steps = [
    'Contact Details',
    'Professional Details',
    'Company & Agency',
    'Specialization & Skills',
    'Verification Documents'
  ];

  // ==========================================
  // STEP 1: CONTACT DETAILS
  // ==========================================
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();

  // ==========================================
  // STEP 2: PROFESSIONAL DETAILS
  // ==========================================
  final recruiterIdController = TextEditingController();
  final employeeIdController = TextEditingController();
  final designationController = TextEditingController();
  final departmentController = TextEditingController();
  final expYearsController = TextEditingController();

  // ==========================================
  // STEP 3: COMPANY DETAILS
  // ==========================================
  final companyNameController = TextEditingController();
  final companyIdController = TextEditingController();
  final branchController = TextEditingController();
  final officeLocationController = TextEditingController();

  // ==========================================
  // STEP 4: SPECIALIZATIONS & SKILLS
  // ==========================================
  final selectedSpecializations = <String>[].obs;
  final availableSpecializations = [
    'IT Recruitment',
    'Manufacturing',
    'Healthcare',
    'Blue Collar',
    'Sales',
    'Banking',
    'Logistics'
  ];

  final selectedSkills = <String>[].obs;
  final availableSkills = [
    'Candidate Screening',
    'Interview Scheduling',
    'Talent Acquisition',
    'HR Operations',
    'Resume Screening',
    'ATS Management'
  ];

  void toggleSpecialization(String spec) {
    if (selectedSpecializations.contains(spec)) {
      selectedSpecializations.remove(spec);
    } else {
      selectedSpecializations.add(spec);
    }
  }

  void toggleSkill(String skill) {
    if (selectedSkills.contains(skill)) {
      selectedSkills.remove(skill);
    } else {
      selectedSkills.add(skill);
    }
  }

  // ==========================================
  // NAVIGATION LOGIC
  // ==========================================
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

  void _completeOnboarding() async {
    isSubmitting.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isSubmitting.value = false;

    Get.snackbar(
      'Profile Complete',
      'Recruiter profile submitted successfully!',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Route to Recruiter Dashboard
    Get.offAllNamed(AppRoutes
        .ADMIN_DASHBOARD); // Replace with RECRUITER_DASHBOARD route when ready
  }

  @override
  void onClose() {
    mobileController.dispose();
    emailController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    recruiterIdController.dispose();
    employeeIdController.dispose();
    designationController.dispose();
    departmentController.dispose();
    expYearsController.dispose();
    companyNameController.dispose();
    companyIdController.dispose();
    branchController.dispose();
    officeLocationController.dispose();
    super.onClose();
  }
}

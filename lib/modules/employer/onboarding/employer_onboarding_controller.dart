import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class EmployerOnboardingController extends GetxController {
  final currentStep = 0.obs;
  final isSubmitting = false.obs;

  final steps = [
    'Company Info',
    'Company Address',
    'Legal & Verification',
    'Subscription',
    'Payment'
  ];

  // ==========================================
  // STEP 1: COMPANY INFO
  // ==========================================
  final nameController = TextEditingController();
  final industryController = TextEditingController();
  final descController = TextEditingController();
  final websiteController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companySize = '1–10 Employees'.obs;

  final sizeOptions = [
    '1–10 Employees',
    '11–50 Employees',
    '51–200 Employees',
    '200+ Employees'
  ];

  // ==========================================
  // STEP 2: ADDRESS
  // ==========================================
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();

  // ==========================================
  // STEP 3: LEGAL DETAILS (Optional)
  // ==========================================
  final gstController = TextEditingController();
  final panController = TextEditingController();
  final cinController = TextEditingController();

  // ==========================================
  // STEP 4 & 5: SUBSCRIPTION & PAYMENT
  // ==========================================
  final selectedPlan = 'Premium'.obs;
  final paymentStatus = 'pending'.obs; // pending, processing, success

  final Map<String, Map<String, dynamic>> plans = {
    'Basic': {
      'price': '₹999',
      'duration': '/month',
      'features': ['5 Job Posts', 'Basic Candidate Access', 'Standard Support'],
    },
    'Standard': {
      'price': '₹2,499',
      'duration': '/month',
      'features': ['25 Job Posts', 'AI Candidate Matching', 'Priority Support'],
    },
    'Premium': {
      'price': '₹4,999',
      'duration': '/month',
      'features': [
        'Unlimited Jobs',
        'Full AI Features',
        'Dedicated Account Manager'
      ],
    }
  };

  void selectPlan(String plan) {
    selectedPlan.value = plan;
  }

  void processPayment() async {
    paymentStatus.value = 'processing';
    // Simulate Razorpay/Payment Gateway Delay
    await Future.delayed(const Duration(seconds: 3));
    paymentStatus.value = 'success';
  }

  void downloadInvoice() {
    Get.snackbar(
      'Invoice Downloaded',
      'The PDF invoice has been saved to your device.',
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(Icons.download_done, color: Colors.white),
    );
  }

  // ==========================================
  // NAVIGATION LOGIC
  // ==========================================
  void nextStep() {
    if (currentStep.value == 3) {
      // If moving from Subscription to Payment, auto-trigger payment processing
      currentStep.value++;
      processPayment();
    } else if (currentStep.value < steps.length - 1) {
      currentStep.value++;
    } else {
      _completeOnboarding();
    }
  }

  void previousStep() {
    if (currentStep.value > 0 && paymentStatus.value != 'success') {
      currentStep.value--;
    }
  }

  void _completeOnboarding() {
    Get.offAllNamed(AppRoutes.EMPLOYER_DASHBOARD);
  }

  @override
  void onClose() {
    nameController.dispose();
    industryController.dispose();
    descController.dispose();
    websiteController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    pinCodeController.dispose();
    gstController.dispose();
    panController.dispose();
    cinController.dispose();
    super.onClose();
  }
}

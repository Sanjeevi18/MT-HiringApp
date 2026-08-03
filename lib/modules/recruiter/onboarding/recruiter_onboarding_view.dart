import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'recruiter_onboarding_controller.dart';
import '../../../../shared/responsive_layout.dart';

class RecruiterOnboardingView extends GetView<RecruiterOnboardingController> {
  const RecruiterOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Obx(() => Text(
              'Step ${controller.currentStep.value + 1} of ${controller.steps.length}',
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
        leading: Obx(() {
          return controller.currentStep.value > 0
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.black87, size: 20),
                  onPressed: controller.previousStep,
                )
              : const SizedBox.shrink();
        }),
      ),
      body: SafeArea(
        child: Center(
          child: ResponsiveLayout(
            mobile: _buildFormContainer(context, isMobile: true),
            tablet: _buildFormContainer(context, isMobile: false),
            desktop: _buildFormContainer(context, isMobile: false),
          ),
        ),
      ),
    );
  }

  Widget _buildFormContainer(BuildContext context, {required bool isMobile}) {
    return Container(
      width: isMobile ? double.infinity : 650,
      margin: EdgeInsets.all(isMobile ? 0 : 24.0),
      padding: EdgeInsets.all(isMobile ? 24.0 : 40.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: isMobile ? BorderRadius.zero : BorderRadius.circular(24),
        boxShadow: isMobile
            ? []
            : [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 8))
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() => ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (controller.currentStep.value + 1) /
                      controller.steps.length,
                  backgroundColor: Colors.grey.withValues(alpha: 0.1),
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  minHeight: 8,
                ),
              )),
          const SizedBox(height: 32),
          Obx(() => Text(
                controller.steps[controller.currentStep.value],
                style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Colors.black87),
              )),
          const SizedBox(height: 24),
          Expanded(
            child: Obx(() => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: KeyedSubtree(
                    key: ValueKey<int>(controller.currentStep.value),
                    child: _renderCurrentStepContent(),
                  ),
                )),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 56,
            child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: controller.isSubmitting.value
                      ? null
                      : controller.nextStep,
                  child: controller.isSubmitting.value
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : Text(
                          controller.currentStep.value ==
                                  controller.steps.length - 1
                              ? 'Complete Setup'
                              : 'Continue',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _renderCurrentStepContent() {
    switch (controller.currentStep.value) {
      case 0:
        return _buildStep1Contact();
      case 1:
        return _buildStep2Professional();
      case 2:
        return _buildStep3Company();
      case 3:
        return _buildStep4SpecializationAndSkills();
      case 4:
        return _buildStep5Documents();
      default:
        return const SizedBox.shrink();
    }
  }

  // ==========================================
  // STEP VIEWS
  // ==========================================

  Widget _buildStep1Contact() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildTextField(
            controller.mobileController, 'Mobile Number', Icons.phone_outlined),
        const SizedBox(height: 16),
        _buildTextField(
            controller.emailController, 'Email Address', Icons.email_outlined),
        const SizedBox(height: 16),
        _buildTextField(controller.addressController, 'Current Address',
            Icons.home_outlined),
        const SizedBox(height: 16),
        _buildTextField(controller.cityController, 'City', Icons.location_city),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: _buildTextField(
                    controller.stateController, 'State', Icons.terrain)),
            const SizedBox(width: 16),
            Expanded(
                child: _buildTextField(controller.pinCodeController, 'PIN Code',
                    Icons.pin_drop_outlined)),
          ],
        )
      ],
    );
  }

  Widget _buildStep2Professional() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildTextField(controller.recruiterIdController,
            'Recruiter ID (Generated by Admin)', Icons.badge_outlined),
        const SizedBox(height: 16),
        _buildTextField(controller.employeeIdController, 'Employee ID',
            Icons.perm_identity),
        const SizedBox(height: 16),
        _buildTextField(controller.designationController,
            'Designation (e.g., Senior Recruiter)', Icons.work_outline),
        const SizedBox(height: 16),
        _buildTextField(
            controller.departmentController, 'Department', Icons.apartment),
        const SizedBox(height: 16),
        _buildTextField(controller.expYearsController,
            'Years of Experience (e.g., 5 Years)', Icons.access_time),
      ],
    );
  }

  Widget _buildStep3Company() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildTextField(controller.companyNameController, 'Company/Agency Name',
            Icons.business),
        const SizedBox(height: 16),
        _buildTextField(
            controller.companyIdController, 'Company ID', Icons.domain),
        const SizedBox(height: 16),
        _buildTextField(
            controller.branchController, 'Branch', Icons.account_tree_outlined),
        const SizedBox(height: 16),
        _buildTextField(controller.officeLocationController, 'Office Location',
            Icons.location_on_outlined),
      ],
    );
  }

  Widget _buildStep4SpecializationAndSkills() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const Text('Recruitment Specialization',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 12),
        Obx(() => Wrap(
              spacing: 10,
              runSpacing: 10,
              children: controller.availableSpecializations.map((spec) {
                final isSelected =
                    controller.selectedSpecializations.contains(spec);
                return FilterChip(
                  label: Text(spec),
                  selected: isSelected,
                  onSelected: (_) => controller.toggleSpecialization(spec),
                  selectedColor: Colors.blueAccent.withValues(alpha: 0.2),
                  checkmarkColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                );
              }).toList(),
            )),
        const Divider(height: 40),
        const Text('Recruitment Skills',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        const SizedBox(height: 12),
        Obx(() => Wrap(
              spacing: 10,
              runSpacing: 10,
              children: controller.availableSkills.map((skill) {
                final isSelected = controller.selectedSkills.contains(skill);
                return FilterChip(
                  label: Text(skill),
                  selected: isSelected,
                  onSelected: (_) => controller.toggleSkill(skill),
                  selectedColor: Colors.blueAccent.withValues(alpha: 0.2),
                  checkmarkColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                );
              }).toList(),
            )),
      ],
    );
  }

  Widget _buildStep5Documents() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildUploadPlaceholder('Upload Employee ID Card', Icons.badge),
        const SizedBox(height: 20),
        _buildUploadPlaceholder('Upload Government ID (Aadhaar / PAN)',
            Icons.verified_user_outlined),
        const SizedBox(height: 20),
        _buildUploadPlaceholder(
            'Upload Offer Letter (Optional)', Icons.description_outlined),
      ],
    );
  }

  // ==========================================
  // SHARED UI COMPONENTS
  // ==========================================

  Widget _buildTextField(
      TextEditingController textController, String label, IconData icon) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.3)),
        prefixIcon: Icon(icon, color: Colors.black.withValues(alpha: 0.4)),
        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.06),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5)),
      ),
    );
  }

  Widget _buildUploadPlaceholder(String label, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: Colors.blueAccent.withValues(alpha: 0.2),
            width: 2,
            style: BorderStyle.solid),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: Icon(icon, size: 32, color: Colors.blueAccent),
          ),
          const SizedBox(height: 12),
          Text(label,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent)),
        ],
      ),
    );
  }
}

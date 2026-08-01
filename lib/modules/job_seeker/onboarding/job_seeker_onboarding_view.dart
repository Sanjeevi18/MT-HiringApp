import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'job_seeker_onboarding_controller.dart';
import '../../../../shared/responsive_layout.dart';

class JobSeekerOnboardingView extends GetView<JobSeekerOnboardingController> {
  const JobSeekerOnboardingView({super.key});

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
                              ? 'Generate AI Profile Score'
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
    if (controller.userRole == 'Job Seeker') {
      switch (controller.currentStep.value) {
        case 0:
          return _buildJobSeekerStep1();
        case 1:
          return _buildJobSeekerStep2();
        case 2:
          return _buildJobSeekerStep3();
        case 3:
          return _buildJobSeekerStep4();
        case 4:
          return _buildJobSeekerStep5();
        case 5:
          return _buildJobSeekerStep6();
      }
    } else if (controller.userRole == 'Employer') {
      switch (controller.currentStep.value) {
        case 0:
          return _buildTextField(
              controller.companyNameController, 'Company Name', Icons.business);
      }
    }
    return const SizedBox.shrink();
  }

  Widget _buildJobSeekerStep1() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildUploadPlaceholder(
            'Upload Profile Photo', Icons.camera_alt_outlined),
        const SizedBox(height: 24),
        _buildTextField(
            controller.nameController, 'Full Name', Icons.person_outline),
        const SizedBox(height: 16),
        _buildTextField(controller.dobController, 'Date of Birth (YYYY-MM-DD)',
            Icons.calendar_today),
        const SizedBox(height: 16),
        _buildDropdown(controller.selectedGender, ['Male', 'Female', 'Other'],
            'Gender', Icons.wc),
        const SizedBox(height: 16),
        _buildTextField(
            controller.emailController, 'Email Address', Icons.email_outlined),
      ],
    );
  }

  Widget _buildJobSeekerStep2() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildTextField(controller.addressController, 'Current Address',
            Icons.home_outlined),
        const SizedBox(height: 16),
        _buildTextField(controller.cityController, 'City', Icons.location_city),
        const SizedBox(height: 16),
        _buildTextField(
            controller.districtController, 'District', Icons.map_outlined),
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

  Widget _buildJobSeekerStep3() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Text('Select your skills:',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black.withValues(alpha: 0.6))),
        const SizedBox(height: 16),
        Obx(() => Wrap(
              spacing: 12,
              runSpacing: 12,
              children: controller.suggestedSkills.map((skill) {
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
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
                child: _buildTextField(controller.customSkillController,
                    'Add other skill...', Icons.add)),
            const SizedBox(width: 12),
            IconButton(
              onPressed: controller.addCustomSkill,
              icon: const Icon(Icons.check_circle,
                  color: Colors.blueAccent, size: 32),
            )
          ],
        ),
        const SizedBox(height: 24),
        _buildTextField(
            controller.languageController, 'Languages Known', Icons.language),
      ],
    );
  }

  Widget _buildJobSeekerStep4() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Obx(() => CheckboxListTile(
              value: controller.isFresher.value,
              onChanged: (val) => controller.isFresher.value = val ?? false,
              title: const Text('I am a Fresher (No work experience)',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              activeColor: Colors.blueAccent,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            )),
        Obx(
          () => controller.isFresher.value
              ? const SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Divider(height: 32),
                    _buildTextField(controller.companyController,
                        'Company Name', Icons.business),
                    const SizedBox(height: 16),
                    _buildTextField(controller.roleController, 'Job Role',
                        Icons.work_outline),
                    const SizedBox(height: 16),
                    _buildTextField(controller.expYearsController,
                        'Experience (Years/Months)', Icons.access_time),
                    const SizedBox(height: 16),
                    _buildTextField(controller.currentSalaryController,
                        'Current Salary (LPA)', Icons.currency_rupee),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildJobSeekerStep5() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildTextField(controller.prefRoleController, 'Preferred Job Role',
            Icons.star_border),
        const SizedBox(height: 16),
        _buildTextField(controller.prefLocationController, 'Preferred Location',
            Icons.location_on_outlined),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
                child: _buildDropdown(controller.shiftPreference,
                    ['Day', 'Night', 'Flexible'], 'Shift', Icons.schedule)),
            const SizedBox(width: 16),
            Expanded(
                child: _buildDropdown(
                    controller.employmentType,
                    ['Full-time', 'Part-time', 'Contract'],
                    'Type',
                    Icons.work_history)),
          ],
        ),
        const SizedBox(height: 16),
        _buildDropdown(
            controller.noticePeriod,
            ['Immediate', '15 Days', '1 Month', '2 Months+'],
            'Notice Period',
            Icons.timer_outlined),
        const SizedBox(height: 16),
        Obx(() => CheckboxListTile(
              value: controller.willingToRelocate.value,
              onChanged: (val) =>
                  controller.willingToRelocate.value = val ?? false,
              title: const Text('Willing to Relocate',
                  style: TextStyle(fontSize: 15)),
              activeColor: Colors.blueAccent,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            )),
      ],
    );
  }

  Widget _buildJobSeekerStep6() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildUploadPlaceholder(
            'Upload PDF/DOCX Resume', Icons.description_outlined),
        const SizedBox(height: 32),
        const Text('Stand out to employers!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        _buildUploadPlaceholder('Upload Video Resume (Optional)',
            Icons.video_camera_front_outlined),
      ],
    );
  }

  Widget _buildTextField(
      TextEditingController textController, String label, IconData icon,
      {int maxLines = 1}) {
    return TextField(
      controller: textController,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.3)),
        prefixIcon: maxLines == 1
            ? Icon(icon, color: Colors.black.withValues(alpha: 0.4))
            : null,
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

  Widget _buildDropdown(
      RxString rxValue, List<String> items, String hint, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Obx(() => DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: rxValue.value,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down,
                  color: Colors.black.withValues(alpha: 0.4)),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Icon(icon,
                          size: 20, color: Colors.black.withValues(alpha: 0.4)),
                      const SizedBox(width: 12),
                      Text(value, style: const TextStyle(fontSize: 15)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) rxValue.value = newValue;
              },
            ),
          )),
    );
  }

  Widget _buildUploadPlaceholder(String label, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
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
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: Icon(icon, size: 40, color: Colors.blueAccent),
          ),
          const SizedBox(height: 16),
          Text(label,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueAccent)),
        ],
      ),
    );
  }
}

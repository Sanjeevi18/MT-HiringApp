import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'employer_onboarding_controller.dart';
import '../../../../shared/responsive_layout.dart';

class EmployerOnboardingView extends GetView<EmployerOnboardingController> {
  const EmployerOnboardingView({super.key});

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
          style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
        )),
        leading: Obx(() {
          // Hide back button if payment is successful to prevent going back to plans
          return (controller.currentStep.value > 0 && controller.paymentStatus.value != 'success')
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
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
        boxShadow: isMobile ? [] : [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 24, offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Obx(() => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (controller.currentStep.value + 1) / controller.steps.length,
              backgroundColor: Colors.grey.withValues(alpha: 0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              minHeight: 8,
            ),
          )),
          const SizedBox(height: 32),

          Obx(() => Text(
            controller.steps[controller.currentStep.value],
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.5, color: Colors.black87),
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
          
          // Hide standard bottom button on Payment Step (handled internally)
          Obx(() => controller.currentStep.value == 4 
            ? const SizedBox.shrink()
            : SizedBox(
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  onPressed: controller.nextStep,
                  child: Text(
                    controller.currentStep.value == 3 ? 'Proceed to Payment' : 'Continue',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }

  Widget _renderCurrentStepContent() {
    switch (controller.currentStep.value) {
      case 0: return _buildStep1Info();
      case 1: return _buildStep2Address();
      case 2: return _buildStep3Legal();
      case 3: return _buildStep4Subscription();
      case 4: return _buildStep5Payment();
      default: return const SizedBox.shrink();
    }
  }

  // ==========================================
  // STEP VIEWS
  // ==========================================

  Widget _buildStep1Info() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildUploadPlaceholder('Upload Company Logo', Icons.business_center),
        const SizedBox(height: 24),
        _buildTextField(controller.nameController, 'Company Name', Icons.business),
        const SizedBox(height: 16),
        _buildTextField(controller.industryController, 'Industry Type (e.g., IT, Manufacturing)', Icons.category_outlined),
        const SizedBox(height: 16),
        _buildDropdown(controller.companySize, controller.sizeOptions, 'Company Size', Icons.people_outline),
        const SizedBox(height: 16),
        _buildTextField(controller.emailController, 'Company Email', Icons.email_outlined),
        const SizedBox(height: 16),
        _buildTextField(controller.phoneController, 'Company Phone Number', Icons.phone_outlined),
        const SizedBox(height: 16),
        _buildTextField(controller.websiteController, 'Company Website', Icons.language),
        const SizedBox(height: 16),
        _buildTextField(controller.descController, 'Company Description', Icons.description_outlined, maxLines: 3),
      ],
    );
  }

  Widget _buildStep2Address() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildTextField(controller.addressController, 'Detailed Address', Icons.home_outlined, maxLines: 2),
        const SizedBox(height: 16),
        _buildTextField(controller.cityController, 'City', Icons.location_city),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildTextField(controller.stateController, 'State', Icons.map_outlined)),
            const SizedBox(width: 16),
            Expanded(child: _buildTextField(controller.pinCodeController, 'PIN Code', Icons.pin_drop_outlined)),
          ],
        )
      ],
    );
  }

  Widget _buildStep3Legal() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const Text('Legal Details (Optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        _buildTextField(controller.gstController, 'GST Number', Icons.receipt_long),
        const SizedBox(height: 16),
        _buildTextField(controller.panController, 'Company PAN Number', Icons.credit_card),
        const SizedBox(height: 16),
        _buildTextField(controller.cinController, 'CIN Number', Icons.numbers),
        const Divider(height: 48),
        const Text('Verification Documents', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        _buildUploadPlaceholder('Upload GST Certificate', Icons.file_present),
        const SizedBox(height: 16),
        _buildUploadPlaceholder('Company Registration Certificate', Icons.verified_outlined),
        const SizedBox(height: 16),
        _buildUploadPlaceholder('Upload Business License', Icons.assignment_outlined),
      ],
    );
  }

  Widget _buildStep4Subscription() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: controller.plans.keys.map((planName) {
        final plan = controller.plans[planName]!;
        return Obx(() {
          final isSelected = controller.selectedPlan.value == planName;
          return GestureDetector(
            onTap: () => controller.selectPlan(planName),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent.withValues(alpha: 0.05) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.blueAccent : Colors.grey.withValues(alpha: 0.2),
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(planName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      if (isSelected) const Icon(Icons.check_circle, color: Colors.blueAccent),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(plan['price'], style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.blueAccent)),
                      Text(plan['duration'], style: TextStyle(fontSize: 16, color: Colors.black.withValues(alpha: 0.5))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...List<Widget>.from(plan['features'].map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Icon(Icons.check, size: 16, color: Colors.black.withValues(alpha: 0.5)),
                        const SizedBox(width: 8),
                        Text(feature, style: TextStyle(color: Colors.black.withValues(alpha: 0.7))),
                      ],
                    ),
                  ))),
                ],
              ),
            ),
          );
        });
      }).toList(),
    );
  }

  Widget _buildStep5Payment() {
    return Center(
      child: Obx(() {
        if (controller.paymentStatus.value == 'processing') {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.blueAccent),
              const SizedBox(height: 24),
              const Text('Connecting to Payment Gateway...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('Do not close this screen', style: TextStyle(color: Colors.black.withValues(alpha: 0.5))),
            ],
          );
        }

        final planDetails = controller.plans[controller.selectedPlan.value]!;

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.check_circle, color: Colors.green, size: 64),
            ),
            const SizedBox(height: 32),
            const Text('Payment Successful!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
            const SizedBox(height: 8),
            Text('You have successfully subscribed to the ${controller.selectedPlan.value} Plan for ${planDetails['price']}.',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black.withValues(alpha: 0.6))),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blueAccent),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: controller.downloadInvoice,
                icon: const Icon(Icons.receipt_long, color: Colors.blueAccent),
                label: const Text('Download Invoice', style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                onPressed: controller.nextStep,
                child: const Text('Go to Dashboard', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        );
      }),
    );
  }

  // ==========================================
  // SHARED UI COMPONENTS
  // ==========================================

  Widget _buildTextField(TextEditingController textController, String label, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: textController,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: TextStyle(color: Colors.black.withValues(alpha: 0.3)),
        prefixIcon: maxLines == 1 ? Icon(icon, color: Colors.black.withValues(alpha: 0.4)) : null,
        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.06),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5)),
      ),
    );
  }

  Widget _buildDropdown(RxString rxValue, List<String> items, String hint, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(color: Colors.grey.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(16)),
      child: Obx(() => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: rxValue.value,
          isExpanded: true,
          icon: Icon(Icons.arrow_drop_down, color: Colors.black.withValues(alpha: 0.4)),
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Icon(icon, size: 20, color: Colors.black.withValues(alpha: 0.4)),
                  const SizedBox(width: 12),
                  Text(value, style: const TextStyle(fontSize: 15)),
                ],
              ),
            );
          }).toList(),
          onChanged: (newValue) { if (newValue != null) rxValue.value = newValue; },
        ),
      )),
    );
  }

  Widget _buildUploadPlaceholder(String label, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.2), width: 2, style: BorderStyle.solid),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(icon, size: 32, color: Colors.blueAccent),
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blueAccent)),
        ],
      ),
    );
  }
}